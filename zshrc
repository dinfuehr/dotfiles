# Initialize ZSH
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git brew gem dinfuehr)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

if [ -d ~/.rvm ]; then
  PATH=$PATH:$HOME/.rvm/bin
  source ~/.rvm/scripts/rvm
fi

ZSH_LOCAL=~/.zshrc_local

if [ -e $ZSH_LOCAL ]; then
  source $ZSH_LOCAL
else
  touch $ZSH_LOCAL
fi
