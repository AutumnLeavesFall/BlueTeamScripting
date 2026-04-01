#!/bin/bash
### NEEDS TESTING ###
### NEEDS ERROR HANDLING ###

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "users.sh run fail"
    exit 1
fi

# display all proccesses running across all users
# format: user pid %cpu %mem vsz-(virtual memory size; memory process *can* access) RSS-(resident set size; memory in use) TTY-(terminal associated with process) STAT-(process state code) START-(time process started) TIME-(time cpu used) COMMAND-(command that started the process)
# important parts: user, pid, command

while true; do
    echo "Enter the PID of the process you'd like to kill or q to quit:"
    read pidkill
    if pidkill == "q"; then
        break
    fi
    kill -9 pidkill
    # error handling needed
done