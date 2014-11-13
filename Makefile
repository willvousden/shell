default: install
	
DOTFILES = bashrc \
		   bashrc.d \
		   profile \
		   profile.d \
		   inputrc \
		   gitconfig \
		   gitignore \
		   tmux.conf \
		   tmux.conf.d \
		   screenrc \
		   dircolors.d \
		   bin

install: install_dotfiles

install_dotfiles: $(DOTFILES) install_ssh
	for i in $(DOTFILES); do \
		ln -snfv `pwd`/$$i ${HOME}/.$$i; \
	done

install_ssh:
	[[ -d ${HOME}/.ssh ]] || mkdir ${HOME}/.ssh
	ln -snfv `pwd`/ssh/config ${HOME}/.ssh/config
	ln -snfv `pwd`/ssh/authorized_keys ${HOME}/.ssh/authorized_keys
