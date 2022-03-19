(define-module (jayu packages extras)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gperf)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages lsof)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages video)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (srfi srfi-26))

(define-public svp
  (package
   (name "svp")
   (version "4.5.210-1")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://www.svp-team.com/files/"
            "svp4-linux." version ".tar.bz2"))
     (sha256
      (base32 "10q8r401wg81vanwxd7v07qrh3w70gdhgv5vmvymai0flndm63cl"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils))
        (let* ((out (assoc-ref %outputs "out"))
               (tar (assoc-ref %build-inputs "tar"))
               (bin (string-append out "/bin"))
               (share (string-append out "/share"))
               (tmp (string-append out "/tmp"))
               (source (assoc-ref %build-inputs "source")))
         (mkdir-p bin)
         (mkdir-p share)
         (mkdir-p tmp)
         (invoke (string-append tar "/bin/tar") "xvf" source "-C" tmp)
         (invoke "sh" "-c" (string-append "cp -r " tmp "/svp4linux/* " share))
         (system* "ln" "--symbolic"
                  (string-append share "/SVPManager")
                  (string-append bin "/svp"))))))
   (inputs
    (list qtbase
          vapoursynth
          mediainfo
          lsof
          python))
   (native-inputs
    (list tar))
   (synopsis "")
   (description "")
   (home-page "")
   (license license:expat)))

(define-public awesome-git
 ;; Latest release is from January 2019 and is rather outdated.
 (let ((commit "392dbc21ab6bae98c5bab8db17b7fa7495b1e6a5")
       (revision "1"))
  (package
    (inherit awesome)
    (name "awesome-git")
    (version (git-version "4.3" revision commit))
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/awesomeWM/awesome")
             (commit commit)))
       (sha256
        (base32 "093zapjm1z33sr7rp895kplw91qb8lq74qwc0x1ljz28xfsbp496"))
       (modules '((guix build utils)
                  (srfi srfi-19)))
       (snippet
        '(begin
           ;; Remove non-reproducible timestamp and use the date of
           ;; the source file instead.
           (substitute* "common/version.c"
             (("__DATE__ \" \" __TIME__")
              (date->string
               (time-utc->date
                (make-time time-utc 0 (stat:mtime (stat "awesome.c"))))
               "\"~c\"")))
           #t))))
      ;(patches
      ; (search-patches "awesome-reproducible-png.patch"
      ;                 "awesome-4.3-fno-common.patch"))))
    (build-system cmake-build-system)
    (arguments
     `(#:modules ((guix build cmake-build-system)
                  (guix build utils)
                  (ice-9 match))
       ;; Let compression happen in our 'compress-documentation' phase
       ;; so that '--no-name' is used, which removes timestamps from
       ;; gzip output.
       #:configure-flags
       '("-DCOMPRESS_MANPAGES=off")
       ;; Building awesome in its source directory is no longer
       ;; supported.
       #:out-of-source? #t
       #:phases
       (modify-phases %standard-phases
         (add-before 'configure 'set-paths
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "lib/awful/completion.lua"
               (("/usr/bin/env")
                ""))
             ;; The build process needs to load Cairo dynamically.
             (let* ((cairo (string-append (assoc-ref inputs "cairo") "/lib"))
                    (lua-version ,(version-major+minor (package-version lua)))
                    (lua-dependencies
                     (filter (match-lambda
                               ((label . _) (string-prefix? "lua-" label)))
                             inputs))
                    (lua-path
                     (string-join
                      (map (match-lambda
                             ((_ . dir)
                              (string-append
                               dir "/share/lua/" lua-version "/?.lua;"
                               dir "/share/lua/" lua-version "/?/?.lua")))
                           lua-dependencies)
                      ";"))
                    (lua-cpath
                     (string-join
                      (map (match-lambda
                             ((_ . dir)
                              (string-append
                               dir "/lib/lua/" lua-version "/?.so;"
                               dir "/lib/lua/" lua-version "/?/?.so")))
                           lua-dependencies)
                      ";")))
               (setenv "LD_LIBRARY_PATH" cairo)
               (setenv "LUA_PATH" (string-append "?.lua;" lua-path))
               (setenv "LUA_CPATH" lua-cpath)
               (setenv "HOME" (getcwd))
               (setenv "XDG_CACHE_HOME" (getcwd)))))
         (replace 'check
           (lambda _
             ;; There aren't any tests, so just make sure the binary
             ;; gets built and can be run successfully.
             (invoke "../build/awesome" "-v")))
         (add-after 'install 'patch-session-file
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (awesome (string-append out "/bin/awesome")))
               (substitute* (string-append out "/share/xsessions/awesome.desktop")
                 (("Exec=awesome") (string-append "Exec=" awesome)))
               #t)))
         (add-after 'install 'wrap
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((awesome (assoc-ref outputs "out"))
                    (cairo (string-append (assoc-ref inputs "cairo") "/lib"))
                    (lua-version ,(version-major+minor (package-version lua)))
                    (lua-lgi (assoc-ref inputs "lua-lgi")))
               (wrap-program (string-append awesome "/bin/awesome")
                 `("LUA_PATH" ";" suffix
                   (,(format #f "~a/share/lua/~a/?.lua" lua-lgi lua-version)))
                 `("LUA_CPATH" ";" suffix
                   (,(format #f "~a/lib/lua/~a/?.so" lua-lgi lua-version)))
                 `("GI_TYPELIB_PATH" ":" prefix (,(getenv "GI_TYPELIB_PATH")))
                 `("LD_LIBRARY_PATH" suffix (,cairo)))
               #t)))))))))

