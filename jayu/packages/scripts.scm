(define-module (jayu packages scripts)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages xdisorg))

(define-public treeshot
  (package
   (name "treeshot")
   (version "0.1.1")
   (source
    (origin
     (method url-fetch/executable)
     (uri (string-append
            "https://gist.githubusercontent.com/nouun/"
            "8791a1a8f503367b4364660edb63928b/raw/"
            "84ed0c6cf79b253251e39c21b84c4f9d6c69099a/treeshot.sh"))
     (sha256
      (base32 "16dm7ilj034j8pc6601n23ar5vd4qdv9rv1inin0spn7q3syxb9x"))))
   (build-system trivial-build-system)
   (inputs (list imagemagick slop xclip))
   (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils))
        (let* ((out (assoc-ref  %outputs "out"))
               (bin (string-append out "/bin/"))
               (script (string-append bin "treeshot"))
               (source (assoc-ref %build-inputs "source")))
          (mkdir-p bin)
          (copy-file source script)
          (substitute* script
                       (("slop") (string-append ""
                                    (search-input-file %build-inputs "/bin/slop")))
                       (("xclip") (string-append ""
                                    (search-input-file %build-inputs "/bin/xclip"))))))))
   (home-page "https://gist.github.com/nouun/8791a1a8f503367b4364660edb63928b")
   (synopsis "Screenshot utility")
   (description "")
   (license license:expat)))

