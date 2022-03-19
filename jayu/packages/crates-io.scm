(define-module (jayu packages crates-io)
  #:use-module (guix build-system cargo)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages image)
  #:use-module (gnu packages jemalloc)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages nettle)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages sequoia)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages webkit)
  #:use-module (srfi srfi-1))

(define-public rust-libssh-rs-0.1
  (package
    (name "rust-libssh-rs")
    (version "0.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "libssh-rs" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1rvj4j8cigs70x5pplfw7b9zjycjgcd9l9iwpqb45wkqn1y6ijn5"))))
    (build-system cargo-build-system)
    (arguments
      `(;#:phases
        ;(modify-phases %standard-phases
        ; (add-after 'configure 'patch-Cargo.toml
        ;   (lambda _
        ;     (substitute* '("Cargo.toml")
        ;       (("bitflags = \"1.3\"") "bitflags = \"1.2\"")))))
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-libssh-rs-sys" ,rust-libssh-rs-sys-0.1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-libssh-rs-sys-0.1
  (package
    (name "rust-libssh-rs-sys")
    (version "0.1.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "libssh-rs-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0hlackccfwq1hhjjkzkh6am583fnnqr4xxz36zjg6d7y9rfsb4nm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-openssl-sys" ,rust-openssl-sys-0.9)
        ;; Build dependencies:
        ("rust-cc" ,rust-cc-1)
        ("rust-pkg-config" ,rust-pkg-config-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-memmem-0.1
  (package
    (name "rust-memmem")
    (version "0.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "memmem" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "05ccifqgxdfxk6yls41ljabcccsz3jz6549l1h3cwi17kr494jm6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-quickcheck" ,rust-quickcheck-0.2))))
    (home-page "https://github.com/jneem/memmem")
    (synopsis "Substring searching")
    (description "")
    (license license:expat)))

(define-public rust-ordered-float-2.8
  (package
    (name "rust-ordered-float")
    (version "2.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ordered-float" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0bf63jdkdkyrlhfn04nl5h397fprzvvlpybf0bl53a5kg1ld1jcp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build?
       #t
       #:cargo-inputs
       (("rust-num-traits" ,rust-num-traits-0.2)
        ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs
       (("rust-serde-test" ,rust-serde-test-1))))
    (home-page "https://github.com/reem/rust-ordered-float")
    (synopsis "Wrappers for total ordering on floats")
    (description
     "This package provides wrappers for total ordering on floats in Rust.")
    (license license:expat)))

(define-public rust-leb128-0.2
  (package
    (name "rust-leb128")
    (version "0.2.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "leb128" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0rxxjdn76sjbrb08s4bi7m4x47zg68f71jzgx8ww7j0cnivjckl8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build?
       #t
       #:cargo-inputs
       (("rust-quickcheck" ,rust-quickcheck-0.8))))
    (home-page "https://github.com/wez/varbincode")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-varbincode-0.1
  (package
    (name "rust-varbincode")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "varbincode" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "17vgwalm7a1lryjj565p4rnx5h3hr8vwm5504r92s7j41f8gl4mp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build?
       #t
       #:cargo-inputs
       (("rust-byteorder" ,rust-byteorder-1)
        ("rust-leb128" ,rust-leb128-0.2)
        ("rust-serde" ,rust-serde-1)
        ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://github.com/wez/varbincode")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-textwrap-0.14
  (package
    (name "rust-textwrap")
    (version "0.14.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "textwrap" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "106xjfzfpk3nj51fx9slf9kyir7xjwvpqm003v9ardgq5b8whrh0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-hyphenation" ,rust-hyphenation-0.8)
        ("rust-terminal-size" ,rust-terminal-size-0.1)
        ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page
     "https://github.com/mgeisler/textwrap")
    (synopsis "Library for word wrapping, indenting, and dedenting strings")
    (description
     "Textwrap is a small library for word wrapping, indenting, and dedenting
strings.  You can use it to format strings (such as help and error messages)
for display in commandline applications.  It is designed to be efficient and
handle Unicode characters correctly.")
    (license license:expat)))

(define-public rust-metrics-macros-0.5
  (package
    (name "rust-metrics-macros")
    (version "0.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "metrics-macros" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1yjzi989pmjiixz3pwj95jrdpisdla4h7r91rzjpnx9z149hiqs9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-syn" ,rust-syn-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-metrics-macros-0.4
  (package
    (inherit rust-metrics-macros-0.5)
    (name "rust-metrics-macros")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "metrics-macros" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0gvzp0pbgxiqp5k3g6k62car88ycvp5jxj354pfqcy8m7m52x9ya"))))))

(define-public rust-metrics-0.17
  (package
    (name "rust-metrics")
    (version "0.17.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "metrics" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1a5alyl3gga92wi3gf9m8hp2vvvsni6klfw6vfa4ivd2akrl43x0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-ahash" ,rust-ahash-0.7)
        ("rust-metrics-macros" ,rust-metrics-macros-0.4)
        ("rust-criterion" ,rust-criterion-0.3)
        ("rust-log" ,rust-log-0.4)
        ("rust-rand" ,rust-rand-0.8)
        ("rust-trybuild" ,rust-trybuild-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-cint-0.2
  (package
    (name "rust-cint")
    (version "0.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cint" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0iywx93gawf39qb09w00algyk68dkq1v2hzhsyl8qib2pdcrjw00"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bytemuck" ,rust-bytemuck-1))))
    (home-page "https://github.com/termhn/cint")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-csscolorparser-0.5
  (package
    (name "rust-csscolorparser")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "csscolorparser" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1ghzs8i852slblyh6c52z17wc6pl50005y5rspim69gk7vckpyxj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-cint" ,rust-cint-0.2)
        ("rust-phf" ,rust-phf-0.8)
        ("rust-rgb" ,rust-rgb-0.8)
        ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs
       (("rust-serde-test" ,rust-serde-test-1))))
    (home-page "https://github.com/mazznoer/csscolorparser-rs")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-colorgrad-0.5
  (package
    (name "rust-colorgrad")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "colorgrad" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "01p35k866dgr84q4z9vdi8smm35kgmq74pkpykyw0hmlvk939j32"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-csscolorparser" ,rust-csscolorparser-0.5))
       #:cargo-development-inputs
       (("rust-serde-test" ,rust-serde-test-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-enum-display-derive-0.1
  (package
    (name "rust-enum-display-derive")
    (version "0.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "enum-display-derive" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1jhhhg2iqj0jdd43p4wbdgzsz1783bllw58sssaj494v59xz6vpi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-syn" ,rust-syn-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-filenamegen-0.2
  (package
    (name "rust-filenamegen")
    (version "0.2.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "filenamegen" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0slpi2kqiwsq07lzj8vclkcgdnv6zl1x1ashphc96jbhxzlacb8b"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-anyhow" ,rust-anyhow-1)
        ("rust-bstr" ,rust-bstr-0.1)
        ("rust-regex" ,rust-regex-1)
        ("rust-walkdir" ,rust-walkdir-2))
       #:cargo-development-inputs
       (("rust-nix" ,rust-nix-0.17)
        ("rust-pretty-assertions" ,rust-pretty-assertions-0.6)
        ("rust-tempdir" ,rust-tempdir-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-luajit-src-210
  (package
    (name "rust-luajit-src")
    (version "210.3.2+resty1085a4d")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "luajit-src" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "191vv51bikl4gbl4v709nfnzc8v3a9ghmz12vng5l8hkymb79qmi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-cc" ,rust-cc-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-lua-src-544
  (package
    (name "rust-lua-src")
    (version "544.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "lua-src" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "12y6by7xhqwpj8g5p94nskpvy1sfyiaiqxi0ra14j73qk81vlhbk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-cc" ,rust-cc-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))



(define-public rust-mlua-0.7
  (package
    (name "rust-mlua")
    (version "0.7.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "mlua" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "11mnfacanf03hvv91hcmdfgj3x2701j9h74wvbah30xa0m1ikqi9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bstr" ,rust-bstr-0.2)
        ("rust-num-traits" ,rust-num-traits-0.2)
        ("rust-once-cell" ,rust-once-cell-1)
        ("rust-rustc-hash" ,rust-rustc-hash-1)
        ;; Optional deps
        ("rust-lua-src" ,rust-lua-src-544)
        ("rust-luajit-src" ,rust-luajit-src-210)
        ("rust-erased-serde" ,rust-erased-serde-0.3)
        ("rust-futures-core" ,rust-futures-core-0.3)
        ("rust-futures-task" ,rust-futures-task-0.3)
        ("rust-futures-util" ,rust-futures-util-0.3)
        ("rust-serde" ,rust-serde-1)
        ;; Build deps
        ("rust-cc" ,rust-cc-1)
        ("rust-pkg-config" ,rust-pkg-config-0.3))
       #:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.3)
        ("rust-futures" ,rust-futures-0.3)
        ("rust-futures-timer" ,rust-futures-timer-3)
        ("rust-hyper" ,rust-hyper-0.14)
        ("rust-maplit" ,rust-maplit-1)
        ("rust-reqwest" ,rust-reqwest-0.11)
        ("rust-rustyline" ,rust-rustyline-9)
        ("rust-serde-json" ,rust-serde-json-1)
        ("rust-tokio" ,rust-tokio-1)
        ("rust-trybuild" ,rust-trybuild-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))


(define-public rust-serial-core-0.4
  (package
    (name "rust-serial-core")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial-core" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "10a5lvllz3ljva66bqakrn8cxb3pkaqyapqjw9x760al6jdj0iiz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-libc" ,rust-libc-0.2))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-ioctl-rs-0.1
  (package
    (name "rust-ioctl-rs")
    (version "0.1.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ioctl-rs" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0rrjmwd4fccid00kdnikv53jrvir9j6w96mqzrdkdi40wrmvscy7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-libc" ,rust-libc-0.2))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-serial-unix-0.4
  (package
    (name "rust-serial-unix")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial-unix" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1dyaaca8g4q5qzc2l01yirzs6igmhc9agg4w8m5f4rnqr6jbqgzh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-ioctl-rs" ,rust-ioctl-rs-0.1)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-serial-core" ,rust-serial-core-0.4)
        ("rust-termios" ,rust-termios-0.2))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-serial-windows-0.4
  (package
    (name "rust-serial-windows")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial-windows" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0ql1vjy57g2jf218bhmgr98i41faq0v5vzdx3g9payi6fsvx7ihm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-libc" ,rust-libc-0.2)
        ("rust-serial-core" ,rust-serial-core-0.4))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-serial-0.4
  (package
    (name "rust-serial")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "11iyvc1z123hn7zl6bk5xpf6xdlsb33qh6xa7g0pghqgayb7l8x1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-serial-core" ,rust-serial-core-0.4)
        ("rust-serial-unix" ,rust-serial-unix-0.4)
        ("rust-serial-windows" ,rust-serial-windows-0.4))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-libssh2-sys-0.2.23
  (package
    (inherit rust-libssh2-sys-0.2)
    (name "rust-libssh2-sys")
    (version "0.2.23")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "libssh2-sys" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
         (base32
          "1jplndqhlsygjmsni1ydb4zbw0j5jjr47bmqnjkwif5qnipa755h"))
        (modules '((guix build utils)))
        (snippet
         '(begin (delete-file-recursively "libssh2") #t))))))

(define-public rust-ssh2-0.9
  (package
    (name "rust-ssh2")
    (version "0.9.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ssh2" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1cgfwarj5k8s9fbf1pcnp27ifk30xk2f7q3sjca7l1ih8kk474r6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-libssh2-sys" ,rust-libssh2-sys-0.2.23)
        ("rust-parking-lot" ,rust-parking-lot-0.11))
       #:cargo-development-inputs
       (("rust-tempdir" ,rust-tempdir-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-euclid-0.22
  (package
    (name "rust-euclid")
    (version "0.22.6")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "euclid" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "102blw7ljphi7i2xg435z0bb0a4npmwwbgyfinqxg1m0af2q55ns"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-num-traits" ,rust-num-traits-0.2)
        ("rust-arbitrary" ,rust-arbitrary-1)
        ("rust-mint" ,rust-mint-0.5)
        ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs
       (("rust-serde-test" ,rust-serde-test-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-k9-0.11
  (package
    (name "rust-k9")
    (version "0.11.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "k9" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0pfcvqk3613m79qrf71qhdrdqgrfxxavzrm2904glaypjaccc7b1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-anyhow" ,rust-anyhow-1)
        ("rust-colored" ,rust-colored-1)
        ("rust-diff" ,rust-diff-0.1)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-syn" ,rust-syn-1)
        ("rust-term-size" ,rust-term-size-0.3)
        ("rust-regex" ,rust-regex-1))
       #:cargo-development-inputs
       (("rust-derive-builder" ,rust-derive-builder-0.9)
        ("rust-rand" ,rust-rand-0.7)
        ("rust-sha2" ,rust-sha2-0.9)
        ("rust-strip-ansi-escapes" ,rust-strip-ansi-escapes-0.1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-nonzero-ext-0.1
  (package
    (name "rust-nonzero-ext")
    (version "0.1.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nonzero-ext" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1sd85jx8r8xk67r1jx08vi0clk6qsjp14r50wgk7n81bjdil26yv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-compiletest-rs" ,rust-compiletest-rs-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-evmap-6
  (package
    (name "rust-evmap")
    (version "6.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "evmap" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "03rqfb1rp824dgq3pxz7v9lbc8jxp18m7yh2hwgwk0lv9h3n1nvg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bytes" ,rust-bytes-0.4)
        ("rust-hashbrown" ,rust-hashbrown-0.5)
        ("rust-smallvec" ,rust-smallvec-0.6))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-ratelimit-meter-5
  (package
    (name "rust-ratelimit-meter")
    (version "5.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ratelimit-meter" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "093py8kbnxd52mqdi61n3yrf6x7r5vcgiga82k80ky4y6salyzd3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-nonzero-ext" ,rust-nonzero-ext-0.1)
        ("rust-evmap" ,rust-evmap-6)
        ("rust-parking-lot" ,rust-parking-lot-0.9)
        ("rust-spin" ,rust-spin-0.5))
       #:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.2)
        ("rust-libc" ,rust-libc-0.2))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))


(define-public rust-rstest-0.12
  (package
    (inherit rust-rstest-0.6)
    (name "rust-rstest")
    (version "0.12.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rstest" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
          (base32 "0vv11n0wiqm70lyjc1byl22sqd1z1cpaq49yxrk9myd3ar8z64nr"))))))

(define-public rust-smol-potat-macro-0.6
  (package
    (name "rust-smol-potat-macro")
    (version "0.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "smol-potat-macro" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0cirpy1309cr3n6zbmia66miyidih88sinpanj2r61hqk89dhz3b"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-syn" ,rust-syn-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-smol-potat-1
  (package
    (name "rust-smol-potat")
    (version "1.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "smol-potat" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13nqzzqjscav3flc9jhwiabw8vnb22mv2accgilsn3swmxhzlkw9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-async-io" ,rust-async-io-1)
        ("rust-smol-potat-macro" ,rust-smol-potat-macro-0.6)
        ("rust-num-cpus" ,rust-num-cpus-1))
       #:cargo-development-inputs
       (("rust-smol" ,rust-smol-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-whoami-1
  (package
    (inherit rust-whoami-0.8)
    (name "rust-whoami")
    (version "1.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "whoami" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1s355zs8ir1li29cwvzgaqm6jyb51svmhqyx2hqgp8i0bbx5hjsj"))))))

(define-public rust-cocoa-0.20
  (package
    (inherit rust-cocoa-0.22)
    (name "rust-cocoa")
    (version "0.20.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cocoa" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1m0smdpg5fgsjjbx1x8mf01z8ml1i3ndj0248y5qggaidp43ciqa"))))))

(define-public rust-uds-windows-1
  (package
    (inherit rust-uds-windows-0.1)
    (name "rust-uds-windows")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "uds-windows" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0yg4c97zmh0g0vh55p6kjmvlh0nn52qh8vl1kzgy8dc5zchr74k5"))))))

(define-public rust-hdrhistogram-7
  (package
    (inherit rust-hdrhistogram-6)
    (name "rust-hdrhistogram")
    (version "7.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "hdrhistogram" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ya4hrvchzh0gk3kix1jspk8iii6cc8klnqcf8jfji2caw42ghmk"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-base64" ,rust-base64-0.10)
        ("rust-byteorder" ,rust-byteorder-1)
        ("rust-crossbeam-channel" ,rust-crossbeam-channel-0.4)
        ("rust-flate2" ,rust-flate2-1)
        ("rust-nom" ,rust-nom-4)
        ("rust-num-traits" ,rust-num-traits-0.2))))))

(define-public rust-http-req-0.8
  (package
    (inherit rust-http-req-0.5)
    (name "rust-http-req")
    (version "0.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "http_req" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0fmw063by838n1m6lnmnsxa6qn5w42988bbgq0mr29sph4wqz0kc"))))))

(define-public rust-pulldown-cmark-0.9
  (package
    (inherit rust-pulldown-cmark-0.8)
    (name "rust-pulldown-cmark")
    (version "0.9.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pulldown-cmark" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0j1mfklrn6j79apcisypfsii5dydagr4x909z5qplpxgs4a6bldc"))))))

(define-public rust-adler-1
  (package
    (inherit rust-adler-0.2)
    (name "rust-adler")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "adler" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0dsd94903arx9n5wc4nwpd89kjidm1s4zw5pbgwq1qpq1c9n5qnb"))))))

(define-public rust-miniz-oxide-0.5
  (package
    (inherit rust-miniz-oxide-0.4)
    (name "rust-miniz-oxide")
    (version "0.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "miniz_oxide" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "10phz3ppw4p8pz4rwniy3qkw95wiq64kbvpb0l8kjcrzpka9pcnj"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-adler" ,rust-adler-1)
        ("rust-autocfg" ,rust-autocfg-1)
        ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
        ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
        ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))))

(define-public rust-takeable-option-0.5
  (package
    (inherit rust-takeable-option-0.4)
    (name "rust-takeable-option")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "takeable-option" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "182axkm8pq7cynsfn65ar817mmdhayrjmbl371yqp8zyzhr8kbin"))))))

(define-public rust-glium-0.30
  (package
    (inherit rust-glium-0.25)
    (name "rust-glium")
    (version "0.30.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "glium" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "031r2p8yd883qs7q779qrlcfw0x7mc09qwr5f2zhr2djrajn668j"))))
    (arguments
     `(#:cargo-inputs
       (("rust-backtrace" ,rust-backtrace-0.3)
        ("rust-fnv" ,rust-fnv-1)
        ("rust-glutin" ,rust-glutin-0.21)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-smallvec" ,rust-smallvec-0.6)
        ("rust-takeable-option" ,rust-takeable-option-0.5))
       #:cargo-development-inputs
       (("rust-cgmath" ,rust-cgmath-0.17)
        ("rust-genmesh" ,rust-genmesh-0.6)
        ("rust-gl-generator" ,rust-gl-generator-0.11)
        ("rust-image" ,rust-image-0.21)
        ("rust-obj" ,rust-obj-0.9)
        ("rust-rand" ,rust-rand-0.6))))))

