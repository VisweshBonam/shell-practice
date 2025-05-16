#!/bin/bash

echo "variables passed to script: $@"

echo "No of variables passed to script : $#"

echo "Present working directory of the script executer : $PWD"

echo "Present home directory of user , who is running the script : $HOME"

echo "Which user is running the script : $USER"

echo "PID of the script : $$"

sleep 10 &

echo "PID of the last command in background : $!"
