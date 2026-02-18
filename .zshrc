# Load split zsh configs
setopt local_options null_glob

zshrc_dir="${${(%):-%N}:A:h}"
if [ -d "$HOME/.zshrc.d" ]; then
  zshrc_dir="$HOME/.zshrc.d"
else
  zshrc_dir="$zshrc_dir/.zshrc.d"
fi

for config in "$zshrc_dir"/*.zsh; do
  [ -f "$config" ] && source "$config"
done

# Machine-local overrides (not tracked in repo)
# Use ~/.zshrc.local for private or machine-specific values.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
