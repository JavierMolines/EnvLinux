#!/bin/bash

# Variables
MAIN_FOLDER_FILE="router.txt"

# Functions
stmf () {
	MAIN_FOLDER_ZSH="$(pwd)"

  if [[ "$1" == "-a" ]]; then
	  echo ">> Add folder [$(echo $MAIN_FOLDER_ZSH)]"
		echo "$MAIN_FOLDER_ZSH" >> "$HOME/$MAIN_FOLDER_FILE"
	else
	  echo ">> Set main Folder [$(echo $MAIN_FOLDER_ZSH)]"
		echo "$MAIN_FOLDER_ZSH" > "$HOME/$MAIN_FOLDER_FILE"
	fi
}

gtmf () {
	MAIN_FOLDER_FILE_PATH="$HOME/$MAIN_FOLDER_FILE"

  # Function show help
	show_help() {
		cat << EOF
Usage: gtmf [OPTION]

Options:
  (no arguments)      Go to line 1
  -ln=NUMBER          Go to line NUMBER
  -l, --list          View all saved paths
  -h, --help          Show this help

Examples:
  gtmf                # Go to line 1
  gtmf -ln=3          # Go to line 3
  gtmf -l             # View all saved paths
EOF
	}

  # Function get line from file
	get_line() {
		local line_number=$1
		if [[ ! -f "$MAIN_FOLDER_FILE_PATH" ]]; then
			echo "Error: $MAIN_FOLDER_FILE_PATH not found."
			return 1
		fi

		local folder_path=$(sed -n "${line_number}p" "$MAIN_FOLDER_FILE_PATH")
		
		if [[ -z "$folder_path" ]]; then
			echo "Error: line $line_number does not exist in $MAIN_FOLDER_FILE_PATH"
			return 1
		fi

		echo "$folder_path"
	}

	case "$1" in
		-h|--help)
			show_help
			;;
		-l|--list)
			if [[ ! -f "$MAIN_FOLDER_FILE_PATH" ]]; then
				echo "Error: $MAIN_FOLDER_FILE_PATH not found."
				return 1
			fi
			cat "$MAIN_FOLDER_FILE_PATH"
			;;
		-ln=*)
			line_number="${1#-ln=}"
			if ! [[ "$line_number" =~ ^[0-9]+$ ]]; then
				echo "Error: line number must be a positive integer."
				return 1
			fi
			
			MAIN_FOLDER_ZSH=$(get_line "$line_number")
			if [[ $? -ne 0 ]]; then
				return 1
			fi

			echo ">> Redirect to folder (line $line_number) [$(echo $MAIN_FOLDER_ZSH)]"
			cd "$MAIN_FOLDER_ZSH"
			;;
		"")
			MAIN_FOLDER_ZSH=$(get_line 1)
			if [[ $? -ne 0 ]]; then
				return 1
			fi

			echo ">> Redirect to folder [$(echo $MAIN_FOLDER_ZSH)]"
			cd "$MAIN_FOLDER_ZSH"
			;;
		*)
			echo "Invalid option: $1"
			echo ""
			show_help
			;;
	esac
}