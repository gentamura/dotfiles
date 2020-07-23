export EDITOR=vim

fpath=($(brew --prefix)/share/zsh/site-functions $fpath) # Git autocomplete
fpath=(/usr/local/etc/bash_completion.d/deno.bash $fpath) # deno
autoload -U compinit
compinit -u

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/Applications/flutter/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export OPENSSL_LIBS="-L/usr/local/opt/openssl@1.1/lib"
export OPENSSL_CFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

eval "$(anyenv init -)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

export GOPATH="$(go env GOPATH)"

# alias

# brew for pyenv
# https://github.com/pyenv/pyenv/issues/106#issuecomment-94921352
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
# npm
alias ni='npm install'
# zsh
alias sz='source ~/.zshrc'
# exa -> ls
alias ls='exa'
# ls -la
alias ll='ls -la'
# bat -> cat
alias cat='bat'

# key binding for tmux
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#History-Control
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
