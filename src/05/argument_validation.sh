#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "One argument required" && exit 1
fi

option=$1

if [[ ! "$option" =~ ^[1-4]$ ]]; then
    echo "Required argument from 1 to 4" && exit 1
fi
