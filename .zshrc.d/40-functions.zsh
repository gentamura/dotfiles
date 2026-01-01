# https://qiita.com/chatrate/items/02ad97b604722c6a8551
function peco-history-selection() {
  BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function tms() {
  local name="${PWD##*/}"
  name="${name// /_}"
  tmux new -s "$name"
}
