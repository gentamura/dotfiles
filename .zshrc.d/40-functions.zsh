# https://qiita.com/chatrate/items/02ad97b604722c6a8551
function peco-history-selection() {
  BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function tms() {
  local cwd="${PWD:A}"
  local name="${cwd##*/}"
  local candidate=""
  local full_candidate=""
  local start=1
  local count=0
  local i=0
  local suffix=2
  local -a parts

  name="${name// /_}"
  if ! tmux has-session -t "$name" 2>/dev/null; then
    tmux new -s "$name"
    return
  fi

  parts=("${(@s:/:)cwd}")
  parts=("${parts[@]:#}")
  count=${#parts[@]}

  for ((i = 2; i <= count; i++)); do
    start=$((count - i + 1))
    candidate="${(j:/:)parts[$start,$count]}"
    candidate="${candidate//\//__}"
    candidate="${candidate// /_}"
    if ! tmux has-session -t "$candidate" 2>/dev/null; then
      tmux new -s "$candidate"
      return
    fi
  done

  full_candidate="${(j:__:)parts}"
  full_candidate="${full_candidate// /_}"
  candidate="${full_candidate}-${suffix}"
  while tmux has-session -t "$candidate" 2>/dev/null; do
    suffix=$((suffix + 1))
    candidate="${full_candidate}-${suffix}"
  done

  tmux new -s "$candidate"
}
