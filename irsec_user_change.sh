#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "users.sh run fail"
    exit 1
fi

user_list=(
  "fathertime" "chronos" "aion" "kairos" "merlin" "terminator" "mrpeabody"
  "jamescole" "docbrown" "professorparadox" "drwho" "martymcFly" "arthurdent"
  "sambeckett" "loki" "riphunter" "theflash" "tonystark" "drstrange"
  "bartallen" "whiteteam"
)

while IFS=':' read -r username pass _; do
    echo "~~~~~"
    username=$(echo "$username" | tr -d '[:space:]')

    # Skip system accounts (UID < 1000)
    uid=$(id -u "$username" 2>/dev/null)
    if [ -z "$uid" ] || [ "$uid" -lt 1000 ]; then
        continue
    fi

    if printf "%s\n" "${user_list[@]}" | grep -qxF "$username"; then
        echo "'$username' is approved."

        # Skip whiteteam
        if [ "$username" = "whiteteam" ]; then
            echo "Skipping white team"
            continue
        fi

        read -s -p "Enter new password for '$username': " new_pass
        echo

        if [ -z "$new_pass" ]; then
            echo "Skipping password change."
            continue
        fi

        echo "${username}:${new_pass}" | chpasswd
        if [ $? -eq 0 ]; then
            echo "Password updated for ${username}."
        else
            echo "Password update FAILED for ${username}."
        fi
    else
        read -p "Delete user '$username'? [y/n]: " confirm
        if [ "$confirm" = "y" ]; then
            deluser --remove-home "$username"
            if [ $? -eq 0 ]; then
                echo "User '$username' removed."
            else
                echo "Error removing user '$username'."
            fi
        else
            echo "Did not delete '$username'"
        fi
    fi
done < /etc/passwd