#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "ssh_keys.sh run fail"
    exit 1
fi

read -r key <~/.ssh/authorized_keys
echo "Key: $key"
read -p "Remove key? y/n " removekey </dev/tty
case $removekey in 
    [Yy] )
        #
        ;;
    [Nn] )
        echo "Key approved."
        ;;
    esac