(define-module (jayu packages nonfree)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages linux)
  #:use-module (guix licenses)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (ice-9 match)
  #:use-module (nonguix licenses))

(define-public b43-fwcutter
  (package
    (name "b43-fwcutter")
    (version "019")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://bues.ch/b43/fwcutter/"
                                  name "-" version ".tar.bz2"))
              (sha256
               (base32
                "1ki1f5fy3yrw843r697f8mqqdz0pbsbqnvg4yzkhibpn1lqqbsnn"))
              (patches
		(list
		  (local-file "../patches/b43-fwcutter-no-root-install.patch")))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f ; no tests
       #:make-flags (list (string-append "PREFIX=" %output)
                          ,(string-append "CC=" (cc-for-target)))
       #:phases (modify-phases %standard-phases
                  (delete 'configure))))
    (home-page "http://wireless.kernel.org/en/users/Drivers/b43")
    (synopsis "B43 firmware extractor")
    (description
     "Firmware extractor for cards supported by the b43 kernel module")
    (license (nonfree "TODO"))))

(define-public b43-firmware
  (package
    (name "b43-firmware")
    (version "6.30.163.46")
    (source (origin
              (method url-fetch)
              (uri (string-append "http://www.lwfinger.com/b43-firmware/"
                                  "broadcom-wl-" version ".tar.bz2"))
              (sha256
               (base32
                "0baw6gcnrhxbb447msv34xg6rmlcj0gm3ahxwvdwfcvq4xmknz50"))))
    (build-system trivial-build-system)
    (native-inputs (list bzip2 tar b43-fwcutter))
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((out (assoc-ref %outputs "out"))
               (source (assoc-ref %build-inputs "source"))
               (firmware-dir (string-append %output "/lib/firmware"))
               (tar (search-input-file %build-inputs "/bin/tar"))
               (bzip2-path
                (string-append (assoc-ref %build-inputs "bzip2") "/bin"))
               (b43-fwcutter
                (search-input-file %build-inputs "/bin/b43-fwcutter")))
           (setenv "PATH" bzip2-path)
           (mkdir-p out)
           (mkdir-p firmware-dir)
           (invoke tar "xjvf" source "-C" out)
           (invoke b43-fwcutter
                   "-w" firmware-dir
                   (string-append
                    out "/broadcom-wl-" ,version ".wl_apsta.o"))))))
    (home-page "http://www.lwfinger.com/b43-firmware")
    (synopsis "B43 firmware")
    (description "Firmware for cards supported by the b43 kernel module")
    (license (nonfree "TODO"))))

