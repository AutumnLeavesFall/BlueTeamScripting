#!/bin/bash
### REWRITTEN AS eval_users.sh due to excess code repetition. Needed restructuring

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "evaluate_users.sh run fail"
    exit 1
fi

# Allowed user list
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
        while true; do
            
            read -p "Brick this account? y/n: " sysaccrem </dev/tty
            case $sysaccrem in                    
               [Yy]* )
                   echo "Bricking $username..."
                   usermod -L -s /sbin/nologin $username
                   if [ $? -eq 0 ]; then
                       pass
                   else
                       echo "Error locking user '$username'."
                   fi
                   chage -E 0 $username
                   if [ $? -eq 0 ]; then
                       echo "User '$username' expiration date bricked."
                   else
                       echo "Error expiring user '$username'."
                   fi
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
        echo "Please change password for $username."
        read -s -p "Enter new password for '$username': " new_pass </dev/tty
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
        echo "Unknown user '$username'."
        while true; do
            
            read -p "Remove this account? y/n: " accrem </dev/tty
            echo "$accrem"
            case $accrem in
                [Yy]* )
                    echo "Removing $username..."
                    deluser --remove-home $username
                    if [ $? -eq 0 ]; then
                        echo "User '$username' removed."
                    else
                        echo "Error removing user '$username'."
                    fi
                    break
                    ;;
                [Nn]* )
                    echo "Please change password for $username."
                    read -s -p "Enter new password for '$username': " new_pass </dev/tty
                    echo

                    if [ -z "$new_pass" ]; then
                        echo "Skipping password change."
                        break
                    fi

                    echo "${username}:${new_pass}" | chpasswd
                    if [ $? -eq 0 ]; then
                        echo "Password updated for ${username}."
                    else
                        echo "Password update FAILED for ${username}."
                    fi
                    break
                    ;;
                * )
                    echo "Invalid response. Please try again"
                    ;;
            esac
        done
    fi

# Run using the /etc/passwd file
done < /etc/passwd