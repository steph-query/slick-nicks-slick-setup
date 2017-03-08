#!/bin/bash

cd ~/Config

# make ssh directory
if ! [ -e ~/.ssh ] ; then 
	mkdir ~/.ssh
fi

# make a github key
if ! [ -e ~/.ssh/github ] ; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/github
	# add the key to ssh
	ssh-add ~/.ssh/github
	# make ssh config file
	touch ~/.ssh/config    	
fi

# put git key in ssh config
if [  -z "$(cat ~/.ssh/config | grep github)" ] ; then
    echo "Host github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/github" \
    >> ~/.ssh/config
fi

if ! [ -e /usr/local/bin ] ; then
	mkdir /usr/local/bin
fi

# simlink to sublime for command line access
if ! [ -e /usr/local/bin/subl ] ; then 
	ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
fi

# install homebrew
if [ -z "$(which brew)" ] ; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
	&& brew update
fi

# install python + ansible
brew install python
pip install ansible

# install ohmyzsh
if ! [ echo "$ENV" -eq "/bin/bash" ] ; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
	
	# install wes bos cobalt2 theme
	# see instructions for iterm settings here: https://github.com/wesbos/Cobalt2-iterm
	git clone https://github.com/wesbos/Cobalt2-iterm.git
	mv Cobalt2-iterm/cobalt2.zsh-theme ~/.oh-my-zsh/themes
	echo 'ZSH_THEME="cobalt2"' >> ~/.zshrc
	pip install --user powerline-status
	git clone https://github.com/powerline/fonts
	cd powerline
	./install.sh
fi

source ~/.zshrc

echo "finished setup"

exit 0