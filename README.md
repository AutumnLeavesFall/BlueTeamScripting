# BlueTeamScripting
## Script(s) In Progress & Tested
- eval_users.sh
    - Iterates through all users
    - Notifies if it's a system user based on UID
    - Asks whether to approve user
        - If approved, requests new user password
        - If not, asks whether to brick (remove login and set user expiration date to the past, because removing certain system users can create vulnerabilities) or remove the user
    - Post-UB Lockdown Goal: Modify so there's a list of known system users and what action to take with each one, because iterating through the system users was very time consuming
- list_processes.sh
    - Currently lists all running processes, asks for a PID, and attempts to kill that process
    - Post-UB Lockdown Thoughts: it was easier to just run these commands manually. Need to modify so it has the ability to search for specific keywords and highlight high-cpu usage
- inventory.sh
    - Gather OS, admin users, users, IP and MAC address, and ports list as typically requested by the first task inject in competitions
    - Add the services running on the ports!
- reinstall.sh
    - Remove and reinstall standard packages that red team may have tampered with (apt, git, curl, will add more as I think of them)




## Partial Completion, Need Testing
- user_group.sh
    - Asks whether to run eval_users.sh
    - Iterates through existing user groups and asks whether to remove them
    - Goal: create user groups based on whether to allow/brick
    - Use this to set recognized system users for goal with eval_users.sh
- user_perms.sh
    - Recursively restrict user perms through directories
    - Goal: use user_group.sh to simplify user labeling


## Implementation Problems
- ssh_keys.sh
    - Iterate through each key in ~/.ssh/authorized_keys (and known_hosts?) and ask whether to remove them
    - Note: At both competitions I have competed in as of writing this, clearing the ssh keys has kept me from seeing a significant amount of Red Team's malware
    - Apparently the authorized_keys file has protections specifically to prevent it from being modified by a bash script, so I'm trying to figure out a workaround. Good to know, but I'd still like to be able to automate the process of clearing the file


## Planned Scripts
- Backup important files
- Set up firewall rules (varies per comp and the organizer's rules but always important) - things like blocking IPs, blocking ports, and removing remote connections - specifically block basically everything but scored services
    - Need to learn how firewall is managed in bash
- Remove autoruns
    - Need to learn where to access autoruns and what's necessary to remove based on how it's handled
- Set up some kind of logging for information
