#!/usr/bin/env zsh
set -ue

command echo "backup old dotfiles..."

if [ ! -d "$HOME/.dotbackup" ];then
  command echo "$HOME/.dotbackup not found. Auto Make it"
  command mkdir "$HOME/.dotbackup"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
DOT_DIR=$(dirname "${SCRIPT_DIR}")

if [[ "$HOME" != "$DOT_DIR" ]];then
  for f in $DOT_DIR/.??*; do
    [[ `basename $f` == ".git" ]] && continue
    # Skip .claude - handled separately below
    [[ `basename $f` == ".claude" ]] && continue

    if [[ -L "$HOME/`basename $f`" ]];then
      command rm -f "$HOME/`basename $f`"
    fi

    if [[ -e "$HOME/`basename $f`" ]];then
      command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
    fi

    command ln -snf $f $HOME
  done

  # Special handling for .claude directory
  # Claude Code uses ~/.claude for runtime data, so we symlink individual config files
  command echo "Setting up Claude Code configuration..."

  if [ -d "$DOT_DIR/.claude" ]; then
    # Ensure ~/.claude directory exists
    if [ ! -d "$HOME/.claude" ]; then
      command mkdir -p "$HOME/.claude"
    fi

    # Config files/directories to symlink from dotfiles
    CLAUDE_CONFIGS=("CLAUDE.md" "README.md" "rules" "agents" "commands" "skills")

    for config in "${CLAUDE_CONFIGS[@]}"; do
      src="$DOT_DIR/.claude/$config"
      dest="$HOME/.claude/$config"

      if [ -e "$src" ]; then
        # Remove existing symlink
        if [ -L "$dest" ]; then
          command rm -f "$dest"
        fi

        # Backup existing file/directory (not symlink)
        if [ -e "$dest" ]; then
          command echo "Backing up $dest"
          command mv "$dest" "$HOME/.dotbackup/.claude_$config"
        fi

        # Create symlink
        command ln -snf "$src" "$dest"
        command echo "Linked: $dest -> $src"
      fi
    done
  fi
else
  command echo "same install src dest"
fi
