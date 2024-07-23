#!/bin/bash

check_duplicate_letters(){

    local str="$1"
    local size="$2"

    for (( i=0 ; i<$size ; i++)); do

        first=${str:$i:1}

        for (( j=1+$i; j<$size ; j++)); do

        second=${str:$j:1}

            if [[ $first == $second ]]; then 
                return 1
            fi

        done
    done

    return 0
}

if [[ $option -eq 3 ]]; then

    echo -e "Enter file name mask like az_250124 (DayMonthYear)"
	read mask

    if [[ ! $mask =~ ^[a-zA-Z]+_[0-9]{6} ]]; then
        echo "You entered incorrect mask" && exit 1
    fi

    underscore_count=$(echo $mask | grep -o "_" | wc -l)

    if [ $underscore_count -eq 0 ] || [ $underscore_count -gt 1 ]; then
        echo "You entered incorrect mask" && exit 1
    fi

    date_mask=${mask##*\_}

    left_mask=${mask%\_*}
    size_left_mask=${#left_mask}

    check_duplicate_letters $left_mask $size_left_mask

    if [ $? -eq 1 ]; then
        echo "Contain duplicate letters in mask name" && exit 1
    fi

    mask_letter_order=$(echo $left_mask | awk 'BEGIN{FS=""}{for(i=1;i<=NF;i++) if(!a[$i]++) printf $i}')

    for delcontent in $(find / -regextype posix-extended -regex '.*[a-zA-Z]+_[0-9]{6}' -type d -not -path  '*sbin*' -not -path '*bin*' 2>>/dev/null ) ; do
        
        name=${delcontent##*/}
        date=${name##*\_}

        letter_order=$(echo ${name%\_*} | awk 'BEGIN{FS=""}{for(i=1;i<=NF;i++) if(!a[$i]++) printf $i}')

        if [ "$date" == "$date_mask" ] && [ "$letter_order" == "$mask_letter_order" ]; then
            #echo $delcontent
            echo "delete $delcontent" >> 03.log
            sudo rm -rf $delcontent
        fi
    done
fi