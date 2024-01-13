#!/bin/bash

echo "-> EnvLinux load config..."

host="$(pwd)"
whojav="/home/$(whoami)"

loadScriptVar="
# CONFIG ZSH
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="clean"
plugins=(git zsh-syntax-highlighting)
source \$ZSH/oh-my-zsh.sh

# GO
export GOPATH=\$HOME/Source/go
export GOBIN=\$GOPATH/bin
export GOROOT=/usr/lib/golang
  
export PATH=\$PATH:\$GOBIN:\$GOROOT/bin

# COMMAND CUSTOM AUTOLOAD
source $host/EnvLinux/scripts/alias.sh
source $host/EnvLinux/scripts/myFunctions.sh
"

echo -e "$loadScriptVar" >> "$whojav/.zshrc" 

if [[ $? -eq 0 ]]
then
    rm -rf $whojav/.config/kitty && ln -s -f $host/EnvLinux/kitty $whojav/.config/kitty
    if [[ $? -eq 0 ]]
    then
        echo "-> Config and files load Successfully, restart the terminal."
    fi
fi
