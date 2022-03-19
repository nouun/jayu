(define-module (jayu build home nouun)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu services)
  #:use-module (gnu packages)
  #:use-module (jayu packages wm)
  #:use-module (jayu packages golang)
  #:use-module (jayu packages messaging))

(define (list->pkgs lst)
  (map specification->package+output lst))

(define general-packages
  (list->pkgs
   `("qutebrowser" ;; Qutebrowser seems to have an issue loading GitHub.
     "ungoogled-chromium"
     "imagemagick")))

(define x11-packages
  (list->pkgs
   `("rofi"
     "maim"
     "xclip"
     "xterm")))

(define wayland-packages
  (append
   (list kiwmi)
   (list->pkgs
     `("foot"
       "wofi"
       "swaybg"))))

(define communication-packages
  (append
   ;(list discordo)
   (list->pkgs
    `("weechat"))))

(define development-packages
  (list->pkgs
    `("jq")))

(define font-packages
  (list->pkgs
   `("font-iosevka"
     "font-fira-mono"
     "font-fira-code"
     "font-google-noto"
     "font-gnu-freefont"
     "font-awesome"
     "font-google-material-design-icons")))

(define nouun-packages
  (append
    general-packages
    x11-packages
    ; wayland-packages
    development-packages
    communication-packages
    font-packages))

(use-modules (gnu home)
             (gnu services)
             (gnu home services)
             (gnu home-services terminals))

