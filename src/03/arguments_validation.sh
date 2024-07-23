#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Requires 1 argument from 1 to 3" && exit 1
fi

option=$1

if [[ ! "$option" =~ ^[1-3]$ ]]; then
    echo "Requires an argument from 1 to 3" && exit 1
fi