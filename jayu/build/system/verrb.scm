(define-module (jayu build system verrb)
  #:use-module (gnu)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages firmware)
  #:use-module (gnu packages messaging)
  #:use-module (gnu system)
  #:use-module (gnu services desktop)
  #:use-module (gnu services dns)
  #:use-module (gnu services networking)
  #:use-module (gnu services messaging)
  #:use-module (gnu services sddm)
  #:use-module (gnu services ssh)
  #:use-module (gnu services web)
  #:use-module (gnu services xorg)
  #:use-module (guix store)
  #:use-module (srfi srfi-1)

  ; Nonfree packages: linux, b43-firmware 
  #:use-module (nongnu packages linux)
  #:use-module (jayu packages nonfree)

  #:use-module (jayu build system base)
  #:use-module (jayu packages display-managers)
  #:use-module (jayu packages extras)
  #:use-module (jayu packages rust-apps))

(define verrb-packages
  (append
   (list awesome-git
	 verrb-sddm-theme)
   (map (compose list specification->package+output)
	'("alsa-utils" "pulseaudio"))
   jayu-base-packages))

(define verrb-sddm-service
  (service sddm-service-type
           (sddm-configuration
            (theme "verrb"))))

(define verrb-bitlbee-service
  (service bitlbee-service-type
	   (bitlbee-configuration
	     (plugins
	       (list bitlbee-discord)))))

(define verrb-desktop-services
   (modify-services
     (remove (lambda (service)
	      (eq? (service-kind service) gdm-service-type))
	 %desktop-services)

     (guix-service-type
       config => (guix-configuration
		  (inherit config)
		  (extra-options '("--max-job=4"))))

     (network-manager-service-type
       config => (network-manager-configuration
		  (inherit config)
		  (dns "none")))))

(define verrb-services
  (append (list verrb-sddm-service
                verrb-bitlbee-service)
          verrb-desktop-services
          jayu-file-services))

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
  (host-name "verrb")
  (users jayu-base-users)
  (file-systems verrb-file-system)

  (packages verrb-packages)
  (services verrb-services)

  (kernel linux)
  (firmware (list b43-firmware)))
