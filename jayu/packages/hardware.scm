(define-module (jayu packages hardware)
  #:use-module (srfi srfi-1)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (guix packages)
  #:use-module (guix search-paths)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages avr)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages embedded)
  #:use-module (gnu packages flashing-tools)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages xml)
  #:use-module (jayu packages python))

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

(define-public qmk-avr-toolchain
  (qmk-wrap-toolchain "avr-toolchain"
                      avr-toolchain
                      "AVR"))

(define-public qmk-arm-none-eabi-nano-toolchain-7-2018-q2-update
  (qmk-wrap-toolchain "arm-none-eabi-nano-toolchain-7-2018-q2-update"
                      arm-none-eabi-nano-toolchain-7-2018-q2-update
                      "ARM_NONE_EABI_NANO"))

(define-public qmk
  (package
    (name "qmk")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri name version))
        (sha256 (base32 "1jpr22k539yc1rhn69igvh0s7hrd40vkkgmrn0vwqj257k3ywqns"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'fix-setup.py
           (lambda _
             (call-with-output-file "setup.py"
               (lambda (port)
                 (format port "\
from setuptools import setup
setup(name='qmk', version='~a', py_modules=['qmk'])
" ,version))))))))
    (propagated-inputs
     `(("arm-none-eabi-toolchain" ,qmk-arm-none-eabi-nano-toolchain-7-2018-q2-update)
       ("avr-toolchain" ,qmk-avr-toolchain)
       ("avrdude" ,avrdude)
       ("dfu-programmer" ,dfu-programmer)
       ("dfu-util" ,dfu-util)
       ("python-hid" ,python-hid)
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
