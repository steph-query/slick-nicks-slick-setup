#!/bin/bash

# make ssh directory
if ! [ -e ~/.ssh ] ; then
	mkdir ~/.ssh
fi

## make a github key
if ! [ -e ~/.ssh/github ] ; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/github_key
	# add the key to ssh
	ssh-add ~/.ssh/github
	# make ssh config file
	touch ~/.ssh/config
fi

## put git key in ssh config
if [  -z "$(cat ~/.ssh/config | grep github)" ] ; then
    echo "Host github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/github" \
    >> ~/.ssh/config
fi

# install ohmyzsh
if ! [ echo "$SHELL" -eq "/bin/zsh" ] ; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi


if [[ "$OSTYPE" == "darwin"* ]]; then
  # install homebrew
  if [ -z "$(which brew)" ] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
    && brew update
  fi
  brew install python
elif [[ "$OSTYPE" == "debian"* ]]; then
  sudo apt-get update -yqq
  sudo apt-get install python-pip
fi

pip install -U pip
pip install ansible --user

ansible-playbook playbooks/main.yml

./cobalt_theme.sh

exit 0

