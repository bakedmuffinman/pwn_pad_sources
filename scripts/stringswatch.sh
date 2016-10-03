#!/bin/bash
#Description: Script to watch strings go by in real time
#set the prompt to the name of the script
PS1=${PS1//@\\h/@stringswatch}
clear

#this block controls the features for px_interface_selector
include_cell=1
. /opt/pwnix/pwnpad-scripts/px_functions.sh

f_savecap(){

  printf "\nSave log to /opt/pwnix/captures/stringswatch?\n\n"
  printf "1. Yes\n"
  printf "2. No\n\n"

  read -p "Choice [1-2]: " saveyesno

  trap f_hangup INT
  trap f_hangup KILL
  trap f_hangup SIGHUP

  case $saveyesno in
    1) f_yes ;;
    2) f_no ;;
    *) f_savecap ;;
  esac
}

f_yes(){
  filename=/opt/pwnix/captures/stringswatch/strings$(date +%F-%H%M).log
  tshark -i $interface -q -w - | strings -n 8 | tee $filename
}

f_no(){
  tshark -i $interface -q -w - | strings -n 8
}

f_hangup(){
  pkill -f 'tshark -i ${interface} -q -w -'
}

f_interface
f_savecap
