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

if [ $UserId -ne 0 ]; then
    echo -e "$R ERROR $N :: Please provide root access"
    exit 1
else
    echo -e "$G You are a root user $N"
fi

VALIDATE() {
    if [ $1 -eq 0 ]; then
        echo -e "$2 is.........$G Sucess $N"
    else
        echo -e "$2 is .......$R Failure $N"
        exit 1
    fi
}

USAGE() {
    echo -e "USAGE :: sh backup.sh <source-dir> <dest-dir> <days>(optional)"
}

#check how many arguments are passing
if [ $# -lt 2 ]; then
    USAGE
fi

#check source directory if not exsist
if [ ! -d $SOURCE_DIR ]; then
    echo -e "Source directory $SOURCE_DIR doesn't exsist"
    exit 1
fi

#check destination directory if not exsist
if [ ! -d $DESTI_DIR ]; then
    echo -e "Destination directory $DESTI_DIR doesn't exsist"
    exit 1
fi

#Getting .log Files in the source directory
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

#check is there any files in the Source Directory
if [ ! -z "$FILES" ]; then

    #if the folder is not empty, zip the files
    echo -e "Files to zip are $FILES"

    #adding time stamp 
    TIME_STAMP="$(date +%F-%H-%M-%S)"

    #zip file format with time stamp
    ZIP_FILE="$DESTI_DIR/app-logs-$TIME_STAMP.zip"

    echo $FILES  | zip -@ "$ZIP_FILE" #zip all the files and save in destination directory

    if [ -f $ZIP_FILE  ]
    then
        echo -e "Succesfully created zip file"

        while IFS= read -r filepath
        do
            echo -e " Deleting the file path $filepath" | tee -a $LOG_FILE
            rm -rf $filepath
        done <<< $FILES

        echo -e "log files older than 14 days is deleted"
    else
        echo -e "Zip file creation failed "
        exit 1
    fi

else
    # If the source directory is empty
    echo -e "You dont have files in $SOURCE_DIR Source Directory"
    exit 1
fi




