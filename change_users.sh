#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "users.sh run fail"
    exit 1
fi

# Allowed user list (borrowed from IRSeC 2025)
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



# Run using the /etc/passwd file
done < /etc/passwd