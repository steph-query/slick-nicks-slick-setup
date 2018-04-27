#!/bin/bash

# Screen display helper functions
echo_ok()     { echo -e '\033[1;32m'"$1"'\033[0m'; }                 # green message
echo_warn()   { echo -e '\033[1;33m'"$1"'\033[0m'; }                 # yellow
echo_error()  { echo -e '\033[1;31mFATAL: '"$1"'\033[0m'; exit 1; }  # red

system_update() {
  if [ `uname` == "Darwin" ]; then
    install_homebrew
  elif [ `uname` == "Linux" ]; then
    apt-get update
  else
    echo "Unknown system: `uname`. Make a PR to handle this OS!"
  fi
}

system_install() {
  if [ `uname` == "Darwin" ]; then
    brew install "$@"
  elif [ `uname` == "Linux" ]; then
    apt-get install "$@"
  else
    echo "Unknown system: `uname`. Make a PR to handle this OS!"
  fi
}

setup_ssh() {
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
}

install_homebrew() {
  if [ -z "$(which brew)" ] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
    && brew update
  else
    brew update
  fi
}

install_python() {
  system_install python
}

install_ansible() {
  system_install ansible
}

setup_zsh() {
  system_install zsh
  sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
  # install ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

echo_warn "Updating your system..."
system_update

echo_warn "Setting up ssh..."
setup_ssh

echo_warn "Installing Python..."
install_python

echo_warn "Installing Ansible..."
install_ansible

echo_warn "Running setup playbook..."
ansible-playbook playbooks/main.yml

echo_warn "Installing Wes Bos Cobalt theme for iTerm..."
#./cobalt_theme.sh

echo_warn "Installing zsh and oh-my-zsh..."
echo_warn "You will be asked for your password..."
setup_zsh
echo_ok "Zsh installed successfully! You'll need to restart your terminal now!"

exit 0

