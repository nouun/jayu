(define-module (jayu home services compton)
  #:use-module (gnu services configuration)
  #:use-module (gnu packages compton)
  #:use-module (gnu services xorg)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home-services-utils)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (guix i18n)
  #:use-module (guix modules)
  #:use-module (guix diagnostics)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 match)

  #:export (home-picom-service-type
            home-picom-configuration))

(define-configuration/no-serialization home-picom-configuration
  (package
   (package picom)
   "Package to use for setting Picom")
  (config
   (alist '())
   ""))

(define (format-picom-list vals)
  (if (not (eq? vals '()))
      (let ((is-pair? (pair? (car vals))))
        (string-append
         (if is-pair? "{" "[")
         "\n  "
         (string-join
          (map (lambda (val)
                (if (pair? val)
                    (string-append
                     (maybe-object->string (car val))
                     " = " (format-picom-value (cdr val)) ";")
                    (format-picom-value val)))
               vals)
          (string-append
           (if is-pair? "" ",")
           "\n  "))
         "\n"
         (if is-pair? "}" "]")))
      "[]"))

(define (format-picom-value val)
  (cond
   ((list? val)
    (format-picom-list (car val)))
   ((pair? val)
    (format-picom-value `(,(car val))))
   ((boolean? val)
    (if val "true" "false"))
   ((or (symbol? val) (number? val))
    (maybe-object->string val))
   ((string? val)
    (string-append "\"" val "\""))
   (else val)))

(define (format-picom-config key val)
  (list (string-append (maybe-object->string key)
                       " = "
                       (format-picom-value val)
                       ";\n")))

(define (serialize-picom-config config)
  (generic-serialize-alist append format-picom-config config))

(define (home-picom-config-file config)
  (apply mixed-text-file
     "picom.conf"
     (serialize-picom-config
       (home-picom-configuration-config config))))

(define (home-picom-files-service config)
  `(("config/picom/picom.conf"
     ,(home-picom-config-file config))))

(define (home-picom-profile-service config)
  (list (home-picom-configuration-package config)))

(define (home-picom-shepherd-service config)
  (list
    (shepherd-service
      (documentation "Start Picom")
      (provision '(picom))
      ;; TODO: Figure out how to start when x starts
      ;(requirement '(xorg-server))
      (auto-start? #t)
      (start
       #~(make-system-constructor
          (string-join
            (list #$(file-append (home-picom-configuration-package config) "/bin/picom")
                  "--config" #$(home-picom-config-file config)
                  "-b"))))
      (stop #~(make-kill-destructor)))))

(define (home-picom-extension old-config extension-configs)
  (match old-config
    (($ <home-picom-configuration> _ package* config*)
     (home-picom-configuration
      (package package*)
      (config (append config*
                      (append-map home-picom-configuration-config
                                  extension-configs)))))))

(define home-picom-service-type
  (service-type (name 'home-picom)
                (extensions
                 (list (service-extension
                        home-files-service-type
                        home-picom-files-service)
                       (service-extension
                        home-profile-service-type
                        home-picom-profile-service)
                       (service-extension
                        home-shepherd-service-type
                        home-picom-shepherd-service)))
                (compose concatenate)
                (extend home-picom-extension)
                (default-value (home-picom-configuration))
                (description "Configure Picom")))

(define (generate-home-picom-documentation)
  (generate-documentation
   `((home-picom-configuration
      ,home-picom-configuration-fields))
   'home-picom-configuration))

