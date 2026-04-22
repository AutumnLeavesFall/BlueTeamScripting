#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "inventory.sh run fail"
    exit 1
fi

echo "Gathering Inventory..."
echo -e "\n~~~~~\n"




# List OS and Version
echo -n "Operating System: "
cat /etc/os-release | grep "NAME" | grep -o "\"[a-zA-Z]*\"" | grep -o "[a-zA-Z]*"
echo -n "Version: "
cat /etc/os-release | grep "VERSION=" | grep -o "\".*\"" | grep -o "[^\"]*"
echo -n "Hostname: "
hostname

echo -e "\n~~~~~\n"


# IP and MAC address
echo -n "IP Address: "
ip addr | grep -o "inet [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -v "127.0.0.1"

echo -n "MAC Address: "
ip -brief link | grep -o "[0-9a-fA-F]*:[0-9a-fA-F]*:[0-9a-fA-F]*:[0-9a-fA-F]*:[0-9a-fA-F]*:[0-9a-fA-F]*" | grep -v "00:00:00:00:00:00"

echo -e "\n~~~~~\n"


# Admin Users
echo "Admin Users:"

    #admin users label varies by linux distro
getent group sudo | cut -d: -f4 
getent group admin | cut -d: -f4
getent group wheel | cut -d: -f4

echo -e "\n~~~~~\n"


# Users
echo "All Users"

echo -e "\n~~~~~\n"


# Open Ports
echo "Open Ports"