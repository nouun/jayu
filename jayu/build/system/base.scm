(define-module (jayu build system base)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu system)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages shells))

(define-public jayu-base-packages
  (append
    (map (compose list specification->package+output)
    '("curl" "dbus" "emacs" "gash" "git" "gnupg"
      "guile-readline" "ncurses" "nss-certs" "openssh"
      "wget" "vim" "xdg-user-dirs" "xdg-utils"))
    %base-packages))

(define-public jayu-file-services
  (list
    (extra-special-file "/usr/bin/env"
			(file-append coreutils "/usr/bin/env"))
    (extra-special-file "/bin/bash"
			(file-append bash "/bin/bash"))
    (extra-special-file "/bin/sh"
			(file-append dash "/bin/sh"))))

(define jayu-users
  (list
    (user-account
     (name "nouun")
     (comment "nouun")
     (home-directory "/home/nouun")
     (group "users")
     (supplementary-groups
       '("wheel" "netdev" "audio" "video"))
     (shell (file-append bash "/bin/bash")))))

(define-public jayu-base-users
  (append
     jayu-users
     %base-user-accounts))

(define-public jayu-base-system
  (operating-system
    (locale "en_NZ.utf8")
    (timezone "Pacific/Auckland")
    (host-name "guix")

    (users jayu-base-users)
    (packages jayu-base-packages)
    (services jayu-file-services)

    (bootloader
      (bootloader-configuration
	(bootloader grub-efi-bootloader)
	(targets (list "/boot/efi"))))

    ;; Guix requires file-system to be defined to create an operating-system
    ;; so pass through a dummy file system which will be overriden in each
    ;; machine configuration.
    (file-systems
      (cons* (file-system
	       (mount-point "/")
	       (device "none")
	       (type "ext4")
	       (check? #f))
	     %base-file-systems))))
