#!/usr/bin/env zsh
set -ue

if which brew >/dev/null 2>&1; then
  echo "Homebrew is already installed."
else
  echo "Installing Homebrew..."
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "Run brew doctor..."
  which brew >/dev/null 2>&1 && brew doctor

  echo "Run brew update..."
  brew update

  echo "Run brew upgrade..."
  brew upgrade

  brew bundle

  brew cleanup
fi