(define-public rust-glium-0.31
  (package
    (inherit rust-glium-0.30)
    (name "rust-glium")
    (version "0.31.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "glium" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "06cfsq3mgjlq3bnxv7jh5bb5is7040xyvf8cf1x45vnq8fdz1d0a"))))))

(define-public rust-adler32-1.2
  (package
    (inherit rust-adler32-1)
    (name "rust-adler32")
    (version "1.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "adler32" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
         (base32
          "0d7jq7jsjyhsgbhnfq5fvrlh9j0i9g1fqrl2735ibv5f75yjgqda"))))))

(define-public rust-deflate-1
  (package
    (inherit rust-deflate-0.9)
    (name "rust-deflate")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "deflate" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
         (base32
          "0bs319wa9wl7pn9j6jrrxg1gaqbak581rkx210cbix0qyljpwvy8"))))
    (arguments
     `(#:tests? #f      ; not all test files included
       #:cargo-inputs
       (("rust-adler32" ,rust-adler32-1.2)
        ("rust-gzip-header" ,rust-gzip-header-0.3))
       #:cargo-development-inputs
       (("rust-miniz-oxide" ,rust-miniz-oxide-0.3))))))

(define-public rust-png-0.17
  (package
    (name "rust-png")
    (version "0.17.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "png" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1fp3vnaxmjdv71dcakc21k07ir5s31dlx1mrazfqddzgaynw0f6w"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
        ("rust-crc32fast" ,rust-crc32fast-1)
        ("rust-deflate" ,rust-deflate-1)
        ("rust-miniz-oxide" ,rust-miniz-oxide-0.5))
       #:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.3)
        ("rust-getopts" ,rust-getopts-0.2)
        ("rust-glium" ,rust-glium-0.31)
        ("rust-glob" ,rust-glob-0.3)
        ("rust-rand" ,rust-rand-0.8)
        ("rust-term" ,rust-term-0.7))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-png-0.16
  (package
    (inherit rust-png-0.17)
    (name "rust-png")
    (version "0.16.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "png" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "19b2nzkw0kvibixsrnm5n5lgdx2hbsh5f87j17mjh1bbzkmwbmqj"))))))

(define-public rust-tiny-skia-0.6
  (package
    (name "rust-tiny-skia")
    (version "0.6.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tiny-skia" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0f511aac0ihzq0sq3d8gakkg4m8m5y7j0jyppvm4aifxkcrx9kqv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-arrayref" ,rust-arrayref-0.3)
        ("rust-arrayvec" ,rust-arrayvec-0.5)
        ("rust-bytemuck" ,rust-bytemuck-1)
        ("rust-cfg-if" ,rust-cfg-if-1)
        ("rust-libm" ,rust-libm-0.2)
        ("rust-png" ,rust-png-0.17)
        ("rust-safe-arch" ,rust-safe-arch-0.5))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-benchmarking-0.4
  (package
    (name "rust-benchmarking")
    (version "0.4.11")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "benchmarking" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1mmsf6shdxbl6vs3h83dsac5wkmna4jf12k0b801q5jry2g44drr"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-windows-gen-0.11
  (package
    (inherit rust-windows-gen-0.9)
    (name "rust-windows-gen")
    (version "0.11.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "windows_gen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1vvyxh0bvpwf4d4h9f06id21nkd3laa28x8i1z4a76xn9qal1ga4"))))))

(define-public rust-windows-macros-0.11
  (package
    (inherit rust-windows-macros-0.9)
    (name "rust-windows-macros")
    (version "0.11.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "windows_macros" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zsqnq8pkf0hj8byllvdszzsg43m3gnmvkxkyfxr4mxa0hp99rms"))))))

(define-public rust-windows-0.11
  (package
    (inherit rust-windows-0.9)
    (name "rust-windows")
    (version "0.11.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "windows" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1l2n7fnhcwpi9pkdzzwdi03ny67q909ma8pij6h2la517z571ci5"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-const-sha1" ,rust-const-sha1-0.2)
        ("rust-windows-gen" ,rust-windows-gen-0.11)
        ("rust-windows-macros" ,rust-windows-macros-0.11))))))

(define-public rust-unicode-general-category-0.3
  (package
    (name "rust-unicode-general-category")
    (version "0.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "unicode-general-category" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1v075r9rnfqknnmsdb8ak69g4vdk7f08h70sr8x62hcl3z3f5cga"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-async-broadcast-0.3
  (package
    (name "rust-async-broadcast")
    (version "0.3.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "async-broadcast" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0fs7zb66aqqmaja3vryymmmiz0x035gppja6p0php3i1l6c2cqlh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-easy-parallel" ,rust-easy-parallel-3)
        ("rust-event-listener" ,rust-event-listener-2)
        ("rust-futures-core" ,rust-futures-core-0.3))
       #:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.2)
        ("rust-doc-comment" ,rust-doc-comment-0.3)
        ("rust-futures-lite" ,rust-futures-lite-1)
        ("rust-futures-util" ,rust-futures-util-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-enumflags2-derive-0.7
  (package
    (inherit rust-enumflags2-derive-0.6)
    (name "rust-enumflags2-derive")
    (version "0.7.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "enumflags2_derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1kypbpy5fff2sqz964pzw0vh48j0n9ydnbvrqbkqr0i719vnylik"))))))

(define-public rust-enumflags2-0.7
  (package
    (inherit rust-enumflags2-0.6)
    (name "rust-enumflags2")
    (version "0.7.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "enumflags2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0c8ibfjpvrfjrzkj5h7kr19i5b164cy7573fbwixvzs2srbj4rx8"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-enumflags2-derive" ,rust-enumflags2-derive-0.7)
        ("rust-serde" ,rust-serde-1))))))

(define-public rust-ordered-stream-0.0.1
  (package
    (name "rust-ordered-stream")
    (version "0.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ordered-stream" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1cfc4mgsl29ij9g27hfxlk51jcg35kdv2ldapl46xzdckq2hqqs4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-futures-core" ,rust-futures-core-0.3)
        ("rust-pin-project-lite" ,rust-pin-project-lite-0.2))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-zbus-macros-2
  (package
    (name "rust-zbus-macros")
    (version "2.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zbus_macros" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0h4019bv9n5xhibjb6hf2xs85bxc5lk07284kyqwdhyx1z0kr0in"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-proc-macro-crate" ,rust-proc-macro-crate-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-regex" ,rust-regex-1)
        ("rust-syn" ,rust-syn-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-zvariant-derive-3
  (package
    (name "rust-zvariant-derive")
    (version "3.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zvariant_derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0ypvc7hk5yrpr1151nvxgxfikc5k2p6j8fk5gwzhaahwlv2yqb4c"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-proc-macro-crate" ,rust-proc-macro-crate-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-syn" ,rust-syn-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-zbus-names-2
  (package
    (name "rust-zbus-names")
    (version "2.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zbus_names" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1qdpqkyw3nzr927n8df4s6v692mqnyqjgk1hbm8as7dphz7wvps5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-serde" ,rust-serde-1)
        ("rust-static-assertions" ,rust-static-assertions-1)
        ("rust-zvariant" ,rust-zvariant-3))
       #:cargo-development-inputs
       (("rust-doc-comment" ,rust-doc-comment-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-zvariant-3
  (package
    (name "rust-zvariant")
    (version "3.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zvariant" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0cw03hwc03sak1zsc9hwx7hxrnj3h4w0k45plpkgln10ig1mvsj9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-byteorder" ,rust-byteorder-1)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-serde" ,rust-serde-1)
        ("rust-static-assertions" ,rust-static-assertions-1)
        ("rust-zvariant-derive" ,rust-zvariant-derive-3)
        ("rust-arrayvec" ,rust-arrayvec-0.7)
        ("rust-enumflags2" ,rust-enumflags2-0.7)
        ("rust-serde-bytes" ,rust-serde-bytes-0.11))
       #:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.3)
        ("rust-doc-comment" ,rust-doc-comment-0.3)
        ("rust-rand" ,rust-rand-0.8)
        ("rust-serde-json" ,rust-serde-json-1)
        ("rust-serde-repr" ,rust-serde-repr-0.1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-ntest-0.7
  (package
    (inherit rust-ntest-0.3)
    (name "rust-ntest")
    (version "0.7.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ntest" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0kkk30ixlvfc97gpdjfv5584qmkhgx3mnphqf6rl2sxfckzxrg5k"))))))

(define-public rust-zvariant-derive-3
  (package
    (name "rust-zvariant-derive")
    (version "3.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zvariant_derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0ypvc7hk5yrpr1151nvxgxfikc5k2p6j8fk5gwzhaahwlv2yqb4c"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-proc-macro-crate" ,rust-proc-macro-crate-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-syn" ,rust-syn-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-test-log-0.2
  (package
    (name "rust-test-log")
    (version "0.2.8")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "test-log" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "194i7mb4gi3a1mpid3n29q2xj8mr6l78qycc0wng8h4savncly7b"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-proc-macro2" ,rust-proc-macro2-1)
        ("rust-quote" ,rust-quote-1)
        ("rust-syn" ,rust-syn-1))
       #:cargo-development-inputs
       (("rust-env-logger" ,rust-env-logger-0.8)
        ("rust-log" ,rust-log-0.4)
        ("rust-tokio" ,rust-tokio-1)
        ("rust-tracing" ,rust-tracing-0.1)
        ("rust-tracing-futures" ,rust-tracing-futures-0.2)
        ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-async-channel-1.6
  (package
    (inherit rust-async-channel-1)
    (name "rust-async-channel")
    (version "1.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "async-channel" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "06b3sq2hd8qwl2xxlc4qalg6xw3l9b41w4sym9g0q70mf93dc511"))))))

(define-public rust-async-executor-1.4.1
  (package
    (inherit rust-async-executor-1)
    (name "rust-async-executor")
    (version "1.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "async-executor" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0rd9sd0rksvjwx4zzy6c69qcd7bwp3z42rpiiizfnbm2w2srn7w7"))))))

(define-public rust-futures-core-0.3.19
  (package
    (inherit rust-futures-core-0.3)
    (name "rust-futures-core")
    (version "0.3.19")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "futures-core" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1mw34nxzggvr2jvk4ljygy077wy32lrdxkyw1j0mj9dqc42gzj6h"))))))

(define-public rust-futures-sink-0.3.19
  (package
    (inherit rust-futures-sink-0.3)
    (name "rust-futures-sink")
    (version "0.3.19")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "futures-sink" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "026m2x353l7x7apa3hdx26ma7kwgxgbghl0393v4zmv8rfn5n1g3"))))))

(define-public rust-futures-util-0.3.19
  (package
    (inherit rust-futures-util-0.3)
    (name "rust-futures-util")
    (version "0.3.19")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "futures-util" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0r3i29hhfhv69qjdxh3j4ffxji4hl0yc1gmim1viy9vsni0czdfr"))))))

(define-public rust-zbus-2
  (package
    (name "rust-zbus")
    (version "2.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zbus" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "16jy4z8qbq9y32c0vqmxiqiyd2jgr6p455vin946mqlj8lynzf3v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-async-broadcast" ,rust-async-broadcast-0.3)
        ("rust-async-channel" ,rust-async-channel-1.6)
        ("rust-async-executor" ,rust-async-executor-1.4.1)
        ("rust-async-lock" ,rust-async-lock-2)
        ("rust-async-recursion" ,rust-async-recursion-0.3)
        ("rust-async-task" ,rust-async-task-4)
        ("rust-async-trait" ,rust-async-trait-0.1)
        ("rust-byteorder" ,rust-byteorder-1)
        ("rust-derivative" ,rust-derivative-2)
        ("rust-enumflags2" ,rust-enumflags2-0.7)
        ("rust-event-listener" ,rust-event-listener-2)
        ("rust-futures-core" ,rust-futures-core-0.3.19)
        ("rust-futures-sink" ,rust-futures-sink-0.3.19)
        ("rust-futures-util" ,rust-futures-util-0.3.19)
        ("rust-hex" ,rust-hex-0.4)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-nix" ,rust-nix-0.23)
        ("rust-once-cell" ,rust-once-cell-1)
        ("rust-ordered-stream" ,rust-ordered-stream-0.0.1)
        ("rust-rand" ,rust-rand-0.8)
        ("rust-serde" ,rust-serde-1)
        ("rust-serde-repr" ,rust-serde-repr-0.1)
        ("rust-sha1" ,rust-sha1-0.6)
        ("rust-static-assertions" ,rust-static-assertions-1)
        ("rust-winapi" ,rust-winapi-0.3)
        ("rust-zbus-macros" ,rust-zbus-macros-2)
        ("rust-zbus-names" ,rust-zbus-names-2)
        ("rust-zvariant" ,rust-zvariant-3)
        ("rust-async-io" ,rust-async-io-1)
        ("rust-serde-xml-rs" ,rust-serde-xml-rs-0.4)
        ("rust-tokio" ,rust-tokio-1))
       #:cargo-development-inputs
       (("rust-serde-test" ,rust-serde-test-1)
        ("rust-async-std" ,rust-async-std-1)
        ("rust-doc-comment" ,rust-doc-comment-0.3)
        ("rust-env-logger" ,rust-env-logger-0.8)
        ("rust-futures-util" ,rust-futures-util-0.3)
        ("rust-ntest" ,rust-ntest-0.7)
        ("rust-test-log" ,rust-test-log-0.2)
        ("rust-tokio" ,rust-tokio-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-yasna-0.3
  (package
    (name "rust-yasna")
    (version "0.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "yasna" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1nsdd1di06yvh6n2mv54wgvkl5fz155lbn7nhmna1wmlfbwvzrqd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bit-vec" ,rust-bit-vec-0.4)
        ("rust-num-bigint" ,rust-num-bigint-0.4)
        ("rust-time" ,rust-time-0.3))
       #:cargo-development-inputs
       (("rust-num-traits" ,rust-num-traits-0.2))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))


(define-public rust-x509-parser-0.13
  (package
    (inherit rust-x509-parser-0.12)
    (name "rust-x509-parser")
    (version "0.13.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "x509-parser" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0f3fqbv92q3a3s51md94sw3vgzs934agl4ii5a6ym364mkdlpwg5"))))))

(define-public rust-botan-src-0.21703
  (package
    (name "rust-botan-src")
    (version "0.21703.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "botan-src" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0s2ad9q84qsrllfsbj7hjhn7gr3hab9ng6lwzwqmimia6yvja8y8"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-botan-sys-0.8
  (package
    (name "rust-botan-sys")
    (version "0.8.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "botan-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1m11zblxfanrhl97j7z3ap7n17rr8j0rg91sr7f9j6y2bsniaz1x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-cty" ,rust-cty-0.2))
       #:cargo-development-inputs
       (("rust-botan-src" ,rust-botan-src-0.21703))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-botan-0.8
  (package
    (name "rust-botan")
    (version "0.8.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "botan" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "08bmiyn7c3b0dgx20w6hr28d9jcq7cj78cchr84pc686sb2s41ik"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-botan-sys" ,rust-botan-sys-0.8)
        ("rust-cty" ,rust-cty-0.2)
        ("rust-cstr-core" ,rust-cstr-core-0.2))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-pem-0.7
  (package
    (inherit rust-pem-1)
    (name "rust-pem")
    (version "0.7.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pem" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
          (base32 "14wpql0znpxrg6bq6lmp9kvbs9v24l0zzqqf3yj5d9spqxh1fn51"))))))

(define-public rust-rcgen-0.8
  (package
    (name "rust-rcgen")
    (version "0.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rcgen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zz3mqnnsz3lpkaz021pyfig2dh7wcgl1rzxm69qnla1vkx4ffs7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-ring" ,rust-ring-0.16)
        ("rust-time" ,rust-time-0.3)
        ("rust-yasna" ,rust-yasna-0.3)
        ("rust-pem" ,rust-pem-0.7)
        ("rust-x509-parser" ,rust-x509-parser-0.13)
        ("rust-zeroize" ,rust-zeroize-1))
       #:cargo-development-inputs
       (("rust-botan" ,rust-botan-0.8)
        ("rust-openssl" ,rust-openssl-0.10)
        ("rust-rand" ,rust-rand-0.8)
        ("rust-rsa" ,rust-rsa-0.5)
        ("rust-webpki" ,rust-webpki-0.22)
        ("rust-x509-parser" ,rust-x509-parser-0.13))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-svg-fmt-0.4
  (package
    (name "rust-svg-fmt")
    (version "0.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "svg_fmt" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1qjhciyls66jw9p4m7zy20ziqp39z9h44l0wzjfjxvhjyhaxzccg"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-guillotiere-0.6
  (package
    (name "rust-guillotiere")
    (version "0.6.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "guillotiere" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "10m7fhp5kzf09kz08k6apkbzblriyqynjl1wwa9i7jrnq1jmhbdn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-euclid" ,rust-euclid-0.22)
        ("rust-svg-fmt" ,rust-svg-fmt-0.4)
        ("rust-serde" ,rust-serde-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-line-drawing-0.8
  (package
    (name "rust-line-drawing")
    (version "0.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "line_drawing" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1chawny039jkj0lj6abkbykfbhk5wwilshn60fqh4c288bjh46gq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-num-traits" ,rust-num-traits-0.2))
       #:cargo-development-inputs
       (("rust-bresenham" ,rust-bresenham-0.1)
        ("rust-image" ,rust-image-0.23)
        ("rust-rand" ,rust-rand-0.8))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-resize-0.5
  (package
    (name "rust-resize")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "resize" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0v8g11d5s0ry8w11yfwsy2hgwj3rr4ma0wz20qdrqnicbiar60h4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-fallible-collections" ,rust-fallible-collections-0.4)
        ("rust-rgb" ,rust-rgb-0.8))
       #:cargo-development-inputs
       (("rust-png" ,rust-png-0.16))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-dlib-0.5
  (package
    (inherit rust-dlib-0.4)
    (name "rust-dlib")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "dlib" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1547hy7nrhkrb2i09va244c0h8mr845ccbs2d2mc414c68bpa6xc"))))))

(define-public rust-zstd-sys-1.4.20
  (package
    (inherit rust-zstd-sys-1)
    (name "rust-zstd-sys")
    (version "1.4.20+zstd.1.4.9")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zstd-sys" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13kc3crvqg021fya48jw0spfbxdli5anmry3w93r8bfgswrvgmgb"))))))

(define-public rust-wayland-commons-0.29
  (package
    (inherit rust-wayland-commons-0.28)
    (name "rust-wayland-commons")
    (version "0.29.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wayland-commons" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1dy2cgh5i77mzai1lircgc798834hkfcay6b0pd21ipgq1zkgmlk"))))
    (arguments
     `(#:cargo-inputs
       (("rust-nix" ,rust-nix-0.14)
        ("rust-wayland-sys" ,rust-wayland-sys-0.29))))))

