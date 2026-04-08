#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "evaluate_users.sh run fail"
    exit 1
fi

# Allowed user list (borrowed from IRSeC 2025)
user_list=(
  "student"
)

# reads each line in the /etc/passwd file, takes the first 2 items and labels them as variables username and pass
while IFS=':' read -r username pass uid gid gecos homedir loginshell; do
    echo "~~~~~"
    username=$(echo "$username" | tr -d '[:space:]')

    # Skip system accounts (UID < 1000) with no login shell
    if [ -z "$uid" ] || [ "$uid" -lt 1000 ]; then
        echo "UID:$uid indicates '$username' is a system account."
        echo "User login shell: $loginshell"
        if [ "$loginshell" == "/usr/sbin/nologin" ]; then
            echo "User has no login shell."
            echo "Skipping system account $username."
            continue
        fi

        # check whether to remove supposed system account (because you are still able set the uid of a new user to a value reserved for system accounts)
        # plan to add list of known/expected system accounts with confirmation of nologin and no directory attached so less likely of an issue for redteam to impersonate a system account
        while true; do
            
            read -p "Remove this account? y/n: " sysaccrem </dev/tty
            echo "$sysaccrem"
            case $sysaccrem in
                [Yy]* )
                    echo "Removing $username..."
                    # deluser --remove-home $username
                    break;
                    ;;
                [Nn]* )
                    echo "Skipping system account $username."
                    break;
                    ;;
                * )
                    echo "Invalid response. Please try again"
                    ;;
            esac
        done
        continue
    fi

    #if the username matches something in the approved user list, say it was approved and move on
    if printf "%s\n" "${user_list[@]}" | grep -qxF "$username"; then
        echo "'$username' is approved."
        continue
    fi

# Run using the /etc/passwd file
done < /etc/passwd