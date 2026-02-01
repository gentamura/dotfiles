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
  if [ -z "${TMUX-}" ]; then
    command codex "$@"
    return $?
  fi

  local window_id prev_name auto_rename exit_code
  window_id="$(tmux display-message -p '#{window_id}')"
  prev_name="$(tmux display-message -p -t "$window_id" '#{window_name}')"
  auto_rename="$(tmux show-options -w -v -t "$window_id" automatic-rename)"
  if [ -z "$auto_rename" ]; then
    auto_rename="on"
  fi

  setopt local_traps
  trap 'tmux rename-window -t "$window_id" "$prev_name"; tmux set-window-option -t "$window_id" automatic-rename "$auto_rename"' EXIT INT TERM

  tmux set-window-option -t "$window_id" automatic-rename off
  tmux rename-window -t "$window_id" "Codex"
  command codex "$@"
  exit_code=$?
  return $exit_code
}

# Rename the tmux window to "Claude Code" while running Claude
function claude() {
  if [ -z "${TMUX-}" ]; then
    command "$HOME/.local/bin/claude" "$@"
    return $?
  fi

  local window_id prev_name auto_rename exit_code
  window_id="$(tmux display-message -p '#{window_id}')"
  prev_name="$(tmux display-message -p -t "$window_id" '#{window_name}')"
  auto_rename="$(tmux show-options -w -v -t "$window_id" automatic-rename)"
  if [ -z "$auto_rename" ]; then
    auto_rename="on"
  fi

  setopt local_traps
  trap 'tmux rename-window -t "$window_id" "$prev_name"; tmux set-window-option -t "$window_id" automatic-rename "$auto_rename"' EXIT INT TERM

  tmux set-window-option -t "$window_id" automatic-rename off
  tmux rename-window -t "$window_id" "Claude Code"
  command "$HOME/.local/bin/claude" "$@"
  exit_code=$?
  return $exit_code
}
