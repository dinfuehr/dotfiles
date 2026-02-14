# ensure completions and prompts
autoload -U compinit promptinit
compinit
promptinit

# do not ask for correction on commands
unsetopt correct

# Disable coredumps by default.
ulimit -c 0

# source all config files from ~/.zsh/
for f in ~/.zsh/*.zsh; do
  source "$f"
done

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
