#!/bin/bash

#!/bin/bash

userId=$(id -u)

PACKAGES=("mysql" "nginx" "nodejs")

if [ $userId -ne 0 ]; then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "You are running with root access"
fi

for packages in ${PACKAGES[@]}

do 

dnf list installed $package

if [ $? -eq 0 ]; then
    echo "$package is already installed...Nothing to do"
else
    dnf install $package -y
    Validate $? "$package"

fi


Validate() {
    if [ $1 -eq 0 ]; then
        echo "Installing $2 is ... SUCCESS"
    else
        echo "Installing $2 is ... FAILURE"
        exit 1

    fi
}
