#!/bin/bash

size=$(df -k / | awk 'NR==2 {print $4}')

if [[ $size -lt 1048576 ]]; then
    echo "Less than a gigabyte of free space left"
    if [ -f 02.log ]; then
		dateend=$(date +%s.%N)
		datetotal=$( echo "$dateend-$datestart" | bc)
		echo "Completion-$(date +"%D-%T"). The script's running time is $datetotal seconds." >> 02.log
	fi
	exit 1
fi