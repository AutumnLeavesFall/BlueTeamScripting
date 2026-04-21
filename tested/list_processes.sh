#!/bin/bash
### works, definitely ways to improve though.

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "list_processes.sh run fail"
    exit 1
fi

# display all proccesses running across all users
ps aux
# format: user pid %cpu %mem vsz-(virtual memory size; memory process *can* access) RSS-(resident set size; memory in use) TTY-(terminal associated with process) STAT-(process state code) START-(time process started) TIME-(time cpu used) COMMAND-(command that started the process)
# important parts: user, pid, command

while true; do
    echo "Enter the PID of the process you'd like to kill or q to quit:"
    read pidkill
    if [ $pidkill == "q" ]; then
        break
    fi
    pname='' ps -p $pidkill -o comm=
    echo "$pname"
    kill $pidkill
    if [ $? -eq 0 ]; then
        echo "Process #$pid has been killed."
    else
        echo "Failed to kill process #$pid ($pname)."
    fi
done

# possibly use top instead of ps aux? 
# want to compare output of commands to see what's ideal based on use: ps aux (all users), pstree (tree format for parent-child), top/htop
# does pgrep work for finding if the keyword is part of the name, or only if that's the entire name?