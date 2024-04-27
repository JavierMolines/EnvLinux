#!/bin/bash

docker_up_redis () {
  docker run --name db_redis -p 6379:6379 -d redis
}

make_node_project () {
  mkdir $1 && cd $1 && npm init -y && npm i -ED jav-blast-setup && npx jav-blast-setup -i && npm i
}

getMyIp () {
  # Get IP address in Fedora
  ip addr show | gi "192.168" | awk '{print $2}'
}

stmf () {
  MAIN_FOLDER_ZSH="$(pwd)"
  alias gtmf="cd $MAIN_FOLDER_ZSH"
  echo ">> Main Folder [$(echo $MAIN_FOLDER_ZSH)]"
}

make_go_project () {
  if [ -z "$1" ]; then
    echo "Usage: make_go_project <project_name>"
    return 1
  fi

  project_name=$1
  project_dir="./$project_name"

  if mkdir "$project_dir"; then
    echo "--> Directory '$project_dir' created."
  else
    echo "Failed to create directory '$project_dir'."
    return 1
  fi

  if cd "$project_dir"; then
    echo "--> Changed to directory '$project_dir'."
  else
    echo "Failed to change to directory '$project_dir'."
    return 1
  fi

  if go mod init "github.com/JavierMolines/$project_name"; then
    echo "--> Go module initialized"
  else
    echo "Failed to initialize Go module."
    return 1
  fi

  if git init; then
    echo "--> Git repository initialized."
  else
    echo "Failed to initialize Git repository."
    return 1
  fi

  go_file_init=$(cat <<-END
package main

import "fmt"

func main() {
  fmt.Println("Hello World!")
}
END
)

  if echo -e "$go_file_init" >> "main.go"; then
    echo "--> main.go created."
  else
    echo "Failed to create main.go."
    return 1
  fi

  echo "--> Project setup completed successfully."
}
