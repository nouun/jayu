(define-module (jayu build system pronouun)
  #:use-module (gnu)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages firmware)
  #:use-module (gnu packages messaging)
  #:use-module (gnu system)
  #:use-module (gnu services dns)
  #:use-module (gnu services networking)
  #:use-module (gnu services messaging)
  #:use-module (gnu services ssh)
  #:use-module (gnu services web)
  #:use-module (guix store)
  #:use-module (srfi srfi-1)
  #:use-module (jayu build system base))

(use-package-modules certs tls)

(define pronouun-packages
  (append
   (list nss-certs
	 certbot)
   jayu-base-packages))

(use-service-modules version-control)
  
  (define pronouun-git-daemon-service
    (service git-daemon-service-type))
;	     (git-daemon-configuration)))
;	      (base-path "/home/git/repositories/"))))

(define pronouun-fcgi-service
  (service fcgiwrap-service-type))

(use-service-modules cgit)
(use-package-modules version-control)

(define (cert-path host file)
  (format #f "/etc/letsencrypt/live/~a/~a.pem"
          host (symbol->string file)))

(define pronouun-cgit-nginx-configuration
  (nginx-server-configuration
   (root cgit)
   (server-name '("git.nouun.dev"
		  "www.git.nouun.dev"))
   (listen '("80"))
   (locations
    (list
     (nginx-location-configuration
      (uri "@cgit")
      (body '("fastcgi_param SCRIPT_FILENAME $document_root/lib/cgit/cgit.cgi;"
	      "fastcgi_param PATH_INFO $uri;"
	      "fastcgi_param QUERY_STRING $args;"
	      "fastcgi_param HTTP_HOST $server_name;"
	      "fastcgi_pass 127.0.0.1:9000;")))))
   (try-files (list "$uri" "@cgit"))
   (ssl-certificate (cert-path "git.nouun.dev"
                    'fullchain))
   (ssl-certificate-key (cert-path "git.karl.hallsby.com"
                        'privkey))))

(define pronouun-cgit-service
  (service cgit-service-type
	   (cgit-configuration
	    (enable-commit-graph? #t)
	    (enable-html-serving? #t)
	    (repository-directory "/home/cgit/repositories")
	    (nocache? #t)
	    (nginx
             (list
               pronouun-cgit-nginx-configuration)))))

(use-service-modules web)

(define pronouun-website-nginx-configuration
  (nginx-server-configuration
   (server-name '("nouun.dev"
		  "www.nouun.dev"))
   (listen '("80"))))
   ;(ssl-certificate (cert-path "git.nouun.dev"
   ;                 'fullchain))
   ;(ssl-certificate-key (cert-path "git.karl.hallsby.com"
   ;                     'privkey))))

(define pronouun-nginx-service
  (service nginx-service-type
	   (nginx-configuration
	    (server-blocks
	     (list pronouun-website-nginx-configuration)))))

(use-service-modules certbot)

(define pronouun-certbot-nginx-deploy-hook
  (program-file
   "nginx-deploy-hook"
    #~(let ((pid (call-with-input-file "/var/run/nginx/pid" read)))
        (kill pid SIGHUP))))

(define pronouun-certbot-service
  (service certbot-service-type
	   (certbot-configuration
	    (email "me@nouun.dev")
	    (certificates
	     (list
	      (certificate-configuration
	       (name "Website")
	       (domains '("nouun.dev"
			  "www.nouun.dev"))
               (deploy-hook
                  pronouun-certbot-nginx-deploy-hook))
	      (certificate-configuration
	       (name "Website")
	       (domains '("git.nouun.dev"
			  "www.git.nouun.dev"))
               (deploy-hook
                  pronouun-certbot-nginx-deploy-hook)))))))

(use-service-modules networking)

(define pronouun-dhcp-service
  (service dhcp-client-service-type))

(use-service-modules ssh)
(use-package-modules ssh)

(define pronouun-ssh-service
  (service openssh-service-type
           (openssh-configuration
            (openssh openssh-sans-x)
            (password-authentication? #t)
            (permit-root-login #f))))

(define pronouun-base-services
  (append
   jayu-file-services
   %base-services))

(define pronouun-services
  (append (list pronouun-git-daemon-service
                pronouun-fcgi-service
                pronouun-cgit-service
                pronouun-nginx-service
                pronouun-certbot-service
                pronouun-dhcp-service
                pronouun-ssh-service)
          pronouun-base-services
          jayu-file-services))

(define pronouun-users
  (list
    (user-account
     (name "git")
     (comment "git")
     (home-directory "/home/git")
     (group "users")
     (supplementary-groups
       '("wheel" "netdev" "audio" "video"))
     (shell (file-append bash "/bin/bash")))))

(define pronouun-swap
  (list (uuid "61c2aeba-85ed-4e02-a227-027ecbd115f0")))

(define pronouun-file-system
  (cons* (file-system
	   (mount-point "/")
	   (device
	     (uuid "b2b07395-cfd5-4133-86e2-5538eb0c0406"
		   'ext4))
	   (type "ext4"))
	 %base-file-systems))

(define verrb-file-system
    (cons* (file-system
             (mount-point "/")
             (device
               (uuid "e66d5096-1a1a-420d-92f0-b01cf7d103ea"
                     'ext4))
             (type "ext4"))
           (file-system
             (mount-point "/boot/efi")
             (device (uuid "A23F-3C5F" 'fat32))
             (type "vfat"))
           %base-file-systems))

  (operating-system
      (inherit jayu-base-system)
      (host-name "pronouun")
      (users pronouun-users)
;      (file-systems pronouun-file-system)
      (file-systems verrb-file-system)

      (packages pronouun-packages)
      (services pronouun-services))
