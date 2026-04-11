#!/bin/bash

# Default log file (used if no argument is provided)
LOG_FILE=${1:-logs.txt}

# Ensure the log file exists
if [ ! -f "$LOG_FILE" ]; then
    exit 1
fi

# Identify the attacker's IP (the one with the most requests)
ATTACKER_IP=$(awk '{print $1}' "$LOG_FILE" | \
    sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# Extract and identify the most common User-Agent used by the attacker
grep "^$ATTACKER_IP " "$LOG_FILE" | \
    awk -F\" '{print $6}' | \
    sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
