(define-module (jayu packages display-managers)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (gnu packages))

(define-public adverrb-sddm-theme
  (package
    (name "adverrb-sddm-theme")
    (version "0.1.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/nouun/sddm-adverrb")
                    (commit "d229f0e1d028ebc5bafbb7fdaf4c730d8ddc8f79")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "14vsl8cshl5hz8hvg6vwbbz16g1drjhgvv9xzc288wm2i1k9iz24"))))
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
                             (string-append sddm-themes "/adverrb"))))))
    (home-page "https://github.com/nouun/sddm-adverrb")
    (synopsis "Adverrb theme for SDDM")
    (description "Adverrb theme.")
    (license license:expat)))
