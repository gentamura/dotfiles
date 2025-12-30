path=(
  "$HOME/.local/share/mise/shims"
  "$HOME/.cargo/bin"
  "$HOME/.deno/bin"
  "$HOME/go/bin"
  "$HOME/development/flutter/bin"
  $path
)

export PNPM_HOME="$HOME/Library/pnpm"
path=("$PNPM_HOME" $path)
