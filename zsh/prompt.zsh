# Custom prompt based on redhat theme.
#
# Directory display (cached, updated on directory change):
#   git repo with single-digit name:  parent:digit  (e.g. ~/code/some_project/0 => some_project:0)
#   gclient repo level:               project:checkout  (e.g. ~/v8s/0/v8 => v8:0)
#   otherwise:                        basename
# Walk up from $PWD looking for a .gclient file under $HOME.
# Sets _PROMPT_DIR to project:checkout (e.g. v8:0) when one level below root.
_prompt_gclient() {
  local d="$PWD"
  while [[ "$d" == "$HOME"* ]]; do
    if [[ -f "$d/.gclient" ]]; then
      if [[ "${PWD:h}" == "$d" ]]; then
        _PROMPT_DIR="${PWD##*/}:${d:t}"
        return 0
      fi
      return 1
    fi
    d="${d:h}"
  done
  return 1
}

# Git repo with single-digit name: show parent:digit (e.g. some_project:0).
_prompt_git() {
  local dir=${PWD##*/}
  if [[ $dir == [0-9] ]] && git rev-parse --is-inside-work-tree &>/dev/null; then
    _PROMPT_DIR="${PWD:h:t}:$dir"
    return 0
  fi
  return 1
}

_precmd_prompt() {
  [[ "$PWD" == "$_PROMPT_LAST_PWD" ]] && return
  _PROMPT_LAST_PWD="$PWD"

  _prompt_gclient || _prompt_git || _PROMPT_DIR="${PWD##*/}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _precmd_prompt

setopt PROMPT_SUBST

# Solarized Dark colors (RGB)
local COLOR_BLUE='%F{#268bd2}'      # blue
local COLOR_GREEN='%F{#859900}'     # green
local COLOR_YELLOW='%F{#b58900}'    # yellow
local COLOR_BASE0='%F{#839496}'     # primary content
local COLOR_RESET='%f'

PROMPT="${COLOR_BASE0}[${COLOR_BLUE}%n${COLOR_BASE0}@${COLOR_GREEN}%m ${COLOR_YELLOW}\${_PROMPT_DIR}${COLOR_BASE0}]$ ${COLOR_RESET}"