(define-public rust-wayland-scanner-0.29
  (package
    (inherit rust-wayland-scanner-0.28)
    (name "rust-wayland-scanner")
    (version "0.29.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wayland-scanner" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1pg2vv827igqsg1vj56ldg4cla137qwzp2q195kq7ci6i4x08gbx"))))))

(define-public rust-wayland-sys-0.29
  (package
    (inherit rust-wayland-sys-0.28)
    (name "rust-wayland-sys")
    (version "0.29.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wayland-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0fnl49d45c6nbawy13x35ya0p10y55y4bnfzl9wi7glk1z9agwpy"))))))

(define-public rust-wayland-client-0.29
  (package
    (inherit rust-wayland-client-0.28)
    (name "rust-wayland-client")
    (version "0.29.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wayland-client" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1d39bvagy5n37y19lyspwdbmhipsf9gvs0qnck39z7pxn5rbmvkd"))))
    (arguments
     `(#:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
        ("rust-calloop" ,rust-calloop-0.4)
        ("rust-downcast-rs" ,rust-downcast-rs-1)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-mio" ,rust-mio-0.6)
        ("rust-nix" ,rust-nix-0.14)
        ("rust-wayland-commons" ,rust-wayland-commons-0.29)
        ("rust-wayland-sys" ,rust-wayland-sys-0.29)
        ("rust-wayland-scanner" ,rust-wayland-scanner-0.29))
       #:cargo-development-inputs
       (("rust-byteorder" ,rust-byteorder-1)
        ("rust-tempfile" ,rust-tempfile-3))))))

(define-public rust-wayland-cursor-0.29
  (package
    (inherit rust-wayland-cursor-0.28)
    (name "rust-wayland-cursor")
    (version "0.29.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wayland-cursor" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1d9b5nzqlf1fhsnv3w2m5xlaapihwhhbdabynn1f5d80dsi9g4dz"))))))

(define-public rust-wayland-protocols-0.29
  (package
    (inherit rust-wayland-protocols-0.28)
    (name "rust-wayland-protocols")
    (version "0.29.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wayland-protocols" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1mhcvwnwgyv98kkdcxgna65zd315cqg8qsv6lhj83wf0c7r46djh"))))))

(define-public rust-calloop-0.9
  (package
    (inherit rust-calloop-0.6)
    (name "rust-calloop")
    (version "0.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "calloop" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1rsacwcq39ilyd60pirada0ii4g093cjl193jalcw284infj7ypy"))))))

(define-public rust-nix-0.22.3
  (package
    (inherit rust-nix-0.22)
    (name "rust-nix")
    (version "0.22.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nix" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1bsgc8vjq07a1wg9vz819bva3dvn58an4r87h80dxrfqkqanz4g4"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
        ("rust-cc" ,rust-cc-1)
        ("rust-cfg-if" ,rust-cfg-if-1)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-memoffset" ,rust-memoffset-0.6))))))

(define-public rust-smithay-client-toolkit-0.15
  (package
    (name "rust-smithay-client-toolkit")
    (version "0.15.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "smithay-client-toolkit" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "12p627i1sg08mj9nb8d1zp4a82m348j96c2m0gapivlw429g498k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
        ("rust-dlib" ,rust-dlib-0.5)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-log" ,rust-log-0.4)
        ("rust-nix" ,rust-nix-0.22.3)
        ("rust-memmap2" ,rust-memmap2-0.3)
        ("rust-scoped-tls" ,rust-scoped-tls-1)
        ("rust-wayland-client" ,rust-wayland-client-0.29)
        ("rust-wayland-cursor" ,rust-wayland-cursor-0.29)
        ("rust-wayland-protocols" ,rust-wayland-protocols-0.29)
        ("rust-calloop" ,rust-calloop-0.9)
        ("rust-pkg-config" ,rust-pkg-config-0.3))
       #:cargo-development-inputs
       (("rust-image" ,rust-image-0.23))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-wayland-egl-0.29
  (package
    (inherit rust-wayland-egl-0.28)
    (name "rust-wayland-egl")
    (version "0.29.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wayland-egl" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13xd3r9li2g7jrs1rxggi4ar6izzgqwi1cgm1xki16chr7r8wmb4"))))))

(define-public rust-xcb-0.10
  (package
    (inherit rust-xcb-0.9)
    (name "rust-xcb")
    (version "0.10.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "xcb" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0j4i9bpax35b0hq65ha7cxzg8wmghallx16ajm8qhcdfcvv2kd9a"))))))

(define-public rust-xcb-imdkit-0.1
  (package
    (name "rust-xcb-imdkit")
    (version "0.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "xcb-imdkit" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "10b95w31x6fwdx86i04zx80dqf5y05h28gs9yny43bg656v24x37"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-calloop" ,rust-calloop-0.9)
        ("rust-xcb" ,rust-xcb-0.10)
        ("rust-pkg-config" ,rust-pkg-config-0.3)
        ("rust-cc" ,rust-cc-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-xcb-util-0.3
  (package
    (name "rust-xcb-util")
    (version "0.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "xcb-util" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0j0w9h79icwvmms7wjripj87wiaawfhg7vlz90fxixvvy93kx2a3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-libc" ,rust-libc-0.2)
        ("rust-xcb" ,rust-xcb-0.9))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-xkbcommon-0.5
  (package
    (name "rust-xkbcommon")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://api.github.com/repos/wez/xkbcommon-rs/tarball/"
             "5cc8f233ac2b8bfa0d7a26fd981b77e68c3f2219"))
       (file-name "wez-xkbcomman-rs-v0.4.0-5-g5cc8f23.tar.gz")
       (sha256
        (base32 "1m7sx0nlz1i8rv9wz3k6f6bwhdiqclwhgqx8sbkfmjanpla896yn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-libc" ,rust-libc-0.2)
        ("rust-memmap" ,rust-memmap-0.7)
        ("rust-xcb" ,rust-xcb-0.9))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-xcb-0.8
  (package
    (inherit rust-xcb-0.9)
    (name "rust-xcb")
    (version "0.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "xcb" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1ll36g7wm0xjqgm52injh68fhsq7qslpiym5jbwm7wvhpdb1kpfq"))))))

(define-public rust-x11-clipboard-0.3
  (package
    (inherit rust-x11-clipboard-0.5)
    (name "rust-x11-clipboard")
    (version "0.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "x11-clipboard" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ld8s391l7784m6gw9qv5zs7iqz3x3008sb8fzr9zckmzwqrf4ha"))))
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-xcb" ,rust-xcb-0.8))))))

(define-public rust-clipboard-0.5
  (package
    (name "rust-clipboard")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "clipboard" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1rxjfn811h09g6jpjjs2vx7z52wj6dxnflbwryfj6h03dij09a95"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-clipboard-win" ,rust-clipboard-win-2)
        ("rust-objc" ,rust-objc-0.2)
        ("rust-objc-foundation" ,rust-objc-foundation-0.1)
        ("rust-objc-id" ,rust-objc-id-0.1)
        ("rust-x11-clipboard" ,rust-x11-clipboard-0.3))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-clipboard-win-2.2
  (package
    (inherit rust-clipboard-win-2)
    (name "rust-clipboard-win")
    (version "2.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "clipboard-win" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0svqk0lrw66abaxd6h7l4k4g2s5vd1dcipy34kzfan6mzvb97873"))))))

(define-public rust-ndarray-0.14
  (package
    (inherit rust-ndarray-0.15)
    (name "rust-ndarray")
    (version "0.14.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ndarray" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "011wqzmrd9gpfcfvy1xfbskqfiahn96pmi2d0r9x34d682amq3bc"))))))

(define-public rust-version-sync-0.9
  (package
    (inherit rust-version-sync-0.8)
    (name "rust-version-sync")
    (version "0.9.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "version-sync" version))
        (file-name
         (string-append name "-" version ".tar.gz"))
        (sha256
         (base32
          "0k4y3q6ji75kiqvifhs64jlpy53p8lxq32abiywf2iln75vnhbrq"))))))

(define-public rust-smawk-0.3
  (package
    (name "rust-smawk")
    (version "0.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "smawk" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0hv0q1mw1r1brk7v3g4a80j162p7g1dri4bdidykrakzfqjd4ypn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs
       (("rust-ndarray" ,rust-ndarray-0.14))
       #:cargo-development-inputs
       (("rust-num-traits" ,rust-num-traits-0.2)
        ("rust-rand" ,rust-rand-0.8)
        ("rust-rand-chacha" ,rust-rand-chacha-0.3)
        ("rust-version-sync" ,rust-version-sync-0.9))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-unicode-linebreak-0.1
  (package
    (name "rust-unicode-linebreak")
    (version "0.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "unicode-linebreak" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0l5iykjbzv7595z7kpvzl8rb252l5ryba23hvb0f40gsqg1wfc2f"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-regex" ,rust-regex-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))

(define-public rust-openssl-src-300
  (package
    (name "rust-openssl-src")
    (version "300.0.4+3.0.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "openssl-src" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
         (base32 "1rr3gf7dl6415mxlrx6sd658h52lcj7jdanpp6143qj98mmiqvi1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1))))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:expat)))


(define-public rust-openssl-sys-0.9.71
  (package
    (inherit rust-openssl-sys-0.9)
    (name "rust-openssl-sys")
    (version "0.9.71")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "openssl-sys" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
         (base32 "0wscz8aqw4n6166sklz9fj5832iz2dpplxd4cfrhjyb0bqb3vwbx"))))
        ;(patches (search-patches "rust-openssl-sys-no-vendor.patch"))))))
    (arguments
     `(#:cargo-inputs
       (("rust-libc" ,rust-libc-0.2)
        ("rust-openssl-src" ,rust-openssl-src-300)
        ;; Build dependencies:
        ("rust-autocfg" ,rust-autocfg-1)
        ("rust-cc" ,rust-cc-1)
        ("rust-pkg-config" ,rust-pkg-config-0.3)
        ("rust-vcpkg" ,rust-vcpkg-0.2))))))


(define-public rust-weezl-0.1.5
  (package
    (inherit rust-weezl-0.1)
    (name "rust-weezl")
    (version "0.1.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "weezl" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13hy1zwnqrf021syjhz79mmi9bwwqjizzr0lnx5bwlx2spgpzdyq"))))))

