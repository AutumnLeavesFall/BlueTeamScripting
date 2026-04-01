#!/bin/bash
### NEEDS TESTING ###

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "user_perms.sh run fail"
    exit 1
fi

## PLAN
# run user_group.sh
./user_group.sh
# ask for directory path
echo "Please enter a directory to change perms within: "
read dirpath
# run recursive (-R) chown to make preferred user group the owner of all files in directory
chown -R :preferreduser dirpath
# run recursive chmod so only preferred user has r/w/e perms for all files in directory
chmod -R 070 dirpath #need to confirm this actually allows preferred user to access and run files but no one else

# need to figure out if I want more here



## GOAL
# make 1 user the only user with r/w/e perms
# gut all other users so cannot execute or access anything


## IDEAS
# ? user by user vs setting a preferred user?

# ask for preferred user (PREF)

# probably this one
# for each user in etc/passwd
    # ask for perm level (blocked - none, restricted - r/w, preferred - r/w/e)
    # add to associated group
# how much of this here vs in user_group.sh

