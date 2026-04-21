#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "ssh_keys.sh run fail"
    exit 1
fi
keylist=""
while IFS= read -r key; do
    echo "Key: $key"
    read -p "Remove key? y/n " removekey </dev/tty
    case $removekey in 
        [Yy] )
            echo "Removing key..."
            ;;
        [Nn] )
            echo "Key approved."
            keylist += $key + "\n"
            ;;
        * )
            echo "Invalid response. Please try again"
            ;;
    esac
done < ~/.ssh/authorized_keys