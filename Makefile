GREEN =  \033[1;32m
CLEAR =  \033[0m

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
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "config/home.org")'
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
--reconfigure-system: --tangle-system
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Reconfiguring Guix System"
		if sudo -E guix system -L ./ reconfigure ./jayu/build/system/${SYSTEM}.scm; then
			echo -e "--> [${GREEN}Jayu${CLEAR}] Finished reconfiguring Guix System"
		fi
	}

.ONESHELL:
--reconfigure-home: --tangle-home
	@{ \
		echo -e "--> [${GREEN}Jayu${CLEAR}] Reconfiguring Guix Home"
		if guix home -L ./ reconfigure ./jayu/build/home/${USER}.scm; then
			echo -e "--> [${GREEN}Jayu${CLEAR}] Finished reconfiguring Guix Home"
		fi
	}

