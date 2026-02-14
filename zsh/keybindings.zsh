# Ctrl-R should do backward-search in history
bindkey "^R" history-incremental-search-backward

# enable search for arrow up/down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Ctrl-U by default deletes whole line, make it behave
# like bash so that it only deletes the characters up
# to the cursor
bindkey \^U backward-kill-line

# allow ctrl+e in tmux
bindkey -e
