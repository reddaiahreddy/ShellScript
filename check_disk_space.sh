#!/bin/bash

# Define the threshold percentage (e.g., 10% free space)
THRESHOLD=10

# Define the email parameters
EMAIL="user@example.com"
SUBJECT="Disk Space Alert"
FROM="sender@example.com"
BODY="Disk space is critically low on $(hostname). Current usage is ${DISK_USAGE}%."

# Get the current available disk space percentage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//')

# Check if the current disk usage is greater than or equal to the threshold
if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
  # Create a temporary file for the email
  TEMP_FILE=$(mktemp)
  
  # Compose the email
  echo "Subject: $SUBJECT" > $TEMP_FILE
  echo "To: $EMAIL" >> $TEMP_FILE
  echo "From: $FROM" >> $TEMP_FILE
  echo "" >> $TEMP_FILE
  echo "$BODY" >> $TEMP_FILE
  
  # Send the email
  /usr/sbin/sendmail -t < $TEMP_FILE
  
  # Remove the temporary file
  rm $TEMP_FILE
  
  echo "Warning: Disk space is critically low. Current usage: $DISK_USAGE%."
else
  echo "Disk space is sufficient. Current usage: $DISK_USAGE%."
fi
