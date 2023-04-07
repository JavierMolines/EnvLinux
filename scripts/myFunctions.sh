#!/bin/bash

read_file () {
  cat -b $1 && echo ""
}

stmf () {
  MAIN_FOLDER_ZSH="$(pwd)"
  alias gtmf="cd $MAIN_FOLDER_ZSH"
  echo ">> Main Folder [$(echo $MAIN_FOLDER_ZSH)]"
}

# Comments

# alias dock="sudo docker" # I define it this way so as not to create a docker group.
# alias rrbash="source ~/.bashrc"
# alias cat="read_file"
# xdg-open -> open file manager
# while read p; do echo "$p"; done < ~/Desktop/bash/EnvLinux/notes/zsh-theme-clean-custom.txt > ~/.oh-my-zsh/themes/clean.zsh-theme