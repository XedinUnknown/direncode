#!/bin/bash

# Function to encode a directory and its contents into a base64 string
encode_directory() {
    local dir_path=$1
    tar cz "$dir_path" | base64
}

# Function to display help message
display_help() {
    echo "Usage: direncode [DIRECTORY]"
    echo "Encode a directory and its contents into a base64 string."
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message and exit."
    echo
    echo "If DIRECTORY is not provided, the current working directory is encoded."
    echo
    echo "Example:"
    echo "  direncode path/to/source_directory > encoded_output.txt"
    exit 0
}

# Check if help flag is provided
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    display_help
fi

# Check if directory path is provided as an argument
if [ $# -eq 1 ]; then
    directory=$1
else
    directory="."
fi

# Encode directory
encode_directory "$directory"