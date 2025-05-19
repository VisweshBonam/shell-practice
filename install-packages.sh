#!/bin/bash

UserId=$(id -u)

if [ $UserId -ne 0 ]; then
    echo "Please Provide root user"
    exit 1
else
    echo "You are a root user"

    dnf list installed mysql
    if [ $? -eq 0 ]; then
        echo "you already installed mysql"
    else
        echo "you havent installed mysql, proceed to install"

        dnf install mysql -y
        if [ $? -eq 0 ]; then
            echo "mysql installed succesfully"
        else
            echo "installation failed"
        fi
    fi
fi
