#!/bin/bash

UserId="$(id -u)"

#Colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME="$(echo $0 | cut -d "." -f1)"
LOG_FILE="$LOG_FOLDER/backup.log"
SCRIPT_DIR=$PWD

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

echo "Scripted started executing at : $(date)"

mkdir -p $LOG_FOLDER

if [ $UserId -ne 0 ]; then
    echo -e "$R ERROR $N:: Please access with root user" | tee -a $LOG_FILE
    exit 1
else
    echo -e "$G You are running with root $N" | tee -a $LOG_FILE
fi

VALIDATE() {
    if [ $1 -eq 0 ]; then
        echo -e "$2 is .....$G Success $N"
    else
        echo -e "$2 is .....$R Failed $N"
        exit 1
    fi
}

VALIDATEARG() {
    echo -e "$R USAGE:: $N sh 18-backup.sh <source-dir> <destination-dir> <days(optional)>"
}

if [ $# -lt 2 ]; then
    VALIDATEARG
fi

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R Source Directory $SOURCE_DIR does not exist. Please check $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "$R Destination Directory $DEST_DIR does not exist. Please check $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z "$FILES" ]; then
    echo "Files to zip are: $FILES"
    TIME_STAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"
    echo -e $FILES | tr ' ' '\n' | zip -@ "$ZIP_FILE"

    if [ -f $ZIP_FILE ]; then
        echo -e "Successfully created Zip file"
        while IFS= read -r filepath; do
            echo "Deleting file: $filepath" | tee -a $LOG_FILE
            rm -rf $filepath
        done <<<$FILES
        echo -e "Log files older than $DAYS from source directory removed ... $G SUCCESS $N"
    else
        echo -e "Zip file creation ... $R FAILURE $N"
        exit 1
    fi
else
    echo -e "No log files found older than 14 days ... $Y SKIPPING $N"
fi
