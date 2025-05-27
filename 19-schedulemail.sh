#!/bin/bash


DISK_USAGE="$(df -hT | grep -v FileSystem)"
MAX_USAGE=1
MSG=""

while IFS= read -r line
do
    CONSUMED_PERCENTAGE="$(($DISK_USAGE | awk '{print $6F}' | cut -d "%" -f1 ))"
    CONSUMED_DIR="$(($DISK_USAGE | awk '{print $7F}'))"

    if [ $MAX_USAGE -gt $CONSUMED_PERCENTAGE ]
    then
        $MSG += echo -e "$CONSUMED_DIR is consumed more than 80%"
    fi
done <<< $DISK_USAGE
echo $MSG