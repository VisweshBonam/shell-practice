#!/bin/bash

START_TIME="$(date +%s)"

UserId="$(id -u)"

#colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#Logs

LOG_FOLDER="/var/log/shellpractice-logs"
SCRIPT_NAME="$(echo $0 | cut -d "." -f1)"
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
SCRIPT_DIR="$PWD"

SOURCE_DIR="$1"
DESTI_DIR="$2"
DAYS="${3:-14}"



mkdir -p $LOG_FOLDER

if [ $UserId -ne 0 ]
then
    echo -e "$R ERROR $N :: Please provide root access"
    exit 1
else
    echo -e "$G You are a root user $N"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is.........$G Sucess $N"
    else
        echo -e "$2 is .......$R Failure $N"
        exit 1
    fi
}

USAGE(){
    echo -e "USAGE :: sh backup.sh <source-dir> <dest-dir> <days>(optional)"
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "Source directory $SOURCE_DIR doesn't exsist"
    exit 1
fi

if [ ! -d $DESTI_DIR ]
then
    echo -e "Destination directory $DESTI_DIR doesn't exsist"
    exit 1
fi

FILES=$(find $SCRIPT_DIR -name "*.log" -mtime $DAYS)

if [ ! -z $FILES ]
then
    echo -e "Files Found"

else
    echo -e "You dont have files in $SOURCE_DIR Source Directory"
    exit 1
fi


