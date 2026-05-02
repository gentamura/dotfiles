#!/usr/bin/env bash
set -ue

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

DOTFILES_REPO="https://github.com/gentamura/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_INSTALL_ARGS="${DOTFILES_INSTALL_ARGS:-init}"

echo -e "${CYAN}======================================${NC}"
echo -e "${CYAN}  dotfiles Bootstrap Script${NC}"
echo -e "${CYAN}======================================${NC}"
echo ""

# Check if Command Line Tools are installed
check_command_line_tools() {
  echo -e "${CYAN}Checking Command Line Tools...${NC}"

  if xcode-select -p &>/dev/null; then
    echo -e "${GREEN}✓ Command Line Tools are already installed${NC}"
    return 0
  else
    echo -e "${YELLOW}Command Line Tools are not installed${NC}"
    return 1
  fi
}

# Install Command Line Tools
install_command_line_tools() {
  echo -e "${CYAN}Installing Command Line Tools...${NC}"
  echo -e "${YELLOW}A dialog will appear. Please follow the installation process.${NC}"

  xcode-select --install

  echo -e "${YELLOW}Waiting for Command Line Tools installation to complete...${NC}"
  echo -e "${YELLOW}Press any key after the installation is complete.${NC}"
  read -n 1 -s

  if xcode-select -p &>/dev/null; then
    echo -e "${GREEN}✓ Command Line Tools installed successfully${NC}"
  else
    echo -e "${RED}✗ Command Line Tools installation failed${NC}"
    exit 1
  fi
}

# Check if Git is available
check_git() {
  echo -e "${CYAN}Checking Git...${NC}"

  if command -v git &>/dev/null; then
    echo -e "${GREEN}✓ Git is available ($(git --version))${NC}"
    return 0
  else
    echo -e "${RED}✗ Git is not available${NC}"
    return 1
  fi
}

# Clone dotfiles repository
clone_dotfiles() {
  echo -e "${CYAN}Cloning dotfiles repository...${NC}"

  if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}Directory $DOTFILES_DIR already exists${NC}"
    echo -e "${YELLOW}Do you want to remove it and re-clone? [y/N]${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      rm -rf "$DOTFILES_DIR"
    else
      echo -e "${YELLOW}Skipping clone. Using existing directory.${NC}"
      return 0
    fi
  fi

  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Repository cloned successfully${NC}"
  else
    echo -e "${RED}✗ Failed to clone repository${NC}"
    exit 1
  fi
}

# Run installation script
run_installation() {
  echo -e "${CYAN}Running installation script...${NC}"

  cd "$DOTFILES_DIR"

  if [ -f ".bin/install.sh" ]; then
    read -r -a install_args <<< "$DOTFILES_INSTALL_ARGS"
    .bin/install.sh "${install_args[@]}"
  else
    echo -e "${RED}✗ Installation script not found${NC}"
    exit 1
  fi
}

# Main execution
main() {
  # Step 1: Check and install Command Line Tools
  if ! check_command_line_tools; then
    install_command_line_tools
  fi

  echo ""

  # Step 2: Verify Git is available
  if ! check_git; then
    echo -e "${RED}✗ Git is still not available after installing Command Line Tools${NC}"
    echo -e "${RED}Please restart your terminal and run this script again.${NC}"
    exit 1
  fi

  echo ""

  # Step 3: Clone dotfiles repository
  clone_dotfiles

  echo ""

  # Step 4: Run installation
  run_installation

  echo ""
  echo -e "${GREEN}======================================${NC}"
  echo -e "${GREEN}  Bootstrap completed successfully!${NC}"
  echo -e "${GREEN}======================================${NC}"
  echo ""
  echo -e "${CYAN}Next steps:${NC}"
  echo -e "  1. Restart your terminal"
  echo -e "  2. Check your shell configuration"
  echo ""
}

main
