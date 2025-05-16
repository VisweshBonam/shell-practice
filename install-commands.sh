#!/bin/bash

UserId=$(id -u);

# checking whether user is root or not
if [ $UserId -ne 0 ]
# if user is ot root
then
echo "please provide root acces"
exit 1
# if user is root
else
echo "You are a root"

# check whether package is installed or not
dnf list installed mysql

#if package is not installed 
if [ $? -ne 0 ]
then
 echo "MySQL not found, attempting to install..."
 dnf install mysql -y

 #check whether installed successfully or not 
 #if installed succesfully
if [ $? -eq 0 ]
then
echo "Installed Succesfully"

#if installion failed
else
echo "Failure while installing" 
exit 1
fi

# if installation is succesfull
else
echo "Succesfully installed no need to "
exit 1
fi
fi