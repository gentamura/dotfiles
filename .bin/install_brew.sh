#!/usr/bin/env zsh
set -ue

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
DOT_DIR=$(dirname "${SCRIPT_DIR}")
BREWFILE="$DOT_DIR/Brewfile"

if which brew >/dev/null 2>&1; then
  echo "Homebrew is already installed."
else
  echo "Installing Homebrew..."
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "Run brew update..."
brew update

echo "Run brew upgrade..."
brew upgrade

if [ -f "$BREWFILE" ]; then
  echo "Installing packages from Brewfile..."
  brew bundle --file="$BREWFILE"
else
  echo "Warning: Brewfile not found at $BREWFILE"
fi

brew cleanup

