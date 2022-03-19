(define-module (jayu packages wm)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages wm))

(define-public kiwmi
  (package
    (name "kiwmi")
    (version "86e0f5b3fa9de1fa1ff58c431b32dbe48c5d3df8")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/buffet/kiwmi")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "17nam21r1lc13lsw8dwwka9qkb7fkycc23l317wl2d9g0ji09shg"))))
    (build-system meson-build-system)
    (arguments
     `(#:configure-flags '("-Dlua-pkg=luajit")))
    (inputs
     (list git
           luajit
           pixman
           wlroots))
    (native-inputs
     (list pkg-config wayland-protocols))
    (home-page "https://github.com/buffet/kiwmi")
    (synopsis "A fully programmable Wayland compositor")
    (description
     (string-append "kiwmi is a work-in-progress extensive user-configurable "
                    "Wayland Compositor. kiwmi specifically does not enforce "
                    "any logic, allowing for the creation of Lua-scripted "
                    "behaviors, making arduous tasks such as modal window "
                    "management become a breeze."))
    (license license:mpl2.0)))
