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
alias ggb="git branch"
alias ggfp="git fetch --prune"
alias glog="git --no-pager log --oneline --format=\"%h %ad %s\" --date=short -n 10"

# DOCKER COMMANDS
alias dk="docker"
alias doc="docker compose"
alias kerrmi='docker rmi $(docker images -qf "dangling=true")'

# OTHERS
alias cpc="xclip -selection clipboard"
alias spath="echo \$PATH | sed 's/:/\n/g'"
alias ala="alacritty &"
alias gor="go run ."
alias b="batcat"
alias vs="code ."
alias zd="zed ."
alias nr="npm run"
alias v="nvim"
alias jave="nvim ~/.zshrc"
alias javs="b ~/.zshrc"
alias gi="grep -i"
alias lgi="l | gi"
alias py="python3"
alias pip="~/.local/bin/pip3"
alias ffnv="cd ~/.config/nvim/"
