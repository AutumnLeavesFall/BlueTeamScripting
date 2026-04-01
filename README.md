# BlueTeamScripting
## Script(s) In Progress
- change all passwords
- disable all users not in a list that you can specify (to keep the users that are required)

These are being combined into one script which: 
Goes through all users, and if it's an approved user, asks for a new password. If the user isn't approved, it asks whether to allow the user, then either removes it or changes it's password. This is in-progress as change_users.sh


- make a user group for the users you need for the comp
- restrict file/directory perms based on user groups

## Script(s) with Drafted Plans/Pseudocode


## Scripts to Make
- list running processes with given keywords (eg "malware")
- set up firewall rules (varies per comp and the organizer's rules but always important) - things like blocking IPs, blocking ports, and removing remote connections - specifically block basically everything but scored services
- remove autoruns
- backup important files
- lower priority - set up some kind of logging for information
