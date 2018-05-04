#!/bin/bash
# Grants user access to run "jamf policy -id 2" via sudo in a terminal

# If run from command line, use this:
DATE=$(date "+%b %Oe %H:%M:%S")
computerName=$(scutil --get ComputerName)
name=$(id -un)
LOG=/var/log/system.log
file=/etc/sudoers
check="# Added for grant admin cli"
granted_stuff="${check}\nCmnd_Alias JAMF = /usr/local/bin/jamf policy -id 2\n${name} ALL=(root) JAMF"

# Functions
timeStamp() {
 date "+%b %Oe %H:%M:%S"
}

grant() {
echo -e ${granted_stuff} >> ${file}
}

if [[ ! $(grep "${check}" ${file}) ]]
then
  echo "$(timeStamp) ${computerName} [INFO] Checking for cli grant admin privileges"
  echo "$(timeStamp) ${computerName} [INFO] Checking for cli grant admin privileges" >> ${LOG}
  grant
else
  echo "$(timeStamp) ${computerName} [INFO] cli grant admin access already exists. exiting"
  echo "$(timeStamp) ${computerName} [INFO] cli grant admin access already exists. exiting" >> ${LOG}
  exit 0
fi
