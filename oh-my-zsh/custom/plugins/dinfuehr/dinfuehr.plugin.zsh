alias casmi=~/projects/casmi/build/casmi
alias casmintr=~/projects/casm2cpp/casmintr

function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}"
  python -m SimpleHTTPServer "$port"
}

function ffp() {
  ssh ffp0925697@g0.complang.tuwien.ac.at
}