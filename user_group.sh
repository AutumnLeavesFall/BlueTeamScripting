#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "user_group.sh run fail"
    exit 1
fi

## PLAN
# ask whether to check user list
    # if yes, run evaluate_users.sh
# do user groups already exist
    # no: create user groups for preferred, restricted, and blocked users
    # yes: list all current users in each group
# go through each user and ask which group to add to
