c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

if [[ $(uname) == Linux ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}"
  python -m SimpleHTTPServer "$port"
}

