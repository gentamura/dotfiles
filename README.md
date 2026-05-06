# dotfiles

Personal dotfiles for macOS development environment setup.

## Quick Start

### Bootstrap (First Time Setup)

For a brand new Mac without Git installed, use the bootstrap script:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/gentamura/dotfiles/main/bootstrap.sh)"
```

To bootstrap without Homebrew casks:

```bash
DOTFILES_INSTALL_ARGS="init --no-cask" bash -c "$(curl -fsSL https://raw.githubusercontent.com/gentamura/dotfiles/main/bootstrap.sh)"
```

This script will:
1. Check and install Command Line Tools (includes Git)
2. Clone this repository to `~/dotfiles`
3. Run the full installation process

### Manual Installation

If you already have Git installed:

```bash
# Clone the repository
git clone https://github.com/gentamura/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the full installation
.bin/install.sh init
```

For a managed/company Mac where Homebrew casks are restricted:

```bash
.bin/install.sh init --no-cask
```

## Installation Components

### Full Installation

```bash
.bin/install.sh init
```

This runs all installation steps:
1. Command Line Tools check/installation
2. Homebrew installation and package setup
3. Dotfiles symlinking

By default this installs both command-line tools from `Brewfile` and GUI apps/fonts
from `Brewfile.casks`. To install only command-line tools such as `neovim`, `rg`,
`gh`, `tmux`, and `jq`, pass `--no-cask`:

```bash
.bin/install.sh init --no-cask
```

### Individual Components

You can run individual installation steps:

#### Command Line Tools

```bash
.bin/install.sh init
# or directly
.bin/install_init.sh
```

Checks if Command Line Tools are installed and installs them if needed.

#### Homebrew & Packages

```bash
.bin/install.sh brew
# or directly
.bin/install_brew.sh
```

Installs Homebrew (if needed), command-line packages defined in `Brewfile`, and
GUI apps/fonts defined in `Brewfile.casks`, including:
- Development tools (git, gh, neovim, tmux, etc.)
- Programming language tooling (rustup, openjdk, etc.)
- Applications (Docker Desktop, iTerm2, VS Code, etc.)
- Security tools (git-secrets)

Rust is installed through `rustup`, not the fixed Homebrew `rust` formula. After
installing Homebrew packages, initialize a default toolchain:

```bash
rustup default stable
```

Use `rustup toolchain install nightly` or `rustup target add <target>` when a
project needs another channel or cross-compilation target.

To skip casks:

```bash
.bin/install.sh brew --no-cask
# or directly
.bin/install_brew.sh --no-cask
```

You can also set `DOTFILES_SKIP_BREW_CASKS=1` for non-interactive setup:

```bash
DOTFILES_SKIP_BREW_CASKS=1 .bin/install.sh init
```

#### Dotfiles Linking

```bash
.bin/install.sh link
# or directly
.bin/install_link.sh
```

Creates symbolic links from this repository to your home directory. Existing files are backed up to `~/.dotbackup`.

For machine-local/private shell variables, use `.zshrc.local`:
- Keep the real file at `~/dotfiles/.zshrc.local` (not tracked by Git)
- Symlink `~/.zshrc.local` to that file
- `.zshrc` loads `~/.zshrc.local` automatically if present

Example:
```bash
cat > ~/dotfiles/.zshrc.local <<'EOF'
# 00-env
export OBSIDIAN_VAULT="$HOME/Documents/Obsidian Vault"
EOF
ln -snf ~/dotfiles/.zshrc.local ~/.zshrc.local
```

#### Git Configuration

Shared Git settings live in `.gitconfig_shared` and are symlinked to
`~/.gitconfig_shared`. Personal settings (name, email, signing keys, etc.)
belong in your own `~/.gitconfig`, which `install_link.sh` does **not**
overwrite.

`install_link.sh` idempotently adds the include directive:

```ini
# ~/.gitconfig
[include]
  path = ~/.gitconfig_shared
```

Set your identity once (or rely on the warning printed by `install_link.sh`):

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

## What's Included

### Configuration Files

- `.gitconfig_shared` - Shared Git settings (included from `~/.gitconfig`)
- `.config/mise/` - Mise tool configuration
- `.config/nvim/.stylua.toml` - Lua formatting configuration (scoped to nvim)

### AI Agent Configuration

This repository supports both Codex and Claude workflows:

| Component | Purpose | Location |
|-----------|---------|----------|
| Agent entrypoint | Shared agent operating index | `AGENTS.md` |
| Shared skills | Reusable procedures for both Codex and Claude | `skills/` |
| Claude rules | Always-on coding constraints | `.claude/rules/` |
| Claude agents | Role-based delegation profiles | `.claude/agents/` |
| Claude commands | Slash-command workflow templates | `.claude/commands/` |

Notes:
- `install_link.sh` links `~/.claude/skills` to repo `skills/`.
- `install_link.sh` keeps `~/.codex/skills/.system` and links each shared skill directory from repo `skills/` into `~/.codex/skills/`.
- `install_link.sh` symlinks Claude config items (`CLAUDE.md`, `README.md`, `rules/`, `agents/`, `commands/`) into `~/.claude/` without replacing the whole `~/.claude` runtime directory.

See [.claude/CLAUDE.md](.claude/CLAUDE.md), [AGENTS.md](AGENTS.md) and [.claude/README.md](.claude/README.md) for details.

### Development Tools

See `Brewfile` for command-line tools and `Brewfile.casks` for GUI apps and fonts.

### Tmux + Lazygit Workflow

`~/.config/lazygit/config.yml` defines a custom key in the `files` panel:

- `O` (Shift+o): open the selected file in `tmux` window `:1`
  - If window `:1` is running `nvim`/`vim`, send `:e <selected-file>`
  - Otherwise, run `nvim <selected-file>` in window `:1`
  - Then switch focus to window `:1` and close the tmux popup

Notes:
- `o` (lowercase) remains lazygit's default open action.
- This workflow assumes your main editor pane is in tmux window `:1`.

## Requirements

- macOS
- Internet connection

## Troubleshooting

### Command Line Tools Installation

If the Command Line Tools installation dialog doesn't appear or fails:

1. Try installing manually:
   ```bash
   xcode-select --install
   ```

2. If already installed, verify:
   ```bash
   xcode-select -p
   ```

### Homebrew Issues

If Homebrew installation fails:

1. Check the official installation guide: https://brew.sh
2. Ensure you have sufficient permissions
3. Try installing manually and then run `.bin/install_brew.sh`

## Structure

```
dotfiles/
├── bootstrap.sh          # Bootstrap script for first-time setup
├── .bin/                 # Installation scripts
│   ├── install.sh        # Main installation script
│   ├── install_init.sh   # Command Line Tools installation
│   ├── install_brew.sh   # Homebrew and packages installation
│   └── install_link.sh   # Dotfiles symlinking
├── Brewfile              # Homebrew packages definition
├── Brewfile.casks        # Homebrew cask applications and fonts
├── AGENTS.md             # Shared agent entrypoint for local AI coding agents
├── skills/               # Shared skills (used by Codex and Claude)
├── .claude/              # Claude-specific configuration
│   ├── CLAUDE.md         # Operating model for Claude
│   ├── README.md         # Human documentation
│   ├── rules/            # Coding standards
│   ├── agents/           # Role-based agents
│   ├── commands/         # Slash commands
├── .config/              # Application configurations
├── .gitconfig_shared     # Shared Git settings (included from ~/.gitconfig)
└── README.md             # This file
```

## License

MIT
