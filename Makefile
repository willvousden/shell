default: install

.PHONY: default install install_dotfiles install_ssh

DOTFILES = bashrc \
		   bashrc.d \
		   bash_logout \
		   profile \
		   profile.d \
		   inputrc \
		   latexmkrc \
		   gitignore \
		   tmux.conf \
		   tmux.conf.d \
		   screenrc \
		   dircolors.d \
		   gdbinit \
		   gdbinit.d \
		   bin
DIRCOLORS = solarized.ansi-dark
CONFIGFILES = matplotlib/matplotlibrc
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
	
	@for i in $(CONFIGFILES); do \
		mkdir -p $(CONFIGPREFIX)$$(dirname $$i); \
		ln -snfv `pwd`/$$i $(CONFIGPREFIX)$$i; \
	done
	
	cp `pwd`/gitconfig ${HOME}/.gitconfig
	./gitconfig.sh

install_ssh:
	[ -d ${HOME}/.ssh/cm_socket ] || mkdir -p ${HOME}/.ssh/cm_socket
	cp `pwd`/ssh/authorized_keys ${HOME}/.ssh/authorized_keys
	@ln -snfv `pwd`/ssh/config ${HOME}/.ssh/config
	chmod -R 600 ${HOME}/.ssh/config
