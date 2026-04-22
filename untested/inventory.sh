#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "inventory.sh run fail"
    exit 1
fi

