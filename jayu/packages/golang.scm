(define-module (jayu packages golang)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages glib)
  #:use-module (guix build-system go))

(define-public go-github-com-alecthomas-kong
  (package
    (name "go-github-com-alecthomas-kong")
    (version "0.5.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/alecthomas/kong")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1lk4nb8ilvy0l5szj4s6wnz716vlz0v253423ykmph5l6bmips1k"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/alecthomas/kong"))
    (propagated-inputs
      `(("go-gopkg-in-yaml-v3" ,go-gopkg-in-yaml-v3)
        ("go-github-com-stretchr-testify" ,go-github-com-stretchr-testify)
        ("go-github-com-pkg-errors" ,go-github-com-pkg-errors)
        ("go-github-com-davecgh-go-spew" ,go-github-com-davecgh-go-spew)
        ("go-github-com-alecthomas-repr" ,go-github-com-alecthomas-repr)))
    (home-page "https://github.com/alecthomas/kong")
    (synopsis "Kong is a command-line parser for Go")
    (description
      "Package kong aims to support arbitrarily complex command-line structures with as
little developer effort as possible.")
    (license license:expat)))

(define-public go-github-com-atotto-clipboard
  (package
    (name "go-github-com-atotto-clipboard")
    (version "0.1.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/atotto/clipboard")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0ycd8zkgsq9iil9svhlwvhcqwcd7vik73nf8rnyfnn10gpjx97k5"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "github.com/atotto/clipboard"
       #:tests? #f))
    (home-page "https://github.com/atotto/clipboard")
    (synopsis "Clipboard for Go")
    (description "Package clipboard read/write on clipboard")
    (license license:bsd-3)))

(define-public go-github-com-ayntgl-discordgo
  (package
    (name "go-github-com-ayntgl-discordgo")
    (version "0.23.3-0.20220124081725-decdb6a611b6")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/ayntgl/discordgo")
               (commit "decdb6a611b685315b9e000112888f185b208213")))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0rz4gmr9ngs0jlds3ix75j1vbzlmhalca844s0jxcrp1fr7ih41b"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "github.com/ayntgl/discordgo"
       #:tests? #f))
    (propagated-inputs
      `(("go-golang-org-x-crypto" ,go-golang-org-x-crypto)
        ("go-github-com-gorilla-websocket" ,go-github-com-gorilla-websocket)))
    (home-page "https://github.com/ayntgl/discordgo")
    (synopsis "DiscordGo")
    (description "Package discordgo provides Discord binding for Go")
    (license license:bsd-3)))

(define-public go-github-com-gdamore-tcell-v2
  (package
    (name "go-github-com-gdamore-tcell-v2")
    (version "2.4.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/gdamore/tcell")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0kxpd2njknlp4a3wh7xs1pdk5h4y7ppi39z3vypg5m0fp9rfr0fk"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/gdamore/tcell/v2"))
    (propagated-inputs
      `(("go-golang-org-x-text" ,go-golang-org-x-text)
        ("go-golang-org-x-term" ,go-golang-org-x-term)
        ("go-golang-org-x-sys" ,go-golang-org-x-sys)
        ("go-github-com-mattn-go-runewidth" ,go-github-com-mattn-go-runewidth)
        ("go-github-com-lucasb-eyer-go-colorful"
         ,go-github-com-lucasb-eyer-go-colorful)
        ("go-github-com-gdamore-encoding" ,go-github-com-gdamore-encoding)))
    (home-page "https://github.com/gdamore/tcell")
    (synopsis #f)
    (description
      "Package tcell provides a lower-level, portable API for building programs that
interact with terminals or consoles.  It works with both common (and many
uncommon!) terminals or terminal emulators, and Windows console implementations.")
    (license license:asl2.0)))

(define-public go-github-com-rivo-tview
  (package
    (name "go-github-com-rivo-tview")
    (version "0.0.0-20220307222120-9994674d60a8")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/rivo/tview")
               (commit (go-version->git-ref version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0594ishcsd582apbz8jvhz8dg5i7nvyl3k6b6bzprf3z5kmsy9vk"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/rivo/tview"))
    (propagated-inputs
      `(("go-golang-org-x-term" ,go-golang-org-x-term)
        ("go-golang-org-x-sys" ,go-golang-org-x-sys)
        ("go-github-com-rivo-uniseg" ,go-github-com-rivo-uniseg)
        ("go-github-com-mattn-go-runewidth" ,go-github-com-mattn-go-runewidth)
        ("go-github-com-lucasb-eyer-go-colorful"
         ,go-github-com-lucasb-eyer-go-colorful)
        ("go-github-com-gdamore-tcell-v2" ,go-github-com-gdamore-tcell-v2)))
    (home-page "https://github.com/rivo/tview")
    (synopsis "Rich Interactive Widgets for Terminal UIs")
    (description
      "Package tview implements rich widgets for terminal based user interfaces.  The
widgets provided with this package are useful for data exploration and data
entry.")
    (license license:expat)))

