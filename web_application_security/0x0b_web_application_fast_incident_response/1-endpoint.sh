#!/bin/bash

# Extract requested endpoint (Common Log Format → field 7)
awk '{print $7}' logs.txt | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
