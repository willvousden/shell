default: install

.PHONY: default install install_dotfiles install_ssh matplotlib

DOTFILES = bashrc \
		   bashrc.d \
		   bash_logout \
		   bash_profile \
		   bash_profile.d \
		   python-startup.py \
		   inputrc \
		   latexmkrc \
		   gitignore \
		   tmux.conf \
		   tmux.conf.d \
		   screenrc \
		   minttyrc \
		   dircolors.d \
		   gdbinit \
		   gdbinit.d \
		   bin
DIRCOLORS = solarized.ansi-dark
OS := $(shell uname)
SHELL = /usr/bin/env bash
ifeq ($(OS), Linux)
	CONFIGPREFIX := ${HOME}/.config/
else
	CONFIGPREFIX := ${HOME}/.
endif

install: install_dotfiles
	ln -svf ${HOME}/.dircolors.d/$(DIRCOLORS) ${HOME}/.dir_colors

install_dotfiles: $(DOTFILES) install_ssh
	@for i in $(DOTFILES); do \
		ln -snfv `pwd`/$$i ${HOME}/.$$i; \
	done
	
	cp `pwd`/gitconfig ${HOME}/.gitconfig
	bash ./gitconfig.sh
	[ -d $(CONFIGPREFIX)matplotlib/stylelib ] || mkdir $(CONFIGPREFIX)matplotlib/stylelib
	cp ./matplotlib/stylelib/phd.mplstyle $(CONFIGPREFIX)matplotlib/stylelib/
	bash ./matplotlib.sh >> $(CONFIGPREFIX)matplotlib/stylelib/phd.mplstyle

install_ssh:
	[ -d ${HOME}/.ssh ] || mkdir ${HOME}/.ssh
	[ -d ${HOME}/.ssh/cm_socket ] || mkdir -p ${HOME}/.ssh/cm_socket
	cp `pwd`/ssh/authorized_keys ${HOME}/.ssh/authorized_keys
	# @ln -snfv `pwd`/ssh/config ${HOME}/.ssh/config
	cp `pwd`/ssh/config ${HOME}/.ssh/config
	[ ! -f ${HOME}/.ssh/config.local ] || cat ${HOME}/.ssh/config.local >> ${HOME}/.ssh/config
	chmod -R og-rxw ${HOME}/.ssh
