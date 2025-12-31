if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# tabtab source for packages
# uninstall by removing these lines
[ -f "$HOME/.config/tabtab/zsh/__tabtab.zsh" ] && source "$HOME/.config/tabtab/zsh/__tabtab.zsh"
