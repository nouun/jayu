(define-module (jayu packages rust-apps)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system cargo)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (jayu packages crates-io))

(define-public wezterm
  (package
    (name "wezterm")
    (version "20220101-133340-7edc5b5a")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/wez/wezterm")
            (commit version)))
      (file-name (git-file-name name version))
      (sha256
       (base32 "08wmljisa2dd1p2k57i7ahqb49ffyl3cqps5ggladx0lbqjm89dz"))
      (patches
	     (list
		       (local-file "../patches/wezterm-fix-cargo-git.patch")))))
    (build-system cargo-build-system)
    (inputs
     (list fontconfig zlib libx11 libxcb libssh2 libxkbcommon openssl
           wayland xcb-util xcb-util-image xcb-util-keysyms xcb-util-wm))
    (native-inputs
     `(("pkg-config" ,pkg-config)
       ("python" ,python)
       ("ncurses" ,ncurses)

       ;; Submodules
       ("harfbuzz-src"
        ,(origin
          (method git-fetch)
          (uri (git-reference
                (url "https://github.com/harfbuzz/harfbuzz/")
                (commit "0a129961341da370ec82bfccdd11ec9b1094b5a2")))
          (file-name "harfbuzz-src-checkout")
          (sha256
           (base32 "01n4wzya5sh8xp8zvaznz29lwar44fy19i3drxn7465qpx6011pi"))))
       ("libpng-src"
        ,(origin
          (method git-fetch)
          (uri (git-reference
                (url "https://github.com/glennrp/libpng/")
                (commit "8439534daa1d3a5705ba92e653eda9251246dd61")))
          (file-name "libpng-src-checkout")
          (sha256
           (base32 "032a19g3agjkjw44zih5c0hmhjbfi50zdp3772zng0i78nki3ryp"))))
       ("zlib-src"
        ,(origin
          (method git-fetch)
          (uri (git-reference
                (url "https://github.com/madler/zlib/")
                (commit "cacf7f1d4e3d44d871b605da3b647f07d718623f")))
          (file-name "zlib-src-checkout")
          (sha256
           (base32 "037v8a9cxpd8mn40bjd9q6pxmhznyqpg7biagkrxmkmm91mgm5lg"))))
       ("freetype2-src"
        ,(origin
          (method git-fetch)
          (uri (git-reference
                (url "https://github.com/wez/freetype2/")
                (commit "3f83daeecb1a78d851b660eed025eeba362c0e4a")))
          (file-name "freetype2-src-checkout")
          (sha256
           (base32 "1w9915a8pl5p4klw56a2qjq38a6g5iiw3fp1b1qblh5igyzgp213"))))))
    (arguments
     `(#:tests? #false
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'unpack-submodule-sources
           (lambda* (#:key inputs #:allow-other-keys)
             (mkdir-p "deps/harfbuzz/harfbuzz")
             (copy-recursively (assoc-ref inputs "harfbuzz-src")
                               "deps/harfbuzz/harfbuzz")
             (mkdir-p "deps/freetype/libpng")
             (copy-recursively (assoc-ref inputs "libpng-src")
                               "deps/freetype/libpng")
             (mkdir-p "deps/freetype/zlib")
             (copy-recursively (assoc-ref inputs "zlib-src")
                               "deps/freetype/zlib")
             (mkdir-p "deps/freetype/freetype2")
             (copy-recursively (assoc-ref inputs "freetype2-src")
                               "deps/freetype/freetype2")
             #t)))
      ;  (add-after 'install 'install-extras
      ;    (lambda* (#:key outputs #:allow-other-keys)
      ;      (let* ((out   (assoc-ref outputs "out"))
      ;             (share (string-append out "/share"))
      ;             (man1  (string-append share "/man/man1")))
      ;        (install-file "contrib/man/exa.1" man1)
      ;        (mkdir-p (string-append out "/etc/bash_completion.d"))
      ;        (mkdir-p (string-append share "/fish/vendor_completions.d"))
      ;        (mkdir-p (string-append share "/zsh/site-functions"))
      ;        (copy-file "contrib/completions.bash"
      ;                   (string-append out "/etc/bash_completion.d/exa"))
      ;        (copy-file "contrib/completions.fish"
      ;                   (string-append share "/fish/vendor_completions.d/exa.fish"))
      ;        (copy-file "contrib/completions.zsh"
      ;                   (string-append share "/zsh/site-functions/_exa"))
      ;        #t))))

       #:cargo-inputs
       (("rust-libssh-rs" ,rust-libssh-rs-0.1)
        ("rust-structopt" ,rust-structopt-0.3)
        ("rust-anyhow" ,rust-anyhow-1)
        ("rust-cassowary" ,rust-cassowary-0.3)
        ("rust-fnv" ,rust-fnv-1)
        ("rust-hex" ,rust-hex-0.4)
        ("rust-image" ,rust-image-0.23)
        ("rust-memmem" ,rust-memmem-0.1)
        ("rust-ordered-float" ,rust-ordered-float-2.8)
        ("rust-semver" ,rust-semver-0.11)
        ("rust-sha2" ,rust-sha2-0.9)
        ("rust-terminfo" ,rust-terminfo-0.7)
        ("rust-pretty-assertions" ,rust-pretty-assertions-0.6)
        ("rust-varbincode" ,rust-varbincode-0.1)
        ("rust-termios" ,rust-termios-0.3)
        ("rust-utf8parse" ,rust-utf8parse-0.2)
        ("rust-textwrap" ,rust-textwrap-0.14)
        ("rust-metrics" ,rust-metrics-0.17)
        ("rust-zstd" ,rust-zstd-0.6)
        ("rust-battery" ,rust-battery-0.7)
        ("rust-colorgrad" ,rust-colorgrad-0.5)
        ("rust-enum-display-derive" ,rust-enum-display-derive-0.1)
        ("rust-filenamegen" ,rust-filenamegen-0.2)
        ("rust-mlua" ,rust-mlua-0.7)
        ("rust-notify" ,rust-notify-4)
        ("rust-open" ,rust-open-2)
        ("rust-pretty-env-logger" ,rust-pretty-env-logger-0.4)
        ("rust-strsim" ,rust-strsim-0.10)
        ("rust-downcast-rs" ,rust-downcast-rs-1)
        ("rust-serial" ,rust-serial-0.4)
        ("rust-shell-words" ,rust-shell-words-1)
        ("rust-ssh2" ,rust-ssh2-0.9)
        ("rust-shared-library" ,rust-shared-library-0.1)
        ("rust-flume" ,rust-flume-0.10)
        ("rust-euclid" ,rust-euclid-0.22)
        ("rust-lru" ,rust-lru-0.7)
        ("rust-palette" ,rust-palette-0.5)
        ("rust-k9" ,rust-k9-0.11)
        ("rust-num" ,rust-num-0.3)
        ("rust-ratelimit-meter" ,rust-ratelimit-meter-5)
        ("rust-pest-derive" ,rust-pest-derive-2)
        ("rust-camino" ,rust-camino-1)
        ("rust-assert-fs" ,rust-assert-fs-1)
        ("rust-indoc" ,rust-indoc-1)
        ("rust-rstest" ,rust-rstest-0.12)
        ("rust-smol-potat" ,rust-smol-potat-1)
        ("rust-whoami" ,rust-whoami-1)
        ("rust-cocoa" ,rust-cocoa-0.20)
        ("rust-uds-windows" ,rust-uds-windows-1)
        ("rust-hdrhistogram" ,rust-hdrhistogram-7)
        ("rust-http-req" ,rust-http-req-0.8)
        ("rust-pulldown-cmark" ,rust-pulldown-cmark-0.9)
        ("rust-tiny-skia" ,rust-tiny-skia-0.6)
        ("rust-benchmarking" ,rust-benchmarking-0.4)
        ("rust-windows" ,rust-windows-0.11)
        ("rust-embed-resource" ,rust-embed-resource-1)
        ("rust-memmap2" ,rust-memmap2-0.2)
        ("rust-unicode-general-category" ,rust-unicode-general-category-0.3)
        ("rust-enumflags2-derive" ,rust-enumflags2-derive-0.7)
        ("rust-zbus" ,rust-zbus-2)
        ("rust-rcgen" ,rust-rcgen-0.8)
        ("rust-glium" ,rust-glium-0.30)
        ("rust-guillotiere" ,rust-guillotiere-0.6)
        ("rust-line-drawing" ,rust-line-drawing-0.8)
        ("rust-resize" ,rust-resize-0.5)
        ("rust-smithay-client-toolkit" ,rust-smithay-client-toolkit-0.15)
        ("rust-wayland-egl" ,rust-wayland-egl-0.29)
        ("rust-x11" ,rust-x11-2)
        ("rust-xcb" ,rust-xcb-0.9)
        ("rust-xcb-imdkit" ,rust-xcb-imdkit-0.1)
        ("rust-xcb-util" ,rust-xcb-util-0.3)
        ("rust-xcbcommon" ,rust-xkbcommon-0.5)
        ("rust-cgl" ,rust-cgl-0.3)
        ("rust-clipboard" ,rust-clipboard-0.5)
        ("rust-core-graphics" ,rust-core-graphics-0.19)
        ("rust-clipboard-win" ,rust-clipboard-win-2.2)
        ("rust-smawk" ,rust-smawk-0.3)
        ("rust-unicode-linebreak" ,rust-unicode-linebreak-0.1)
        ("rust-zstd-sys" ,rust-zstd-sys-1.4.20)
        ("rust-openssl-sys" ,rust-openssl-sys-0.9.71)
        ("rust-libloading" ,rust-libloading-0.7)
        ("rust-weezl" ,rust-weezl-0.1.5)
        ("rust-futures-util" ,rust-futures-util-0.3.19))))
    (home-page "https://wezfurlong.org/wezterm")
    (synopsis "Wezterm")
    (description "A GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust")
    (license license:expat)))
