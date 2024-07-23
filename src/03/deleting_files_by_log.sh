#!/bin/bash

if [[ $option -eq 1 ]]; then

    echo -e "Enter the path where the files are located"
	read url

    if [ -f "$url"02.log ]; then
        echo "File found"
        files=($(cat "$url"02.log | awk '{print $2}' | tac))

        for delcontent in ${files[@]} ; do
        
                echo "$delcontent" >> 03.log
                sudo rm -rf $delcontent
        done

    else
        echo "File not found"
    fi

fi