(define-public go-github-com-alessio-shellescape
  (package
    (name "go-github-com-alessio-shellescape")
    (version "1.4.1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/alessio/shellescape")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "14zypi8qdxl77lks5b9jshr17idrm4sri1rxgpw5q4dys1palddd"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/alessio/shellescape"))
    (home-page "https://github.com/alessio/shellescape")
    (synopsis "shellescape")
    (description
      "Package shellescape provides the shellescape.Quote to escape arbitrary strings
for a safe use as command line arguments in the most common POSIX shells.")
    (license license:expat)))

(define-public go-github-com-danieljoos-wincred
  (package
    (name "go-github-com-danieljoos-wincred")
    (version "1.1.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/danieljoos/wincred")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1arcb0l6ipha7ydlb9rbig1phhd824m1n2qi7a16bgkn1mz2ay9n"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/danieljoos/wincred"))
    (propagated-inputs
      `(("go-golang-org-x-sys" ,go-golang-org-x-sys)
        ("go-github-com-stretchr-testify" ,go-github-com-stretchr-testify)))
    (home-page "https://github.com/danieljoos/wincred")
    (synopsis "wincred")
    (description
      "Package wincred provides primitives for accessing the Windows Credentials
Management API.  This includes functions for retrieval, listing and storage of
credentials as well as Go structures for convenient access to the credential
data.")
    (license license:expat)))

(define-public go-github-com-godbus-dbus
  (package
    (name "go-github-com-godbus-dbus")
    (version "5.1.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/godbus/dbus")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1kayd4x7idrhi06ahh5kqkgwzgh9icvv71mjar2d0jl486dfs8r5"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "github.com/godbus/dbus"
       #:tests? #f))
    (native-inputs (list dbus))
    (home-page "https://github.com/godbus/dbus")
    (synopsis "dbus")
    (description
      "Package dbus implements bindings to the D-Bus message bus system.")
    (license license:bsd-2)))

(define-public go-github-com-gorilla-websocket
  (package
    (name "go-github-com-gorilla-websocket")
    (version "1.5.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/gorilla/websocket")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1xrr6snvs9g1nzxxg05w4i4pq6k1xjljl5mvavd838qc468n118i"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/gorilla/websocket"))
    (home-page "https://github.com/gorilla/websocket")
    (synopsis "Gorilla WebSocket")
    (description
      "Package websocket implements the WebSocket protocol defined in
@url{https://rfc-editor.org/rfc/rfc6455.html,RFC 6455}.")
    (license license:bsd-2)))

(define-public go-github-com-lucasb-eyer-go-colorful
  (package
    (name "go-github-com-lucasb-eyer-go-colorful")
    (version "1.2.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/lucasb-eyer/go-colorful")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "08c3fkf27r16izjjd4w94xd1z7w1r4mdalbl53ms2ka2j465s3qs"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/lucasb-eyer/go-colorful"))
    (home-page "https://github.com/lucasb-eyer/go-colorful")
    (synopsis "go-colorful")
    (description
      "The colorful package provides all kinds of functions for working with colors.")
    (license license:expat)))

(define-public discordo
  (package
    (name "discordo")
    (version "0.0.0-20220317120010-a7cb969fc6b6")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/ayntgl/discordo")
               (commit (go-version->git-ref version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1nq3rgy9437nj6ccqwzp2hr25wyblr7s03drqzb1n6a3bmpinfkk"))))
    (build-system go-build-system)
    (arguments '(#:import-path "github.com/ayntgl/discordo"))
    (propagated-inputs
      `(("go-golang-org-x-text" ,go-golang-org-x-text)
        ("go-golang-org-x-term" ,go-golang-org-x-term)
        ("go-golang-org-x-sys" ,go-golang-org-x-sys)
        ("go-golang-org-x-crypto" ,go-golang-org-x-crypto)
        ("go-github-com-rivo-uniseg" ,go-github-com-rivo-uniseg)
        ("go-github-com-pkg-errors" ,go-github-com-pkg-errors)
        ("go-github-com-mattn-go-runewidth" ,go-github-com-mattn-go-runewidth)
        ("go-github-com-lucasb-eyer-go-colorful"
         ,go-github-com-lucasb-eyer-go-colorful)
        ("go-github-com-gorilla-websocket" ,go-github-com-gorilla-websocket)
        ("go-github-com-godbus-dbus" ,go-github-com-godbus-dbus)
        ("go-github-com-gdamore-encoding" ,go-github-com-gdamore-encoding)
        ("go-github-com-danieljoos-wincred" ,go-github-com-danieljoos-wincred)
        ("go-github-com-alessio-shellescape"
         ,go-github-com-alessio-shellescape)
        ("go-github-com-zalando-go-keyring" ,go-github-com-zalando-go-keyring)
        ("go-github-com-skratchdot-open-golang"
         ,go-github-com-skratchdot-open-golang)
        ("go-github-com-rivo-tview" ,go-github-com-rivo-tview)
        ("go-github-com-gdamore-tcell-v2" ,go-github-com-gdamore-tcell-v2)
        ("go-github-com-ayntgl-discordgo" ,go-github-com-ayntgl-discordgo)
        ("go-github-com-atotto-clipboard" ,go-github-com-atotto-clipboard)
        ("go-github-com-alecthomas-kong" ,go-github-com-alecthomas-kong)
        ("go-github-com-burntsushi-toml" ,go-github-com-burntsushi-toml)))
    (home-page "https://github.com/ayntgl/discordo")
    (synopsis "Discordo ·")
    (description
      "Discordo is a lightweight, secure, and feature-rich Discord terminal client.
Heavily work-in-progress, expect breaking changes.")
    (license license:expat)))

