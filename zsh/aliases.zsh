# add pbcopy/pbpaste on linux
if [[ $(uname) == Linux ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# Use nvim instead.
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
export EDITOR=nvim

alias cx="codex --yolo"
alias cl="claude --dangerously-skip-permissions"
if [[ $(uname) == Darwin ]]; then
  alias jk="/usr/local/bin/jetski --dangerously-skip-permissions"
else
  alias jk="jetski-cli --dangerously-skip-permissions"
fi

# Use eza for ls if available
if command -v eza &> /dev/null; then
  alias ls=eza
else
  alias ls='ls --color=auto'
fi
