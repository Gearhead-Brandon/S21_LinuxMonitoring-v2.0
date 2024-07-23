#!/bin/bash

if [ $option -eq 2 ]; then

    #declare -A ip_map
    
    > 05_2.log

    for item in "${data[@]}"; do
        ip=$(echo "$item" | awk '{print $1}')
        ip_array+=($ip)
    done

    uniqueip=$(echo ${ip_array[@]} | uniq -u)

    echo "${uniqueip[@]}" |  tr ' ' '\n' > 05_2.log 

    # for item in "${uniqueip[@]}"; do

    #     echo "$item" >> 05_2.log
        
    # done

    #echo ${ip_array[@]}

    # for item in ${data[@]} ; do

    #     ip=$( echo $item | awk '{print $1}')

    #     if [ -z "${ip_map[$ip]}" ] ; then
    #         ip_map[$ip]=0
    #         echo "$ip" >> 05_2.log
    #     fi

    # done

    #unset ip_map

fi