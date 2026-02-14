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

# Add user-specific environment.
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH

# Load NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
