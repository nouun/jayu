;;; GNU Guix manifest for the QMK Firmware development environment
;;; Copyright © 2021 Sergey Vlasov <sigprof@gmail.com>
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; This manifest file can be used to set up a development environment for the
;; QMK Firmware (https://github.com/qmk/qmk_firmware):
;;
;;   $ guix environment --manifest=path/to/guix-manifest.scm
;;
;; The resulting environment provides the "qmk" command that can be used to
;; compile the QMK firmware, and also the required toolchains for Arm-based and
;; AVR-based MCUs; it also provides some common flashing tools that are used
;; with those MCUs.
;;
;; Note that the system-wide configuration such as udev rules is not handled
;; here, therefore commands such as "qmk flash" or "qmk console" that actually
;; need to access the hardware may fail if that setup is not done.

(use-modules
  (srfi srfi-1)
  (guix licenses)
  (guix packages)
  (guix download)
  (guix git-download)
  (guix build-system python)
  (guix build-system trivial)
  (guix search-paths))

(use-package-modules
  avr
  base
  bash
  check
  commencement
  compression
  embedded
  flashing-tools
  libusb
  python
  python-xyz
  version-control
  wget)

;; Some Python modules that are required by QMK are not yet packaged for Guix;
;; define packages for those modules here.

(define python-spinners
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

(define python-log-symbols
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

(define python-halo
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

(define python-milc
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

(define python-hjson
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

(define python-qmk-dotty-dict
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

(define python-hid
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

;; "python-qmk" is the QMK CLI package which provides the "qmk" command.

(define python-qmk
  (package
    (name "python-qmk")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "qmk" version))
        (sha256 (base32 "1jpr22k539yc1rhn69igvh0s7hrd40vkkgmrn0vwqj257k3ywqns"))))
    (build-system python-build-system)
    ;; The package does not come with a setup.py file, so we have to generate
    ;; one ourselves.
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'create-setup.py
           (lambda _
             (call-with-output-file "setup.py"
               (lambda (port)
                 (format port "\
from setuptools import setup
setup(name='qmk', version='~a', py_modules=['qmk'])
" ,version))))))))
    (propagated-inputs
     `(("python-hid" ,python-hid)
       ("python-pyusb" ,python-pyusb)
       ("python-milc" ,python-milc)
       ("python-setuptools" ,python-setuptools)
       ("python-hjson" ,python-hjson)
       ("python-jsonschema" ,python-jsonschema)
       ("python-pygments" ,python-pygments)
       ("python-qmk-dotty-dict" ,python-qmk-dotty-dict)))
    (home-page "https://qmk.fm/")
    (synopsis "QMK CLI is a program to help users work with QMK Firmware")
    (description "QMK CLI provides various functions for working with QMK Firmware: getting the QMK Firmware sources, setting up the build environment, compiling and flashing the firmware, accessing the debug console provided by the firmware, and many more functions used for the QMK Firmware configuration and development.")
    (license expat)))

;; Workaround for https://issues.guix.info/issue/39794#8 (the bug report is
;; closed, but the issue is not actually fixed) - all cross compilers use the
;; same CROSS_*_PATH environment variables, therefore including more than one
;; cross compiler in the profile breaks all of them except the last one,
;; because the include and library paths from all cross compilers get combined
;; into the same variables.

(define (qmk-wrap-toolchain toolchain-name toolchain-package toolchain-env-prefix)
  (let* ((wrapper-name (string-append "qmk-" toolchain-name))
         (modules '((guix build utils)))

         ;; List of search paths set by the toolchain that must be saved.
         (saved-search-paths
           (filter
             (lambda (search-path)
               (let* ((var (search-path-specification-variable search-path)))
                 (and (string-prefix? "CROSS_" var)
                      (string-suffix? "_PATH" var))))
             (package-transitive-native-search-paths toolchain-package)))

         ;; Association list that maps the original environment variable names
         ;; for search paths to the architecture specific environment variable
         ;; names (which must not collide between different toolchains).
         (search-path-var-names
           (map
             (lambda (search-path)
               (let* ((var (search-path-specification-variable search-path)))
                 (cons var (string-append toolchain-env-prefix "_" var))))
           saved-search-paths))

         ;; List of new search paths with architecture specific environment
         ;; variable names.
         (new-search-paths
           (map
             (lambda (search-path)
               (search-path-specification
                 (inherit search-path)
                 (variable
                   (assoc-ref search-path-var-names
                              (search-path-specification-variable search-path)))))
             saved-search-paths))

         ;; Shell code for setting the environment variable values that would
         ;; actually be used by the compiler from the architecture specific
         ;; environment variables.  The code is a sequence of lines like:
         ;;   VAR="${ARCH_VAR}" \
         ;; (the last line also contains a backslash and is intended to
         ;; combine with the "exec" statement at the next line in the shell
         ;; wrapper script).
         (search-path-copy-code
           (apply string-append
                  (map
                    (lambda (var-mapping)
                      (string-append (car var-mapping) "=\"${" (cdr var-mapping) "}\" \\\n"))
                    search-path-var-names))))

    ;; Generate a wrapper package with most properties copied from the original
    ;; toolchain package.
    (package
      (name wrapper-name)
      (version (package-version toolchain-package))
      (source #f)
      (build-system trivial-build-system)
      (arguments
       `(#:modules ,modules
         #:builder
         (begin
           ;; Generate wrapper scripts for all executables from the "gcc"
           ;; package in the toolchain.
           (use-modules ,@modules)
           (let* ((wrapper-bin-dir (string-append %output "/bin"))
                  (bash (assoc-ref %build-inputs "bash"))
                  (gcc (assoc-ref %build-inputs "gcc"))
                  (bash-binary (string-append bash "/bin/bash"))
                  (gcc-bin-dir (string-append gcc "/bin")))
             (mkdir %output)
             (mkdir wrapper-bin-dir)
             (for-each
               (lambda (bin)
                 (let* ((bin-name (basename bin))
                        (wrapper (string-append wrapper-bin-dir "/" bin-name)))
                   (call-with-output-file wrapper
                     (lambda (port)
                       (format port "#!~a~%~aexec ~a \"$@\"~%"
                               bash-binary
                               ,search-path-copy-code
                               bin)))
                   (chmod wrapper #o755)))
               (find-files gcc-bin-dir))
             #t))))
      (inputs
        `(("bash" ,bash)
          ("gcc" ,(first (assoc-ref (package-transitive-target-inputs toolchain-package) "gcc")))))
      (propagated-inputs
       `((,toolchain-name ,toolchain-package)))
      (native-search-paths new-search-paths)
      (synopsis (package-synopsis toolchain-package))
      (description (package-description toolchain-package))
      (home-page (package-home-page toolchain-package))
      (license (package-license toolchain-package)))))

(define qmk-avr-toolchain
  (qmk-wrap-toolchain "avr-toolchain"
                      avr-toolchain
                      "AVR"))

(define qmk-arm-none-eabi-nano-toolchain-7-2018-q2-update
  (qmk-wrap-toolchain "arm-none-eabi-nano-toolchain-7-2018-q2-update"
                      arm-none-eabi-nano-toolchain-7-2018-q2-update
                      "ARM_NONE_EABI_NANO"))

;; Finally make the manifest with all required packages.

(packages->manifest
  (list

    ;; Toolchains
    qmk-arm-none-eabi-nano-toolchain-7-2018-q2-update
    qmk-avr-toolchain

    ;; Flashing tools
    avrdude
    dfu-programmer
    dfu-util
    teensy-loader-cli

    ;; Other tools required for build
    git
    gnu-make
    python

    ;; QMK CLI
    python-qmk))
