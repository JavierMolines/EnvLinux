# MOVEMENT BETWEEN FOLDERS
prefixRoute="cd ~/Desktop"

alias gtb="$prefixRoute/bash/"
alias gtj="$prefixRoute/javier/"
alias gtjs="$prefixRoute/javier/js/"
alias gtky="$prefixRoute/bash/EnvLinux/"
alias gtgo="$prefixRoute/javier/go/src/"

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
alias bat="batcat"
alias jave="nvim ~/.zshrc"
alias javs="bat ~/.zshrc"
alias gi="grep -i"
alias lgi="l | gi"
