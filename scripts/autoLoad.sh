#!/bin/bash

host="$( pwd )"
loadScriptVar="\n# COMMAND CUSTOM AUTOLOAD\n"
loadScriptVar+="source $host/EnvLinux/scripts/alias.sh\n"
loadScriptVar+="source $host/EnvLinux/scripts/myFunctions.sh\n"

echo -e "$loadScriptVar" >> "/home/$( whoami )/.zshrc" && echo -e "\t> Config and files load Successfully, restart the terminal."