c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

alias casmi=~/projects/casmi/build/casmi
alias casmintr=~/projects/casm2cpp/casmintr

if [[ $(uname) == Linux ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  alias subl=sublime
else
  alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
fi

unsetopt correct_all

function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}"
  python -m SimpleHTTPServer "$port"
}

function svl() {
  ssh root@sv-langenrohr.at
}

function ffp() {
  ssh ffp0925697@g0.complang.tuwien.ac.at
}
