#!/bin/bash

profile=~/.profile
line_number=$(grep -Fn "IRIS_DB=" $profile | grep -oh "[0-9]*" | cat)

declare -A IRIS_DB
declare -A IRIS_DB_DATA

IRIS_DB+=$(awk -v line_number=$line_number 'NR==line_number' $profile)
IRIS_DB_DATA=$( echo $IRIS_DB | grep -oh "=(.*)" | cat)
IRIS_DB_DATA=${IRIS_DB_DATA:1}

# if [ !$IRIS_DB ]
# then
#   # IRIS_DB = $(cat ~/bash.rc | gr)
#   # >> ~/bash.rc
# fi