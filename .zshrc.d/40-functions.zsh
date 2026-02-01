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

# Rename the tmux window to "Codex" while running Codex
function codex() {
  if [ -n "${TMUX-}" ]; then
    local window_id
    window_id="$(tmux display-message -p '#{window_id}')"
    local prev_name
    prev_name="$(tmux display-message -p -t "$window_id" '#{window_name}')"
    tmux set-window-option -t "$window_id" automatic-rename off
    tmux rename-window -t "$window_id" "Codex"
  fi
  command codex "$@"
  if [ -n "${TMUX-}" ]; then
    tmux rename-window -t "$window_id" "$prev_name"
    tmux set-window-option -t "$window_id" automatic-rename on
  fi
}

# Rename the tmux window to "Claude Code" while running Claude
function claude() {
  if [ -n "${TMUX-}" ]; then
    local window_id
    window_id="$(tmux display-message -p '#{window_id}')"
    local prev_name
    prev_name="$(tmux display-message -p -t "$window_id" '#{window_name}')"
    tmux set-window-option -t "$window_id" automatic-rename off
    tmux rename-window -t "$window_id" "Claude Code"
  fi
  command claude "$@"
  if [ -n "${TMUX-}" ]; then
    tmux rename-window -t "$window_id" "$prev_name"
    tmux set-window-option -t "$window_id" automatic-rename on
  fi
}
