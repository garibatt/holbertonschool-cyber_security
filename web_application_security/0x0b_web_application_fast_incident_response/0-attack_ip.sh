#!/bin/bash

# Check if file exists
if [ ! -f "logs.txt" ]; then
    echo "Error: logs.txt not found"
    exit 1
fi

# Extract IPs, count occurrences, and find the top one
top_ip=$(awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | head -n 1)

# Output result
echo "Top IP address (most requests):"
echo "$top_ip"
