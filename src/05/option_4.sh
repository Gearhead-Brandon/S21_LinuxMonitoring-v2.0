#!/bin/bash

if [ $option -eq 4 ]; then

    > 05_4.log

    for item in ${data[@]} ; do
    
        code=$( awk '{print $9}' <<< $item )

        if [[ "$code" =~ ^[45] ]]; then
            ip=$(echo "$item" | awk '{print $1}')
            ip_array+=($ip)
        fi

    done

    uniqueip=$(echo ${ip_array[@]} | uniq -u)

    echo "${uniqueip[@]}" |  tr ' ' '\n' > 05_4.log 

fi