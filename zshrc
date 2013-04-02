# Initialize ZSH
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git brew gem dinfuehr)

source $ZSH/oh-my-zsh.sh

PATH=$PATH:$HOME/.rvm/bin
source ~/.rvm/scripts/rvm