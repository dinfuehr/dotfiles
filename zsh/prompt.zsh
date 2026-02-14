# Custom prompt based on redhat theme.
# In a git repo whose folder name is a single digit (0-9),
# show parent/digit instead of just the digit.
_prompt_dir() {
  local dir=${PWD##*/}
  if [[ $dir == [0-9] ]] && git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "${PWD:h:t}/$dir"
  else
    echo "$dir"
  fi
}
setopt PROMPT_SUBST
PROMPT='[%n@%m $(_prompt_dir)]$ '
