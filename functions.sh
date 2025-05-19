#!/bin/bash

userId=$(id -u)

if [ $userId -ne 0 ]; then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "You are running with root access"
fi

dnf list installed mysql

if [ $? -eq 0 ]; then
    echo "MySQL is already installed...Nothing to do"
else
    dnf install mysql -y
    Validate $? "mysql"

fi

dnf list installed nginx

if [ $? -eq 0 ]; then
    echo "MySQL is already installed...Nothing to do"
else
    dnf install nginx -y
    Validate $? "nginx"
fi

Validate() {
    if [ $1 -eq 0 ]; then
        echo "Installing $2 is ... SUCCESS"
    else
        echo "Installing $2 is ... FAILURE"
        exit 1

    fi
}
