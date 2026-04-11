#!/bin/bash

# Check if a log file is provided; otherwise use the default logs.txt
LOG_FILE=${1:-logs.txt}

# Ensure the log file exists
if [ ! -f "$LOG_FILE" ]; then
    exit 1
fi

# Identify the attacker (IP with the most requests) and count the requests
awk '{print $1}' "$LOG_FILE" | \
sort | uniq -c | \
sort -nr | \
head -n 1 | \
awk '{print $1}'
