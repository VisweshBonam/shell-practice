#!/bin/bash


DISK_USAGE="$(df -hT | grep -v FileSystem)"
MAX_USAGE=1
MSG=""

while IFS= read -r line
do
    CONSUMED_PERCENTAGE="$(echo line | awk '{print $6F}' | cut -d "%" -f1 )"
    CONSUMED_DIR="$(echo line | awk '{print $7F}')"

    if [ $CONSUMED_PERCENTAGE -gt $MAX_USAGE ]
    then
        $MSG += $CONSUMED_DIR is consumed more than 80%
    fi
done <<< $DISK_USAGE
echo $MSG