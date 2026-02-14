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

# Use eza for ls if available
if command -v eza &> /dev/null; then
  alias ls=eza
else
  alias ls='ls --color=auto'
fi
