#!/bin/bash

if [ $option -eq 1 ]; then

    sorted_data=$(sort -k9n <<< "${data[@]}")

    > 05_1.log

    for item in ${sorted_data[@]} ; do
        echo "$item" >> 05_1.log
    done

fi