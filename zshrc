# Initialize oh my zsh
if [ -d ~/.oh-my-zsh ]; then
  ZSH=$HOME/.oh-my-zsh
  ZSH_THEME="robbyrussell"
  plugins=(git brew gem dinfuehr)

  source $ZSH/oh-my-zsh.sh
fi

unsetopt correct_all

if [ "$(uname)"=="Darwin" ] && [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

if [ -d ~/.rvm ]; then
  source ~/.rvm/scripts/rvm
fi

ZSH_LOCAL=~/.zshrc_local

if [ -e $ZSH_LOCAL ]; then
  source $ZSH_LOCAL
fi
