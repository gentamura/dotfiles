autoload -U promptinit
promptinit

# pure may be provided via fpath and not autoloaded yet.
if prompt -l | grep -qx "pure"; then
  setopt prompt_subst
  prompt pure
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# tabtab source for packages
# uninstall by removing these lines
[ -f "$HOME/.config/tabtab/zsh/__tabtab.zsh" ] && source "$HOME/.config/tabtab/zsh/__tabtab.zsh"
