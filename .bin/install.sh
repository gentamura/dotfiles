#!/usr/bin/env zsh
set -ue

helpmsg() {
  command echo "Usage: $0 [--help | -h | init | brew | link | debug]" 0>&2
  command echo ""
}

SCRIPT_DIR="$(cd "$(dirname $0)" && pwd -P)"

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    init)
      "$SCRIPT_DIR/install_init.sh"
      "$SCRIPT_DIR/install_brew.sh"
      "$SCRIPT_DIR/install_link.sh"
      # git config --global include.path "~/.gitconfig_shared"
      command echo -e "\e[1;36m Install completed!!!! \e[m"
      ;;
    brew)
      "$SCRIPT_DIR/install_brew.sh"
      ;;
    link)
      "$SCRIPT_DIR/install_link.sh"
      ;;
    debug)
      ;;
    *)
      command echo "Invalid option: ${1}" 1>&2
      helpmsg
      exit 1
      ;;
  esac
  shift
done

