#!/bin/bash

# Get the file path from the first argument
FILE=$1

# Check if the file path is provided
if [ -z "$FILE" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Check if the file exists
if [ -e "$FILE" ]; then
  echo "File '$FILE' exists."
else
  echo "File '$FILE' does not exist."
fi

