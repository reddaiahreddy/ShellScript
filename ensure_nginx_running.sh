#!/bin/bash

# Define the process name and the command to start it
PROCESS_NAME="nginx"
START_COMMAND="systemctl start nginx"

# Check if the process name and start command are provided
if [ -z "$PROCESS_NAME" ] || [ -z "$START_COMMAND" ]; then
  echo "Usage: $0 <process_name> <start_command>"
  exit 1
fi

# Check if the process is running
if pgrep "$PROCESS_NAME" > /dev/null; then
  echo "Process '$PROCESS_NAME' is already running."
else
  echo "Process '$PROCESS_NAME' is not running. Starting it..."
  # Execute the start command
  eval "$START_COMMAND"
  if [ $? -eq 0 ]; then
    echo "Process '$PROCESS_NAME' started successfully."
  else
    echo "Failed to start process '$PROCESS_NAME'."
  fi
fi

