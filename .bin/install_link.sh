#!/usr/bin/env zsh
set -ue

command echo "backup old dotfiles..."

if [ ! -d "$HOME/.dotbackup" ];then
  command echo "$HOME/.dotbackup not found. Auto Make it"
  command mkdir "$HOME/.dotbackup"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
DOT_DIR=$(dirname ${SCRIPT_DIR})

if [[ "$HOME" != "$DOT_DIR" ]];then
  for f in $DOT_DIR/.??*; do
    [[ `basename $f` == ".git" ]] && continue

    if [[ -L "$HOME/`basename $f`" ]];then
      command rm -f "$HOME/`basename $f`"
    fi

    if [[ -e "$HOME/`basename $f`" ]];then
      command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
    fi

    command ln -snf $f $HOME
  done
else
  command echo "same install src dest"
fi


