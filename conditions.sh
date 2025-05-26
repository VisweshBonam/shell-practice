#!/bin/bash

Number=$1;

# -gt ----> greater than
# -lt ----> less than
# -eq ----> equal to
# -ne ----> not equal to


if [ $Number -gt 10 ]
then
echo "The given number $Number is greater than 10"
else
echo "The given number $Number is less than 10"
fi