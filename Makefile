default: install

DOTFILES = bashrc \
		   bashrc.d \
		   profile \
		   profile.d \
		   inputrc \
		   latexmkrc \
		   gitconfig \
		   gitignore \
		   tmux.conf \
		   tmux.conf.d \
		   screenrc \
		   dircolors.d \
		   bin
CONFIGFILES = matplotlib/matplotlibrc
OS := $(shell uname)
ifeq ($(OS), Darwin)
	CONFIGPREFIX := ${HOME}/.
else
	CONFIGPREFIX := ${HOME}/.config/
endif

install: install_dotfiles

install_dotfiles: $(DOTFILES) install_ssh
	@for i in $(DOTFILES); do \
		ln -snfv `pwd`/$$i ${HOME}/.$$i; \
	done
	
	@for i in $(CONFIGFILES); do \
		mkdir -p $(CONFIGPREFIX)$$(dirname $$i); \
		ln -snfv `pwd`/$$i $(CONFIGPREFIX)$$i; \
	done

install_ssh:
	[ -d ${HOME}/.ssh ] || mkdir ${HOME}/.ssh
	chmod 700 ${HOME}/.ssh
	@ln -snfv `pwd`/ssh/config ${HOME}/.ssh/config
	@ln -snfv `pwd`/ssh/authorized_keys ${HOME}/.ssh/authorized_keys
