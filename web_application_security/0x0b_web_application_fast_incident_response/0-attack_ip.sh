#!/bin/bash

# Extract, count, and print ONLY the IP with most requests
awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
