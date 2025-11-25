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

# set up history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY # append to history rather than replace it
setopt EXTENDED_HISTORY # additional date for commands (timestamp, duration)
setopt HIST_IGNORE_DUPS # ignore duplicates in search
setopt HIST_IGNORE_SPACE # do not save in history if command starts with space
setopt NO_HIST_BEEP # no beeps
setopt SHARE_HISTORY # share history between sessions/terminals
#
# Ctrl-R should do backward-search in history
bindkey "^R" history-incremental-search-backward

# enable search for arrow up/down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Ctrl-U by default deletes whole line, make it behave
# like bash so that it only deletes the characters up
# to the cursor
bindkey \^U backward-kill-line

# add pbcopy/pbpaste on linux
if [[ $(uname) == Linux ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

function server() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# add homebrew to path
if [ "$(uname)"=="Darwin" ] && [ -d /opt/homebrew/bin ]; then
  export PATH=/opt/homebrew/bin:$PATH
fi

# add depot_tools to path if it exists
if [ -d ~/code/depot_tools ]; then
  export PATH="$PATH:$HOME/code/depot_tools"
fi

# source rustup if it exists
if [ -f ~/.cargo/env ]; then
  source $HOME/.cargo/env
fi


# Add user-specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if ls --color -d . &>/dev/null 2>&1; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi

# use nvim instead
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
export EDITOR=nvim

# some v8 shortcuts
export V8=$HOME/v8/v8
alias gm=$V8/tools/dev/gm.py

cd_v8()
{
  cd $V8
}

cd_cr()
{
  cd $HOME/chromium/src
}

# Convenient way to attach to same tmux session.
work() {
  # If tmx2 exists use it, otherwise echo tmux.
  local cmd=$(command -v tmx2 || echo tmux)
  $cmd new-session -A -s "${1:-work}"
}

# allow ctrl+e in tmux
bindkey -e

# Disable coredumps by default.
ulimit -c 0

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

