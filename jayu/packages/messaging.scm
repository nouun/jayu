(define-module (jayu packages messaging)
  #:use-module (gnu packages)
  #:use-module (gnu packages aidc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages messaging)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils))

(define-public purple-discord
  (let ((commit "8a0821b5ab946563e95c1d89e7ba789f698c65af"))
    (package
      (name "purple-discord")
      (version commit)
      (home-page "https://github.com/EionRobb/purple-discord")
      (source (origin
                (method git-fetch)
                (uri (git-reference (url home-page)
                                    (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "1giiikfyhzpav807whbnx31dbxgywqw06vx5rxbcmjzap3hzxr2a"))))
      (build-system gnu-build-system)
      (arguments
       `(#:phases
	 (modify-phases %standard-phases
           (replace 'configure
             (lambda* (#:key inputs outputs #:allow-other-keys)
               ;; Adjust the makefile to install files in the right
               ;; place.
               (let ((out (assoc-ref outputs "out")))
                 (substitute* "Makefile"
                   (("DISCORD_DEST = .*")
                    (string-append "DISCORD_DEST = " out
                                   "/lib/purple-2\n")) ;XXX: hardcoded
                   (("DISCORD_ICONS_DEST = .*")
                    (string-append "DISCORD_ICONS_DEST = "
                                   out
                                   "/share/pixmaps/pidgin/protocols\n"))
                   (("LOCALEDIR = .*")
                    (string-append "LOCALEDIR = "
                                   out
                                   "/share/locale\n")))
               #t))))
         #:make-flags (list "CC=gcc"
                            ,(string-append "PLUGIN_VERSION=" version))
         #:tests? #f))
      (inputs (list pidgin glib json-glib nss imagemagick gnu-gettext qrencode))
      (native-inputs (list pkg-config))
      (synopsis "Purple plug-in to access Discord instant messaging")
      (description
       "Purple-Discord is a plug-in for Purple, the instant messaging library
used by Pidgin and Bitlbee, among others, to access
@uref{https://discord.com/, Discord} servers.")
      (license license:gpl3+))))
