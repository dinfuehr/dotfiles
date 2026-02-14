# allow faster opening of directories in ~/code
c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

# allow faster opening of directories in ~
h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

function server() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# some v8 shortcuts
export V8=$HOME/v8/v8
alias gm=tools/dev/gm.py

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
