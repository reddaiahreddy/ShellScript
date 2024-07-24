#!/bin/bash
SOURCE_DIR=$1
DEST_DIR=$2

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  exit 1
fi

echo "Backing up $SOURCE_DIR to $DEST_DIR"
cp -r "$SOURCE_DIR" "$DEST_DIR"
echo "Backup completed."

