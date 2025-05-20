#!/bin/bash

FOLDER_PATH="/var/log/sheelscript-practice"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
FILE_PATH="$FOLDER_PATH/$SCRIPT_NAME.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


mkdir -p $FOLDER_PATH

echo -e "$Y you are logged to mobaxtream at $N  $G $(date) $0" & >> $FILE_PATH 


echo -e "$Y have you install dnf package $N  $G succesfuuly at $(date) $0"  | tee -a $FILE_PATH