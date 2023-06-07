#!/bin/bash

# Function to decode a base64 string into a directory and its contents
decode_directory() {
    local base64_input=$1
    local output_dir=$2
    base64 -d <<< "$base64_input" | tar xz -C "$output_dir"
}

# Function to display help message
display_help() {
    echo "Usage: dirdecode [OUTPUT_DIRECTORY]"
    echo "Decode a base64 string from stdin into a directory and its contents."
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message and exit."
    echo
    echo "If OUTPUT_DIRECTORY is not provided, the current working directory is used."
    echo
    echo "Example 1: Decode from a file"
    echo "  cat encoded_output.txt | dirdecode path/to/output_directory"
    echo
    echo "Example 2: Decode by pasting the base64-encoded string"
    echo "  dirdecode path/to/output_directory"
    echo "  <Paste base64-encoded string>"
    exit 0
}

# Check if help flag is provided
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    display_help
fi

# Check if output directory is provided as an argument
if [ $# -eq 1 ]; then
    output_dir=$1
else
    output_dir="."
fi

# Read base64 input from stdin
if [ -t 0 ]; then
    echo "Paste the base64-encoded string below:"
fi
base64_input=$(cat -)

# Decode directory
decode_directory "$base64_input" "$output_dir"
