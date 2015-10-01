# load oh-my-zsh if it exists
if [ -d ~/.oh-my-zsh ]; then
  ZSH=$HOME/.oh-my-zsh
  ZSH_THEME="robbyrussell"
  plugins=(git brew gem dinfuehr)

  source $ZSH/oh-my-zsh.sh
fi

unsetopt correct_all

# add rbenv to path
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# allow faster opening of directories in ~/code
c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

# allow faster opening of directories in ~
h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

if [[ $(uname) == Linux ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}"
  python -m SimpleHTTPServer "$port"
}

if [ "$(uname)"=="Darwin" ] && [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

# allow machine-specific configuration in ~/.zshrc_local
ZSH_LOCAL=~/.zshrc_local

if [ -e $ZSH_LOCAL ]; then
  source $ZSH_LOCAL
fi

unset ZSH_LOCAL

