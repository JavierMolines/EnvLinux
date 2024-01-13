# MOVEMENT BETWEEN FOLDERS
prefixRoute="cd ~/Source"

alias gtky="$prefixRoute/bash/EnvLinux/"
alias gtbash="$prefixRoute/bash/"
alias gtjs="$prefixRoute/js/"
alias gtphp="$prefixRoute/php/"
alias gtpy="$prefixRoute/python/"
alias gtgo="$prefixRoute/go/src/"

# GIT COMMANDS
alias ggc="git clone"
alias ggu="git push"
alias ggp="git pull"
alias ggt="git status"
alias gga="git add ."
alias ggm="git commit -m"
alias ggk="git checkout"

# DOCKER COMMANDS
alias doc="docker compose"
alias kerrmi='docker rmi $(docker images -qf "dangling=true")'

# OTHERS
alias vs="code ."
alias nr="npm run"
alias jave="nvim ~/.zshrc"
alias javs="bat ~/.zshrc"
alias gi="grep -i"
alias lgi="l | gi"
alias py="python3"
alias pip="~/.local/bin/pip3"