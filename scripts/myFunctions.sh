#!/bin/bash

make_new_go_proyect () {
  go mod init github.com/JavierMolines/$(basename $(pwd))
  git init
}

read_file () {
  cat -b $1 && echo ""
}

stmf () {
  MAIN_FOLDER_ZSH="$(pwd)"
  alias gtmf="cd $MAIN_FOLDER_ZSH"
  echo ">> Main Folder [$(echo $MAIN_FOLDER_ZSH)]"
}
