# dotfiles

Personal dotfiles for macOS development environment setup.

## Quick Start

### Bootstrap (First Time Setup)

For a brand new Mac without Git installed, use the bootstrap script:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/gentamura/dotfiles/main/bootstrap.sh)"
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

## Installation Components

### Full Installation

```bash
.bin/install.sh init
```

This runs all installation steps:
1. Command Line Tools check/installation
2. Homebrew installation and package setup
3. Dotfiles symlinking

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

Installs Homebrew (if needed) and all packages defined in `Brewfile`, including:
- Development tools (git, gh, neovim, tmux, etc.)
- Programming languages (rust, openjdk, etc.)
- Databases (postgresql, mysql, mongodb)
- Applications (Docker Desktop, iTerm2, VS Code, etc.)
- Security tools (git-secrets)

#### Dotfiles Linking

```bash
.bin/install.sh link
# or directly
.bin/install_link.sh
```

Creates symbolic links from this repository to your home directory. Existing files are backed up to `~/.dotbackup`.

## What's Included

### Configuration Files

- `.gitconfig` - Git configuration
- `.config/zed/` - Zed editor settings
- `.config/mise/` - Mise tool configuration
- `.stylua.toml` - Lua formatting configuration

### Claude Code Configuration

AI-assisted development configuration in `.claude/`:

| Component | Purpose |
|-----------|---------|
| `rules/` | Coding standards (TypeScript, React, Drizzle, Git, Terraform, SST) |
| `agents/` | Role-based agents (tech-lead, frontend, backend, infra, qa) |
| `commands/` | Slash commands (`/req`, `/adr`, `/pr:review`, `/release`) |
| `skills/` | Reusable procedures (requirements, ADR, migration, hotfix) |

See [.claude/README.md](.claude/README.md) for detailed documentation.

### Development Tools

See `Brewfile` for the complete list of installed tools and applications.

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
├── .claude/              # Claude Code configuration
│   ├── CLAUDE.md         # Operating model for Claude
│   ├── README.md         # Human documentation
│   ├── rules/            # Coding standards
│   ├── agents/           # Role-based agents
│   ├── commands/         # Slash commands
│   └── skills/           # Reusable procedures
├── .config/              # Application configurations
├── .gitconfig            # Git configuration
└── README.md             # This file
```

## License

MIT
