#!/bin/zsh

# install wes bos cobalt2 theme
# see instructions for iterm settings here: https://github.com/wesbos/Cobalt2-iterm
mkdir ~/tmp
cd ~/tmp
  && git clone https://github.com/wesbos/Cobalt2-iterm.git \
  && mv Cobalt2-iterm/cobalt2.zsh-theme ~/.oh-my-zsh/themes \
  && echo 'ZSH_THEME="cobalt2"' >> ~/.zshrc \
  && pip install --user powerline-status \
  && git clone https://github.com/powerline/fonts \
  && cd powerline \
  && ./install.sh

source ~/.zshrc

