if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  # Ctrl-T collides with zellij; move file-widget to Alt-T.
  bindkey -r '^T'
  bindkey '^[t' fzf-file-widget
fi
