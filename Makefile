RED   = \033[1;31m
GREEN = \033[1;32m
CLEAR = \033[0m

## Install Targets
## =============================================================================

all: system home
home: --reconfigure-home
system: --reconfigure-system
pull: --pull
clean:
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Cleaning build"
		rm -rf ./jayu/build
	}


## Tangle Targets
## =============================================================================
.ONESHELL:
--tangle-system:
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Building system configuration"
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "config/system.org")'
	}

.ONESHELL:
--tangle-home: --tangle-emacs
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Building home configuration"
		emacs --batch \
			--eval "(require 'org)" \
			--eval '(org-babel-tangle-file "config/home.org")' \
			--eval '(org-babel-tangle-file "config/theming.org")'
	}

.ONESHELL:
--tangle-emacs:
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Building emacs configuration"
	}


## Configuration Targets
## =============================================================================
.ONESHELL:
--pull: --tangle-system
	@{ \
		GUIX_CONFIG_HOME="$${XDG_CONFIG_HOME:-$${HOME:-/home/$$USER}}/guix"
		if [[ ! -d "$$GUIX_CONFIG_HOME" ]]; then
			echo -e "--> [${GREEN}Jayu${CLEAR}] Creating $$GUIX_CONFIG_HOME" 
			mkdir -p "$$GUIX_CONFIG_HOME"
		fi
		echo -e "--> [${GREEN}Jayu${CLEAR}] Copying Guix channels"
		mv ./jayu/build/channels.scm $$GUIX_CONFIG_HOME/channels.scm
		echo -e "--> [${GREEN}Jayu${CLEAR}] Pulling Guix channels"
		guix pull
		echo -e "--> [${GREEN}Jayu${CLEAR}] Pulled Guix channels"
	}

.ONESHELL:
--reconfigure-system: --tangle-system --remove-channels
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Reconfiguring Guix System"
		
		__SYSTEM=$$(echo $${SYSTEM:-$$JAYU_SYSTEM} | tr 'A-Z' 'a-z')
		
		if [ -z "$$__SYSTEM" ]; then
			echo -e "!!! [${RED}Jayu${CLEAR}] No system set, set SYSTEM envvar and run again."
			echo -e "!!! [${RED}Jayu${CLEAR}] This only needs to be used on the first setup"
			echo -e "!!! [${RED}Jayu${CLEAR}] as the config will populate an envvar afterwards"
		elif [ ! -f "./jayu/build/system/systems/$${__SYSTEM}.scm" ]; then
			echo -e "!!! [${RED}Jayu${CLEAR}] System \"$$__SYSTEM\" is not a valid system"
			echo -e "!!! [${RED}Jayu${CLEAR}] Valid systems:"
			ls ./jayu/build/system/systems | \
				sed -e "s/.scm//g" \
				    -e "s/^/`printf '!!! [${RED}Jayu${CLEAR}]'`   /g"
		elif sudo -E guix system -L ./ reconfigure ./jayu/build/system/systems/${SYSTEM}.scm; then
			echo -e "--> [${GREEN}Jayu${CLEAR}] Finished reconfiguring Guix System"
		else
			echo -e "!!! [${RED}Jayu${CLEAR}] Failed reconfiguring Guix System"
		fi
	}

.ONESHELL:
--reconfigure-home: --tangle-home --remove-channels
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Reconfiguring Guix Home"
		
		__USER=${USER}
		
		if [ -z "$$USER" ]; then
			echo -e "!!! [${RED}Jayu${CLEAR}] No user set, set USER envvar and run again."
			echo -e "!!! [${RED}Jayu${CLEAR}] This should never happen as the shell should"
			echo -e "!!! [${RED}Jayu${CLEAR}] populate the USER envvar."
		elif [ ! -f "./jayu/build/home/users/$${__USER}.scm" ]; then
			echo -e "!!! [${RED}Jayu${CLEAR}] User \"$$__USER\" is not a valid user. You can"
			echo -e "!!! [${RED}Jayu${CLEAR}] build a different user by setting the USER envvar"
			echo -e "!!! [${RED}Jayu${CLEAR}] Valid users:"
			ls ./jayu/build/home/users | \
				sed -e "s/.scm//g" \
				    -e "s/^/`printf '!!! [${RED}Jayu${CLEAR}]'`   /g"
		elif guix home -L ./ reconfigure ./jayu/build/home/users/${USER}.scm; then
			echo -e "--> [${GREEN}Jayu${CLEAR}] Finished reconfiguring Guix Home"
		else
			echo -e "!!! [${RED}Jayu${CLEAR}] Failed reconfiguring Guix Home"
		fi
	}

# Remove channels.scm file to stop erroring when building system or home
.ONESHELL:
--remove-channels:
	@{ \
		if [[ -f ./jayu/build/channels.scm ]]; then
			echo -e "--> [${GREEN}Jayu${CLEAR}] Removing unnecessary channels.scm"
			rm ./jayu/build/channels.scm
		fi
	}

