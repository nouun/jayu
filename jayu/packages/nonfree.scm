(define-module (jayu packages nonfree)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages java)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages qt)
  #:use-module (guix licenses)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
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

(define-public ultimmc-cracked
  (package
    (name "ultimmc-cracked")
    (version "0.6.11")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/AfoninZ/UltimMC")
            (commit "a3b35986667ea82d77abbf22b9933daa56418657")))
      (file-name (git-file-name name version))
      (sha256
       (base32 "07k62gk4sbsaw8z73ha1scqkyrkg50r2rxfbll6aj6vk2m9bpxfz"))))
    (build-system cmake-build-system)
    (inputs
     (list
       qtbase-5
       openjdk9))
    (native-inputs
     `(("libnbtplusplus"
        ,(origin
          (method git-fetch)
          (uri (git-reference
                (url "https://github.com/MultiMC/libnbtplusplus")
                (commit "dc72a20b7efd304d12af2025223fad07b4b78464")))
          (file-name "librbtplusplus-src-checkout")
          (sha256
           (base32 "1m0lf00m4b2axi3c0jdhx2k17xk6kq8190ph22bm0zh5mayws2s2"))))
       ("quazip"
        ,(origin
          (method git-fetch)
          (uri (git-reference
                (url "https://github.com/MultiMC/quazip")
                (commit "b1a72ac0bb5a732bf887a535ab75c6f9bedb6b6b")))
          (file-name "quazip-src-checkout")
          (sha256
           (base32 "0c1mkvagay45ydl21ajzmjzsnaxkm7hbbd101gskg880c8rz9rzq"))))))
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'unpack-submodule-sources
           (lambda* (#:key inputs #:allow-other-keys)
             (mkdir-p "libraries/libnbtplusplus")
             (copy-recursively (assoc-ref inputs "libnbtplusplus")
                               "libraries/libnbtplusplus")
             (mkdir-p "libraries/quazip")
             (copy-recursively (assoc-ref inputs "quazip")
                               "libraries/quazip"))))))
    (home-page "https://github.com/AfoninZ/UltimMC")
    (synopsis "UltimMC Cracked.")
    (description
     "Cracked MultiMC launcher. Not related to original developers.")
    (license (nonfree "TODO"))))
