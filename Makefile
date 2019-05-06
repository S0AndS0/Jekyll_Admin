#
#    Make variables that readers &/or maintainers may wish to modify
#
## If /usr/local/sbin is not available, then change the following to
##  access scripts by name to a path available to your PATH variable
SCRIPT_INSTALL_DIR = /usr/local/sbin
## List of scripts to install (symbolically link) to above directory, note
##  though that only matching scripts found in ROOT_DIR will be linked
SCRIPT_NAMES_TO_LINK=jekyll_usermod.sh jekyll_wwwconf.sh jekyll_dnsconf.sh
GIT_LOCAL_BRANCH:=local


#
#    Make variables to satisfy conventions
#
NAME=Jekyll_Admin
VERSION=0.0.1
PKG_NAME=$(NAME)-$(VERSION)


#
#    Make variables set upon run-time
#
## Obtain directory path that this Makefile lives in
##  Note ':=' is to avoid late binding that '=' entails
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
## Detect Operating System
ifeq '$(findstring :,$(PATH))' ';'
	__OS__ := Windows
else
	__OS__ := $(shell uname 2>/dev/null || echo 'Unknown')
	__OS__ := $(patsubst CYGWIN%,Cygwin,$(__OS__))
	__OS__ := $(patsubst MSYS%,MSYS,$(__OS__))
	__OS__ := $(patsubst MINGW%,MSYS,$(__OS__))
endif


#
#    Make options/commands
#
.SILENT: install-dependencies uninstall uninstall-dependencies
.ONESHELL: install
install-dependencies: ## Calls out to package manager to install dependencies
	bash "$(ROOT_DIR)/make_scriptlets/dependencies_install.sh" '$(__OS__)' 'install'

uninstall-dependencies: ## Calls out to package manager to uninstall dependencies
	bash "$(ROOT_DIR)/make_scriptlets/dependencies_install.sh" '$(__OS__)' 'uninstall'

uninstall: ## Removes symbolic links to project scripts
	test -d "$(SCRIPT_INSTALL_DIR)" && $(foreach s,$(SCRIPT_NAMES_TO_LINK),\
		if [ -L "$(SCRIPT_INSTALL_DIR)/$(s)" ]; then rm -v "$(SCRIPT_INSTALL_DIR)/$(s)"; fi; )

install: ## Symbolically links to project scripts and runs git checkout local
	bash "$(ROOT_DIR)/make_scriptlets/make_git_commands.sh" 'install'
	test -d "$(SCRIPT_INSTALL_DIR)" && $(foreach s,$(SCRIPT_NAMES_TO_LINK),\
		if [ ! -f "$(SCRIPT_INSTALL_DIR)/$(s)" ]; then\
			ln -vs "$(ROOT_DIR)/$(s)" "$(SCRIPT_INSTALL_DIR)/$(s)";\
			chmod u+x "$(ROOT_DIR)/$(s)"; fi;)

update: ## Runs; make uninstall, git pull (via script), then make install
	$(MAKE) uninstall
	bash "$(ROOT_DIR)/make_scriptlets/make_git_commands.sh" 'update'
	@echo "Please run '$(MAKE) install' to complete update!"

list: SHELL := /bin/bash
list: ## Lists available make commands
	gawk -F'[: ]' '/^[a-z0-9A-Z-]{1,32}: [\#]{1,2}[[:print:]]*$$/ {first = $$1; $$1=""; print $$0, "\n", "   ", first}' "$(ROOT_DIR)/Makefile"
## To instead pull comments from above instead of those beside recopies
#    awk -F'[: ]' '/^[a-z0-9A-Z-]*:$$/ {if (a!="") print a; print "    " $$1; a=""; next} {a=$$0}' "$(ROOT_DIR)/Makefile"


## Both install-dependencies & uninstall-dependencies call out to the same
##  script, which in future versions may support more than Debian based Linux.
## Both uninstall & install are written to not error out under normal operation
##  such that make update is allowed to be used at any point to re-install
##  the latest versions of scripts from author without destruction of changes.


## Note the following syntax allows shell use within a recipe,
##  Bash in this example; though with some caveats...
#os_id_like: SHELL := /bin/bash
#os_id_like:
#    _id_like="$$(awk -F'=' '/^ID_LIKE=/ {print tolower($$2)}' /etc/*-release 2>/dev/null | head -1 || echo -n 'unknown')";\
#    printf '%s\n' "$${_id_like^^}";\
## ... note that every line must end with ';\' (unless at the end of recopy)
##  and every '$' is doubled-up to tell Make not to mess with-em


#
#    Sources of information &/or inspiration
#
## https://stackoverflow.com/questions/589276/how-can-i-use-bash-syntax-in-makefile-targets
## https://gist.github.com/postmodern/3224049
## https://stackoverflow.com/questions/322936/common-gnu-makefile-directory-path
## https://stackoverflow.com/questions/1490949/how-to-write-loop-in-a-makefile
## https://stackoverflow.com/questions/714100/os-detecting-makefile
## https://www.gnu.org/software/make/manual/html_node/Special-Targets.html#Special-Targets
