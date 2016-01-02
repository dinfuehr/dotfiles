# ensure completions and prompts
autoload -U compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt redhat

# do not ask for correction on commands
unsetopt correct

# allow faster opening of directories in ~/code
c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

# allow faster opening of directories in ~
h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

# Ctrl-R should do backward-search in history
bindkey "^R" history-incremental-search-backward

# set up history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# enable search for arrow up/down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# add pbcopy/pbpaste on linux
if [[ $(uname) == Linux ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}"
  python -m SimpleHTTPServer "$port"
}

# add homebrew to path
if [ "$(uname)"=="Darwin" ] && [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

# add rbenv to path
# IMPORTANT: add path after adding homebrew
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# add jenv to path if it exists
if [ -d ~/.jenv ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# allow machine-specific configuration in ~/.zshrc_local
ZSH_LOCAL=~/.zshrc_local

if [ -e $ZSH_LOCAL ]; then
  source $ZSH_LOCAL
fi

unset ZSH_LOCAL

# load zsh synax highlighting
ZSH_SYN=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -e $ZSH_SYN ]; then
  source $ZSH_SYN
fi

