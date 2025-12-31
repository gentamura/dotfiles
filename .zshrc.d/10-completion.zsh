# https://blog.qnyp.com/2013/05/14/zsh-git-completion/
fpath=(~/.zsh/completion $fpath)

if command -v brew >/dev/null 2>&1; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

autoload -U compinit
compinit -u
