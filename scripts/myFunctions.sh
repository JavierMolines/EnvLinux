#!/bin/bash

make_go_project () {
  go mod init github.com/JavierMolines/$(basename $(pwd))
  git init
}

make_node_project () {

  mkdir $1 && cd $1 && npm init -y && npm i -ED jav-blast-setup && npx jav-blast-setup -i && npm i

}

read_file () {
  cat -b $1 && echo ""
}

stmf () {
  MAIN_FOLDER_ZSH="$(pwd)"
  alias gtmf="cd $MAIN_FOLDER_ZSH"
  echo ">> Main Folder [$(echo $MAIN_FOLDER_ZSH)]"
}
