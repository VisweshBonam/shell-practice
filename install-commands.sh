#!/bin/bash

UserId=$(id -u)

if [ $UserId -ne 0 ]; then
    echo "please provide root acces"
    exit 1
else
    echo "You are a root"

    dnf list installed mysql

    if [ $? -ne 0 ]; then
        echo "MySQL not found, attempting to install..."
        dnf install mysql -y

        if [ $? -eq 0 ]; then
            echo "Installed Succesfully"

        else
            echo "Failure while installing"
            exit 1
        fi

    else
        echo "Succesfully installed no need to "
        exit 1
    fi
fi
