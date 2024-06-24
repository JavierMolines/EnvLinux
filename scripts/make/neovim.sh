#!/bin/bash

FILE="$HOME/.config/nvim/init.vim"

contentFile="
set number
set encoding=utf-8
set relativenumber
syntax enable
"

DIR=$(dirname "$FILE")

mkdir -p "$DIR"

if [ ! -f "$FILE" ]; then
    echo -e "$contentFile" >> "$FILE" 
    echo "--> $FILE created successfull."
else
    echo "--> $FILE is exits."
fi
