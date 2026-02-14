HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY   # append to history rather than replace it
setopt EXTENDED_HISTORY  # additional date for commands (timestamp, duration)
setopt HIST_IGNORE_DUPS  # ignore duplicates in search
setopt HIST_IGNORE_SPACE # do not save in history if command starts with space
setopt NO_HIST_BEEP      # no beeps
setopt SHARE_HISTORY     # share history between sessions/terminals
