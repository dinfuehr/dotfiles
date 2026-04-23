if command -v fzf >/dev/null 2>&1; then
  # fzf >=0.48 ships shell integration via `fzf --zsh`; older Debian
  # packages install the scripts under /usr/share/doc/fzf/examples.
  if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && \
      source /usr/share/doc/fzf/examples/completion.zsh
  else
    source <(fzf --zsh)
  fi
  # Ctrl-T collides with zellij; move file-widget to Alt-T.
  bindkey -r '^T'
  bindkey '^[t' fzf-file-widget
fi
