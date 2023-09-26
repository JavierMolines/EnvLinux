#!/bin/bash

host="$( pwd )"
whojav="/home/$( whoami )"
loadScriptVar="\n# COMMAND CUSTOM AUTOLOAD\n"
loadScriptVar+="source $host/EnvLinux/scripts/alias.sh\n"
loadScriptVar+="source $host/EnvLinux/scripts/myFunctions.sh\n"

echo -e "$loadScriptVar" >> "$whojav/.zshrc" 

if [[ $? -eq 0 ]]
then
    rm -rf $whojav/.config/kitty && ln -s -f $host/EnvLinux/kitty $whojav/.config/kitty
    if [[ $? -eq 0 ]]
    then
        echo -e "-> Config and files load Successfully, restart the terminal."
    fi
fi
