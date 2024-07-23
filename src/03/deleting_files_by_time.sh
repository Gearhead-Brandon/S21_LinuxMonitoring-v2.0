#!/bin/bash

if [[ $option -eq 2 ]]; then

    echo -e "To delete files enter the time in format YYYY-MM-DD HH:MI:SS :"
	read first_time

    if [[ -z "$first_time" ]]; then
        echo "Error. Empty value" && exit 1
    fi

    echo -e "Enter the date and time in format YYYY-MM-DD HH:MI:SS : "
	read second_time;

    if [[ -z "$second_time" ]]; then
        echo "Error. Empty value" && exit 1
    fi

    for delcontent in $(sudo find / -type d -regex '.*_.*[1-9]+$' -not -path  '*sbin*' -not -path '*bin*' -not -path '*proc*' -newerct "$first_time" ! -newerct "$second_time" 2>/dev/null) ; do
            #echo $delcontent
            echo "delete $delcontent" >> 03.log
            sudo rm -rf $delcontent
    done

fi