(define alacritty-services
  (list
    (service home-alacritty-service-type
      (home-alacritty-configuration
        (config
          `((font . ((normal . ((font  . "Noto Sans Mono")))
                     (bold   . ((font  . "Noto Sans Mono")
                                (style . "bold")))
                     (italic . ((font  . "Noto Sans Mono")
                                (style . "light")))
                     (size   . 10.0)))
            (window . ((padding . ((x . 20)
                                   (y . 20)))))
            (colors . ((primary . ((background . "#F5E9DA")
                                   (foreground . "#575279")))
                       (normal . ((black   . "#232136")
                                  (red     . "#AD4741")
                                  (green   . "#569F84")
                                  (yellow  . "#EA9D34")
                                  (blue    . "#307E9D")
                                  (magenta . "#907AA9")
                                  (cyan    . "#56959F")
                                  (white   . "#F2E9DE")))
                       (bright . ((black   . "#575279")
                                  (red     . "#D7827E")
                                  (green   . "#87BEA9")
                                  (yellow  . "#F0BA71")
                                  (blue    . "#73B8D4")
                                  (magenta . "#B1A2C3")
                                  (cyan    . "#87B6BE")
                                  (white   . "#FAF4ED")))))))))))

(define bash-services
  (list))

(use-modules (gnu)
	       (gnu packages shellutils)
	       (gnu home services)
	       (gnu home-services base)
	       (gnu home-services shellutils)
	       (guix gexp))


(define-public direnv-services
  (list
    (simple-service 'direnv-service
		    home-files-service-type
		    `(("config/direnv/direnvrc"
		       ,(plain-file "direnverc" "\
use_guix() {
  local cache_dir=\"$(direnv_layout_dir)/.guix-profile\"
  if [[ -e \"$cache_dir/etc/profile\" ]]; then
    # shellcheck disable=SC1091
    source \"$cache_dir/etc/profile\"
  else
    mkdir -p \"$(direnv_layout_dir)\"
    eval \"$(guix environment --root=\"$cache_dir\" \"$@\" --search-paths)\"
  fi
}
"))))

    (service home-zsh-direnv-service-type)
    (service home-bash-direnv-service-type)

    (home-generic-service 'direnv-packages
      #:packages (list direnv))))

(use-modules (gnu home)
	       (gnu packages version-control)
	       (gnu services)
	       (gnu home services)
	       (gnu home-services base)
	       (gnu home-services version-control))

(define-public git-services
  (list
    (service home-git-service-type
      (home-git-configuration
	(config
	  `((user
	      ((name . "nouun") 
	       (email . "me@nouun.dev")))
	    (github
	      ((user . "nouun")))))
	   ; ;; TODO: setup credential manager
	   ;(credential
	   ;  ((helper . "/usr/share/git/credential/libsecret/git-credential-libsecret")))))
	(ignore
	  '(".envrc"))))

    (home-generic-service 'git-packages
      #:packages (list git))))

(use-modules (gnu home)
	       (gnu packages compton)
	       (gnu services)
	       (gnu home services)
	       (gnu home-services base)
	       (jayu home services compton))

(define-public picom-services
  (list
   (service home-picom-service-type
	    (home-picom-configuration
	     (config
	      `((shadow . #t)
		(shadow-radius . 25)
		(shadow-offset-x . -20)
		(shadow-offset-y . -20)
		(shadow-opacity . 0.5)
		(shadow-exclude ("name = 'Notification'"
				 "name = 'Icecat'"
				 "name = 'Test'"))
		(menu ((shadow . #f)))))))

   (home-generic-service 'picom-packages
    #:packages (list picom))))

(use-modules (gnu home)
             (gnu services)
             (jayu home services xdisorg))

(define-public rofi-services
  (list
   (service home-rofi-service-type
	    (home-rofi-configuration
	     (config
	      `((kb-mode-next     . "Shift+Right")
		(kb-mode-previous . "Shift+Left")
		(columns          . 1)))
	     (theme
	      `((* ((fg-lighter . "rgba( 87,  82, 121,  70%)")
		    (fg         . "rgba( 87,  82, 121, 100%)")
		    (fg-darker  . "rgba( 35,  33,  54, 100%)")
		    (bg         . "rgba(245, 233, 218, 100%)")
		    (bg-darker  . "rgba(237, 215, 189, 100%)")
		    (bar        . "rgba(144, 122, 169, 100%)")))
		(window ((background-color . @bg)
			 (border-color     . @bar)
			 (border           . (32 0 0 0))))
		(mainbox ((children     . (sidebar inputbar
					   dummy listview))
			  (background-color . @bg)
			  (padding          . 10)
			  (spacing          . 0)))
		(sidebar ((background-color . transparent)
			  (spacing          . 0)))
		(button ((background-color . @bg)
			 (text-color       . @fg)
			 (padding          . 10)
			 (cursor           . pointer)
			 (expand           . #f)))
		(button.selected ((background-color . @bg-darker)
				  (text-color       . @fg)))
		(inputbar ((background-color . @bg)
			   (text-color       . @fg)
			   (padding          . 20)
			   (spacing          . 10)))
		(prompt ((background-color . @fg)
			 (text-color       . @bg)
			 (enabled          . #f)))
		(case-indicator entry ((background-color . @bg)
				       (text-color       . @fg)))
		(entry ((cursor . text)
			(placeholder . "filter...")
			(placeholder-color . @fg-lighter)))
		(dummy ((background-color . transparent)
			(expand           . #f)
			(padding          . (5 0 0 0))))
		(listview ((background-color . @bg)
			   (spacing          . 0)))
		(element ((background-color . transparent)
			  (padding          . 10)
			  (cursor           . pointer)))
		(element.selected.normal
		 element.selected.urgent
		 element.selected.active
		 element-text.selected ((background-color . @bg-darker)
					(text-color       . @fg)))
		(element.normal.normal
		 element.normal.urgent
		 element.normal.active
		 element.alternate.normal
		 element.alternate.urgent
		 element.alternate.active ((background-color . @bg)
					   (text-color       . @fg)))
		(element-text ((background-color . transparent)
			       (text-color . @fg)))))))))

(use-modules (gnu home)
             (gnu packages shells)
             (gnu home-services shells)
             (gnu services)
             (gnu home services)
             (gnu home-services base)
             (gnu home-services shells)
             (gnu home-services shellutils))

(define-public zsh-services
  (list
    (service home-zsh-service-type
      (home-zsh-configuration
	(environment-variables
	  '(("HISTFILE" . "$XDG_CACHE_HOME/.zsh_hist")))
	(zshrc
	  '("\
guix() {
  case \"$1\" in
    locate) guix show $2 | \\
      grep location | \\
      xargs -n1 printf '(%s)' | \\
      sed -e 's/.*:)//g' -e 's/\\.scm.*)$/)/g' -e 's|/| |g' | \\
      xargs echo ;;
    *) command guix $@ ;;
  esac
}

view-log() {
  [ -d /tmp/view-log ] || mkdir /tmp/view-log
  cp $1 /tmp/view-log/log.gz
  gzip -d /tmp/view-log/log.gz
  cat /tmp/view-log/log
  rm /tmp/view-log/log
}"))))

    (service home-zsh-plugin-manager-service-type)

    (home-generic-service 'zsh-packages
      #:packages (list zsh))))

(define nouun-services
  (append alacritty-services
          bash-services
          direnv-services
          git-services
          picom-services
          rofi-services
          zsh-services))

(home-environment
 (packages nouun-packages)
 (services nouun-services))
