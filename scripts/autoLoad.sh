#!/bin/bash

host="$( pwd )"
loadScriptVar="# COMMAND CUSTOM AUTOLOAD\n"
loadScriptVar+="source $host/alias.sh\n"
loadScriptVar+="source $host/myFunctions.sh\n"

echo -e "$loadScriptVar" >> "/home/$( whoami )/.zshrc" && echo -e "\t> Config and files load Successfully, restart the terminal."