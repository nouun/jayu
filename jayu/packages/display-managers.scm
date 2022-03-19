(define-module (jayu packages display-managers)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (gnu packages))

(define-public verrb-sddm-theme
  (package
    (name "verrb-sddm-theme")
    (version "0.1.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/nouun/sddm-verrb")
                    (commit "6a118d02c68cc44ae70b4ef99b2340782618b625")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "05qkqrzdw5bf2fj6qrcpd6rlbgg841qg9cpgmgk0dwhk8czxdaic"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((out (assoc-ref %outputs "out"))
                (sddm-themes (string-append out "/share/sddm/themes")))
           (mkdir-p sddm-themes)
           (copy-recursively (assoc-ref %build-inputs "source")
                             (string-append sddm-themes "/verrb"))))))
    (home-page "https://github.com/nouun/sddm-verrb")
    (synopsis "Verrb theme for SDDM")
    (description "Verrb theme.")
    (license license:expat)))
