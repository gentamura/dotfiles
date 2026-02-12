#!/usr/bin/env zsh
set -ue

command echo "backup old dotfiles..."

TIMESTAMP=$(date +%s)

# Ensure .dotbackup is a directory
if [ -e "$HOME/.dotbackup" ] && [ ! -d "$HOME/.dotbackup" ]; then
  command echo "Error: $HOME/.dotbackup exists but is not a directory" >&2
  exit 1
fi

if [ ! -d "$HOME/.dotbackup" ]; then
  command echo "$HOME/.dotbackup not found. Auto Make it"
  command mkdir -p "$HOME/.dotbackup"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
DOT_DIR="$(dirname "${SCRIPT_DIR}")"

if [[ "$HOME" != "$DOT_DIR" ]]; then
  # (N) qualifier: no error if no matches (zsh nomatch behavior)
  for f in "$DOT_DIR"/.??*(N); do
    fname="$(basename "$f")"
    [[ "$fname" == ".git" ]] && continue
    # Skip .bin - installation scripts, not user dotfiles
    [[ "$fname" == ".bin" ]] && continue
    # Skip .claude - handled separately below
    [[ "$fname" == ".claude" ]] && continue

    if [[ -L "$HOME/$fname" ]]; then
      command rm -f "$HOME/$fname"
    fi

    if [[ -e "$HOME/$fname" ]]; then
      command mv "$HOME/$fname" "$HOME/.dotbackup/${fname}_${TIMESTAMP}"
    fi

    command ln -snf "$f" "$HOME"
  done

  # Special handling for .claude directory
  # Claude Code uses ~/.claude for runtime data, so we symlink individual config files
  # instead of replacing the entire directory
  command echo "Setting up Claude Code configuration..."

  if [ -d "$DOT_DIR/.claude" ]; then
    # Handle ~/.claude if it's a symlink (from previous install method)
    # Migrate runtime data before removing the symlink
    if [ -L "$HOME/.claude" ]; then
      command echo "Found existing ~/.claude symlink"
      command echo "Migrating runtime data before removing symlink..."

      # Create migration directory
      MIGRATE_DIR="$HOME/.dotbackup/.claude_migrate_${TIMESTAMP}"
      command mkdir -p "$MIGRATE_DIR"

      # List of runtime files to preserve (not managed by dotfiles)
      RUNTIME_FILES=("history.jsonl" "settings.json" "settings.local.json" "stats-cache.json")
      RUNTIME_DIRS=("debug" "file-history" "ide" "plans" "plugins" "projects" "session-env" "shell-snapshots" "statsig" "todos")

      # Migrate runtime files - use $HOME/.claude which auto-dereferences the symlink
      MIGRATION_SUCCESS=true
      for runtime in "${RUNTIME_FILES[@]}"; do
        if [ -e "$HOME/.claude/$runtime" ]; then
          if command cp -a "$HOME/.claude/$runtime" "$MIGRATE_DIR/"; then
            command echo "  Migrated: $runtime"
          else
            command echo "  Warning: Failed to migrate $runtime" >&2
            MIGRATION_SUCCESS=false
          fi
        fi
      done

      for runtime in "${RUNTIME_DIRS[@]}"; do
        if [ -d "$HOME/.claude/$runtime" ]; then
          if command cp -a "$HOME/.claude/$runtime" "$MIGRATE_DIR/"; then
            command echo "  Migrated: $runtime/"
          else
            command echo "  Warning: Failed to migrate $runtime/" >&2
            MIGRATION_SUCCESS=false
          fi
        fi
      done

      # Only remove symlink if migration succeeded or nothing to migrate
      if [ "$MIGRATION_SUCCESS" = true ]; then
        # Remove the symlink
        command rm -f "$HOME/.claude"

        # Create real directory and restore runtime data
        command mkdir -p "$HOME/.claude"
        if [ "$(ls -A "$MIGRATE_DIR" 2>/dev/null)" ]; then
          command cp -a "$MIGRATE_DIR"/* "$HOME/.claude/"
          command echo "Runtime data restored to ~/.claude"
        fi
      else
        command echo "Error: Migration failed, symlink not removed" >&2
        exit 1
      fi
    fi

    # Handle ~/.claude if it's a regular file (unusual but possible)
    if [ -f "$HOME/.claude" ]; then
      command echo "Found ~/.claude as a file, backing up..."
      command mv "$HOME/.claude" "$HOME/.dotbackup/.claude_file_${TIMESTAMP}"
    fi

    # Ensure ~/.claude is a real directory
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

        # Backup existing file/directory (not symlink) with timestamp
        if [ -e "$dest" ]; then
          command echo "Backing up $dest"
          command mv "$dest" "$HOME/.dotbackup/.claude_${config}_${TIMESTAMP}"
        fi

        # Create symlink
        command ln -snf "$src" "$dest"
        command echo "Linked: $dest -> $src"
      fi
    done
  fi

  # Lazygit config
  LAZYGIT_CONFIG_SRC="$DOT_DIR/.config/lazygit/config.yml"
  LAZYGIT_CONFIG_DIR="$HOME/Library/Application Support/lazygit"
  LAZYGIT_CONFIG_DEST="$LAZYGIT_CONFIG_DIR/config.yml"

  if [ -e "$LAZYGIT_CONFIG_SRC" ]; then
    command mkdir -p "$LAZYGIT_CONFIG_DIR"

    if [ -L "$LAZYGIT_CONFIG_DEST" ]; then
      command rm -f "$LAZYGIT_CONFIG_DEST"
    fi

    if [ -e "$LAZYGIT_CONFIG_DEST" ]; then
      command mv "$LAZYGIT_CONFIG_DEST" "$HOME/.dotbackup/lazygit_config_${TIMESTAMP}.yml"
    fi

    command ln -snf "$LAZYGIT_CONFIG_SRC" "$LAZYGIT_CONFIG_DEST"
    command echo "Linked: $LAZYGIT_CONFIG_DEST -> $LAZYGIT_CONFIG_SRC"
  fi

  # Obsidian Vim config
  OBSIDIAN_VAULT_DIR="$HOME/Documents/Obsidian Vault"
  OBSIDIAN_VIMRC_SRC="$DOT_DIR/.config/obsidian/.obsidian.vimrc"
  OBSIDIAN_VIMRC_DEST="$OBSIDIAN_VAULT_DIR/.obsidian.vimrc"

  if [ -e "$OBSIDIAN_VIMRC_SRC" ]; then
    if [ -d "$OBSIDIAN_VAULT_DIR" ]; then
      if [ -L "$OBSIDIAN_VIMRC_DEST" ]; then
        command rm -f "$OBSIDIAN_VIMRC_DEST"
      fi

      if [ -e "$OBSIDIAN_VIMRC_DEST" ]; then
        command mv "$OBSIDIAN_VIMRC_DEST" "$HOME/.dotbackup/.obsidian.vimrc_${TIMESTAMP}"
      fi

      command ln -snf "$OBSIDIAN_VIMRC_SRC" "$OBSIDIAN_VIMRC_DEST"
      command echo "Linked: $OBSIDIAN_VIMRC_DEST -> $OBSIDIAN_VIMRC_SRC"
    else
      command echo "Warning: Obsidian vault not found at $OBSIDIAN_VAULT_DIR, skipped linking .obsidian.vimrc" >&2
    fi
  fi
else
  command echo "same install src dest"
fi
