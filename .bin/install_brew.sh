#!/usr/bin/env zsh
set -ue

SCRIPT_NAME="${0:t}"

helpmsg() {
  command echo "Usage: $SCRIPT_NAME [--no-cask | --with-cask | --help]" 0>&2
  command echo "" 0>&2
  command echo "Installs Homebrew formulae from Brewfile." 0>&2
  command echo "By default, also installs GUI apps and fonts from Brewfile.casks." 0>&2
  command echo "Set DOTFILES_SKIP_BREW_CASKS=1 or pass --no-cask to skip casks." 0>&2
}

INSTALL_CASKS=true

if [[ "${DOTFILES_SKIP_BREW_CASKS:-}" == "1" ]]; then
  INSTALL_CASKS=false
fi

while [ $# -gt 0 ]; do
  case "$1" in
    --no-cask|--no-casks)
      INSTALL_CASKS=false
      ;;
    --with-cask|--with-casks)
      INSTALL_CASKS=true
      ;;
    --help|-h)
      helpmsg
      exit 0
      ;;
    *)
      command echo "Invalid option for install_brew.sh: $1" 1>&2
      helpmsg
      exit 1
      ;;
  esac
  shift
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
DOT_DIR=$(dirname "${SCRIPT_DIR}")
BREWFILE="$DOT_DIR/Brewfile"
BREWFILE_CASKS="$DOT_DIR/Brewfile.casks"

if which brew >/dev/null 2>&1; then
  echo "Homebrew is already installed."
else
  echo "Installing Homebrew..."
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Run brew doctor..."
brew doctor || echo "Warning: brew doctor found issues, but continuing..."

echo "Run brew update..."
brew update || echo "Warning: brew update failed, but continuing..."

if [ "$INSTALL_CASKS" = true ]; then
  echo "Run brew upgrade..."
  brew upgrade || echo "Warning: brew upgrade failed, but continuing..."
else
  echo "Run brew upgrade --formula..."
  brew upgrade --formula || echo "Warning: brew upgrade --formula failed, but continuing..."
fi

if [ -f "$BREWFILE" ]; then
  echo "Installing command-line packages from Brewfile..."
  brew bundle --file="$BREWFILE"
else
  echo "Warning: Brewfile not found at $BREWFILE"
fi

if [ "$INSTALL_CASKS" = true ]; then
  if [ -f "$BREWFILE_CASKS" ]; then
    echo "Installing GUI apps and fonts from Brewfile.casks..."
    brew bundle --file="$BREWFILE_CASKS"
  else
    echo "Warning: Brewfile.casks not found at $BREWFILE_CASKS"
  fi
else
  echo "Skipping Homebrew casks. Run '$SCRIPT_NAME --with-cask' later to install them."
fi

brew cleanup || echo "Warning: brew cleanup failed, but continuing..."
