export PATH="/Applications/flutter/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

export GOPATH="$(go env GOPATH)"

if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

eval "$(anyenv init -)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

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
# bat -> cat
alias cat='bat'
