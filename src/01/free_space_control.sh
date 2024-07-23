#!/bin/bash

size=$(df -k / | awk 'NR==2 {print $4}')

if [[ $size -le 1048576 ]]; then
    echo "Less than a gigabyte of free space left" && exit 1
fi