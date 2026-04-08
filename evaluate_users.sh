#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "users.sh run fail"
    exit 1
fi

# Allowed user list (borrowed from IRSeC 2025)
user_list=(
  "student"
)

# reads each line in the /etc/passwd file, takes the first 2 items and labels them as variables username and pass
while IFS=':' read -r username pass _; do
    echo "~~~~~"
    username=$(echo "$username" | tr -d '[:space:]')

    # Skip system accounts (UID < 1000)
    uid=$(id -u "$username" 2>/dev/null)
    if [ -z "$uid" ] || [ "$uid" -lt 1000 ]; then
        echo "UID:$uid indicates '$username' is a system account."
        # read -p "Remove this account? y/n" sysaccrem ## why aren't you working????? this is the recommended way to read user input, tf?????
        echo "Remove this account? y/n"
        read sysaccrem
        echo "input: $sysaccrem"

        # ~~~~~
        # UID:117 indicates 'rtkit' is a system account.
        # Remove this account? y/n
        # input: colord:x:118:120:colord colour management daemon:/var/lib/colord:/usr/sbin/nologin
        # ~~~~~
        # aha! okay so the default input for the entire script is the etc/passwd file, therefore it's reading from that anytime i call read on user input


        # if [[sysaccrem == "y"]]; then
        #     echo "Removing $username..."
        #     # deluser --remove-home $username
        #     # INSERT ERROR HANDLING
        # else if [[sysaccrem == "n"]]; then
        #     echo "Skipping system account $username."
        # fi
        continue
    fi

    #if the username matches something in the approved user list, say it was approved and move on
    if printf "%s\n" "${user_list[@]}" | grep -qxF "$username"; then
        echo "'$username' is approved."
        continue
    fi
    #echo "$username"

# Run using the /etc/passwd file
done < /etc/passwd