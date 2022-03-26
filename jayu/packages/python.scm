(define-module (jayu packages python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system python)
  #:use-module (gnu packages check)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages xml)
  #:use-module (srfi srfi-1))

(define-public python-spinners
  (package
    (name "python-spinners")
    (version "0.0.24")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "spinners" version))
        (sha256 (base32 "0zz2z6dpdjdq5z8m8w8dfi8by0ih1zrdq0caxm1anwhxg2saxdhy"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-before 'build 'patch-requirements-dev-txt
           (lambda _
             ;; Update requirements from dependency==version
             ;; to dependency>=version
             (substitute* "requirements-dev.txt"
               (("==") ">="))
             #t)))))
    (native-inputs
     `(("python-coverage" ,python-coverage)
       ("python-nose" ,python-nose)
       ("python-pylint" ,python-pylint)
       ("python-tox" ,python-tox)))
    (home-page "https://github.com/manrajgrover/py-spinners")
    (synopsis "More than 60 spinners for terminal")
    (description "More than 60 spinners for terminal, python wrapper for amazing node library cli-spinners.")
    (license expat)))

(define-public python-log-symbols
  (package
    (name "python-log-symbols")
    (version "0.0.14")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "log_symbols" version))
        (sha256 (base32 "0mh5d0igw33libfmbsr1ri1p1y644p36nwaa2w6kzrd8w5pvq2yg"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-before 'build 'patch-requirements-dev-txt
           (lambda _
             ;; Update requirements from dependency==version
             ;; to dependency>=version
             (substitute* "requirements-dev.txt"
               (("==") ">="))
             #t)))))
    (native-inputs
     `(("python-coverage" ,python-coverage)
       ("python-nose" ,python-nose)
       ("python-pylint" ,python-pylint)
       ("python-tox" ,python-tox)))
    (propagated-inputs
     `(("python-colorama" ,python-colorama)))
    (home-page "https://github.com/manrajgrover/py-log-symbols")
    (synopsis "Colored symbols for various log levels for Python")
    (description "Colored symbols for various log levels for Python.")
    (license expat)))

(define-public python-halo
  (package
    (name "python-halo")
    (version "0.0.31")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "halo" version))
        (sha256 (base32 "1mn97h370ggbc9vi6x8r6akd5q8i512y6kid2nvm67g93r9a6rvv"))))
    (build-system python-build-system)
    (native-inputs
     `(("python-coverage" ,python-coverage)
       ("python-nose" ,python-nose)
       ("python-pylint" ,python-pylint)
       ("python-tox" ,python-tox)
       ("python-twine" ,python-twine)))
    (propagated-inputs
     `(("python-log-symbols" ,python-log-symbols)
       ("python-spinners" ,python-spinners)
       ("python-termcolor" ,python-termcolor)
       ("python-colorama" ,python-colorama)
       ("python-six" ,python-six)))
    (home-page "https://github.com/manrajgrover/halo")
    (synopsis "Beautiful spinners for terminal, IPython and Jupyter")
    (description "Beautiful spinners for terminal, IPython and Jupyter.")
    (license expat)))

(define-public python-milc
  (package
    (name "python-milc")
    (version "1.6.5")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "milc" version))
        (sha256 (base32 "0bbqgyzzcq7hpp8xypd188ga49zf9kv7qljbd29ms9kvl45d9j5j"))))
    (build-system python-build-system)
    (propagated-inputs
     `(("python-appdirs" ,python-appdirs)
       ("python-argcomplete" ,python-argcomplete)
       ("python-colorama" ,python-colorama)
       ("python-halo" ,python-halo)
       ("python-spinners" ,python-spinners)))
    (home-page "https://milc.clueboard.co/")
    (synopsis "Batteries-Included Python 3 CLI Framework")
    (description "MILC is a framework for writing CLI applications in Python 3.6+.  It gives you all the features users expect from a modern CLI tool out of the box.")
    (license expat)))

(define-public python-hjson
  (package
    (name "python-hjson")
    (version "3.0.2")
    (source
     (origin
       ;; Sources on pypi don't contain data files for tests
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hjson/hjson-py")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256 (base32 "1jc7j790rcqnhbrfj4lhnz3f6768dc55aij840wmx16jylfqpc2n"))))
    (build-system python-build-system)
    (home-page "http://github.com/hjson/hjson-py")
    (synopsis "Human JSON implementation for Python")
    (description "Hjson is a syntax extension to JSON.  It is intended to be used like a user interface for humans, to read and edit before passing the JSON data to the machine.  This package contains a Python library for parsing and generating Hjson.")
    (license expat)))

(define-public python-qmk-dotty-dict
  (package
    (name "python-qmk-dotty-dict")
    (version "1.3.0.post1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "qmk_dotty_dict" version))
        (sha256 (base32 "18kyzk9a00xbxjsph2a9p03zx05f9dw993n66mlamgv06qwiwq9v"))))
    (build-system python-build-system)
    ;; TestDottyCache fails with "python3 setup.py test", but succeeds with
    ;; "pytest"; apparently it assumes that the test is always started in a
    ;; clean environment.
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (replace 'check
                    (lambda* (#:key tests? #:allow-other-keys)
                      (when tests?
                        (invoke "pytest")))))))
    (native-inputs
     `(("python-pytest" ,python-pytest)
       ("python-setuptools-scm" ,python-setuptools-scm)))
    (home-page "https://github.com/pawelzny/dotty_dict")
    (synopsis "Dictionary wrapper for quick access to deeply nested keys")
    (description "This is a fork of dotty-dict that fixes bugs with non-ASCII characters.")
    (license expat)))

(define-public python-hid
  (package
    (name "python-hid")
    (version "1.0.4")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "hid" version))
        (sha256 (base32 "1h9zi0kyicy3na1azfsgb57ywxa8p62bq146pb44ncvsyf1066zn"))))
    (build-system python-build-system)
    (arguments
     `(#:modules ((srfi srfi-1)
                  (srfi srfi-26)
                  (guix build utils)
                  (guix build python-build-system))
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'fix-hidapi-reference
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "hid/__init__.py"
               (("library_paths = \\(")
                (string-append
                 "library_paths = ('"
                 (find (negate symbolic-link?)
                       (find-files (assoc-ref inputs "hidapi")
                                   "^libhidapi-.*\\.so\\..*"))
                 "',")))
             #t)))))
    (inputs
     `(("hidapi" ,hidapi)))
    (native-inputs
     `(("python-nose" ,python-nose)))
    (home-page "https://github.com/apmorton/pyhidapi")
    (synopsis "hidapi bindings in ctypes")
    (description "Python wrapper for the hidapi library using ctypes.")
    (license expat)))
