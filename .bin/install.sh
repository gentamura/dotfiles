#!/usr/bin/env zsh
set -ue

SCRIPT_NAME="${0:t}"

helpmsg() {
  command echo "Usage: $SCRIPT_NAME [--help | -h | --debug | init [brew-options] | brew [brew-options] | link]" 0>&2
  command echo "" 0>&2
  command echo "Brew options:" 0>&2
  command echo "  --no-cask     Skip GUI apps and fonts from Brewfile.casks" 0>&2
  command echo "  --with-cask   Install GUI apps and fonts from Brewfile.casks (default)" 0>&2
  command echo ""
}

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"

if [ $# -eq 0 ]; then
  helpmsg
  exit 1
fi

while [ $# -gt 0 ]; do
  case ${1} in
    --debug|-d)
      set -uex
      shift
      ;;
    --help|-h)
      helpmsg
      exit 0
      ;;
    init)
      shift
      "$SCRIPT_DIR/install_init.sh"
      "$SCRIPT_DIR/install_brew.sh" "$@"
      "$SCRIPT_DIR/install_link.sh"
      # git config --global include.path "~/.gitconfig_shared"
      command echo -e "\e[1;36m Install completed!!!! \e[m"
      exit 0
      ;;
    brew)
      shift
      "$SCRIPT_DIR/install_brew.sh" "$@"
      exit 0
      ;;
    link)
      shift
      "$SCRIPT_DIR/install_link.sh"
      exit 0
      ;;
    debug)
      shift
      ;;
    *)
      command echo "Invalid option: ${1}" 1>&2
      helpmsg
      exit 1
      ;;
  esac
done
