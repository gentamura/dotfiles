alias sz='source ~/.zshrc'
alias ls='eza'
alias ll='ls -la'
alias cat='bat'
alias pn='pnpm'

# Git worktree
alias gwtl='git worktree list'
alias gwtadd='git worktree add'
alias gwtaddb='git worktree add -b'
alias gwtrm='git worktree remove'
alias gwtprune='git worktree prune'
alias gwtmv='git worktree move'
alias gwtshow="awk '/^# Git worktree/{flag=1;next}/^# ---/{if(flag)exit}flag' ~/.zshrc.d/30-aliases.zsh"
# ---
