#!/bin/bash

# Check argument
if [ $# -ne 1 ]; then
    exit 1
fi

logfile="$1"

# Check file exists
if [ ! -f "$logfile" ]; then
    exit 1
fi

# Find attacker IP
attacker_ip=$(awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# Count requests from that IP
count=$(grep -c "^$attacker_ip" "$logfile")

# Output ONLY the count
echo "$count"
