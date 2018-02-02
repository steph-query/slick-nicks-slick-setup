#!/bin/bash

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
fi

exit 0
