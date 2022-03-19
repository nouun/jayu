(define-module (jayu home services xdisorg)
  #:use-module (gnu services configuration)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu home services)
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
  #:use-module (ice-9 regex)
  #:use-module (ice-9 common-list)

  #:export (home-rofi-service-type
            home-rofi-configuration))

(define-configuration/no-serialization home-rofi-configuration
  (package
   (package rofi)
   "Package to use for setting Rofi")
  (config (alist '())
   "rofi config")
  (theme (alist '())
   "theme config"))

(define color-regexp
  (make-regexp
   (string-append
    "("
    ;; #RGB
    "#[a-zA-Z0-9]{3}" "|"
    ;; #RGBA
    "#[a-zA-Z0-9]{4}" "|"
    ;; #RRGGBB
    "#[a-zA-Z0-9]{6}" "|"
    ;; #RRGGBBAA
    "#[a-zA-Z0-9]{8}" "|"
    ;; rgb(123, 123, 123)
    "rgba?. *[0-9]{1,3} *%? *, *[0-9]{1,3} *%? *, *[0-9]{1,3} *%? *" "|"
    ;; rgba(123, 123, 123, 0.1)
    "rgba?. *[0-9]{1,3} *%? *, *[0-9]{1,3} *%? *, *[0-9]{1,3} *%? *, [0-9]\\.[0-9]*" "|"
    ;; rgba(123, 123, 123, 100%)
    "rgba?. *[0-9]{1,3} *%? *, *[0-9]{1,3} *%? *, *[0-9]{1,3} *%? *, [0-9]{1,3} *% *"
    ;;children
    ")")))

(define (format-rofi-value val)
  (cond
   ((list? val)
    (string-join (map format-rofi-value val) " "))
   ((boolean? val)
    (if val "true" "false"))
   ((number? val)
    (string-append
     (object->string val)
     (if (not (eq? 0 val))
         "px" "")))
   ((symbol? val)
    (object->string val))
   ((string? val)
    (let ((color-match (regexp-exec color-regexp val)))
      (if (regexp-match? color-match)
          val (string-append "\"" val "\""))))
   (else val)))

(define (format-rofi-config config)
  (let ((key (object->string (car config)))
        (value (cdr config)))
    (define (format-children children)
      (string-append
       "[" (string-join (map object->string children) ",") "]"))
    (string-append key ": "
                   (if (eq? 'children (car config))
                       (format-children value)
                       (format-rofi-value value))
                   ";")))

(define (serialize-rofi-config config)
 (list
  (string-append
   "configuration {\n  "
   (string-join (map format-rofi-config config) "\n  ")
   "\n}\n")))

(define (format-rofi-theme theme)
  (let ((keys (map object->string (butlast theme 1)))
        (values (car (list-tail theme (- (length theme) 1)))))
   (string-append (string-join keys ", ")
                  " {\n  "
                  (string-join
                   (map format-rofi-config values)
                   "\n  ")
                  "\n}\n")))

(define (serialize-rofi-theme theme)
  (string-join (map format-rofi-theme theme) "\n"))

(define (home-rofi-files-service conf)
  `(("config/rofi/config.rasi"
     ,(apply mixed-text-file
        "config.rasi"
        (append
         ;; Main config
         (serialize-rofi-config
          (home-rofi-configuration-config conf))
         ;; Apply theme
         (if (not (eq? (home-rofi-configuration-theme conf) '()))
             (list "\n@theme \"guix\"\n") '()))))
    ("config/rofi/guix.rasi"
     ,(mixed-text-file
        "guix.rasi"
        (serialize-rofi-theme
         (home-rofi-configuration-theme conf))))))

(define (home-rofi-profile-service config)
  (list (home-rofi-configuration-package config)))

(define (home-rofi-extension old-config extension-configs)
  (match old-config
    (($ <home-rofi-configuration> _ package* config* theme*)
     (home-rofi-configuration
      (package package*)
      (config (append config*
                      (append-map home-rofi-configuration-config
                                  extension-configs)))
      (theme (append theme*
                     (append-map home-rofi-configuration-theme
                                 extension-configs)))))))

(define home-rofi-service-type
  (service-type (name 'home-rofi)
                (extensions
                 (list (service-extension
                        home-files-service-type
                        home-rofi-files-service)
                       (service-extension
                        home-profile-service-type
                        home-rofi-profile-service)))
                (compose concatenate)
                (extend home-rofi-extension)
                (default-value (home-rofi-configuration))
                (description "Configure Rofi")))

(define (generate-home-rofi-documentation)
  (generate-documentation
   `((home-rofi-configuration
      ,home-rofi-configuration-fields))
   'home-rofi-configuration))
