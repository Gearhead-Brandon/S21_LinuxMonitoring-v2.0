#!/bin/bash

if [ $option -eq 3 ]; then

    > 05_3.log

    for item in ${data[@]} ; do
    
        code=$( awk '{print $9}' <<< $item )

        if [[ "$code" =~ ^[45] ]]; then
            echo $( awk '{print $6" "$7" "$8}' <<< $item ) >> 05_3.log
        fi

    done

fi