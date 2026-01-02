#!/usr/bin/env zsh
set -ue

# Check if Command Line Tools are installed
if xcode-select -p &>/dev/null; then
  command echo "Command Line Tools are already installed"
  command echo "Path: $(xcode-select -p)"
else
  # Install Command Line Tools
  command echo "Installing Command Line Tools..."
  command echo "A dialog will appear. Please follow the installation process."

  xcode-select --install 2>&1 | grep -v "command line tools are already installed" || true

  command echo ""
  command echo "Please complete the Command Line Tools installation and run this script again."
  command echo "Or continue with the installation if the tools are already installed."
fi

