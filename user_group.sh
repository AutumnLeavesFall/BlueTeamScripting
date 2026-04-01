#!/bin/bash
### NEEDS TESTING ###
### NEEDS ERROR HANDLING ###

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "user_group.sh run fail"
    exit 1
fi

## PLAN
# ask whether to check user list
echo "Would you like to check existing users first? y/n"
read usercheck
if usercheck == "y"; then 
    # if yes, run evaluate_users.sh
    ./evaluate_users.sh
fi
# do user groups already exist
echo "\nListing existing user groups..."
tail /etc/group
# remove unrecognized group(s)
while true do
    echo "Do you need to remove a group? y/n"
    read rmgroupq
    if rmgroupq == "n"; then
        break
    fi
    echo "What group would you like to remove?"
    read rmgroupname
    groupdel groupname
done
    # no: create user groups for preferred, restricted, and blocked users
    # yes: list all current users in each group
# go through each user and ask which group to add to
