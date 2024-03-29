export EDITOR=vim

# https://blog.qnyp.com/2013/05/14/zsh-git-completion/
fpath=(~/.zsh/completion $fpath)
fpath=($(brew --prefix)/share/zsh/site-functions $fpath) # Git autocomplete

autoload -U compinit
compinit -u

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

eval "$(anyenv init -)"
eval "$(starship init zsh)"

export GOPATH="$(go env GOPATH)"

# alias
#
# brew for pyenv
# https://github.com/pyenv/pyenv/issues/106#issuecomment-94921352
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

alias sz='source ~/.zshrc'
alias ls='exa'
alias ll='ls -la'
alias cat='bat'
alias pn='pnpm'

# For tmux
# env variables
export TERM=screen-256color

# https://qiita.com/chatrate/items/02ad97b604722c6a8551
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt INC_APPEND_HISTORY # add history on real-time
setopt SHARE_HISTORY # share history between sessions

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# pnpm
export PNPM_HOME="/Users/gentamura/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
