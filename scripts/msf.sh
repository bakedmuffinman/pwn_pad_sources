#!/bin/bash
#Script to run msfconsole with no flags
#set the prompt to the name of the script
PS1=${PS1//@\\h/@msfconsole}
clear

printf "\n[!] Starting Metasploit.. This is gonna take a sec..\n"
f_hangup(){
  pkill -f /usr/bin/msfconsole
}

trap f_hangup INT
trap f_hangup KILL
trap f_hangup SIGHUP

msfconsole

