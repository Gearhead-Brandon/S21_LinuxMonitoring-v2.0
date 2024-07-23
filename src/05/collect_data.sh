#!/bin/bash

IFS=$'\n'
#echo -e "Enter the address where the files are located."
#read url
url="../04"
data=$(cat "$url"/access_1.log <(echo) "$url"/access_2.log  <(echo) "$url"/access_3.log <(echo) \
          "$url"/access_4.log <(echo) "$url"/access_5.log)

count=0

if [ ! -e "$url"/access_1.log ]; then
    echo "Files not found!" && exit 1
fi