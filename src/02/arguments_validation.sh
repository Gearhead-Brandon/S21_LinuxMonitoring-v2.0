#!/bin/bash

############################################################
if [ $# -ne 3 ]; then
    echo "Error: The script must be run with 3 parameter." && exit 1
fi

############################################################ 111111

letters_dirs=$1
size_let_dirs=${#letters_dirs}

if [[ ! $letters_dirs =~ ^[A-Za-z]+$ ]]; then
    echo "Folder names argument must be contain only english letters" && exit 1
fi

if [ $size_let_dirs -gt 7 ]; then    
    echo "You have entered more than 7 letters for the folder names" && exit 1
fi

(check_duplicate_letters $letters_dirs $size_let_dirs)

if [ $? -eq 1 ]; then
    echo "Contain duplicate letters in function name"
    exit 1
fi

############################################################ 222222

letters_files=$2
size_let_files=${#letters_files}

if [[ ! letters_files =~ [A-Za-z.]+$ ]]; then
    echo "You must enter english letters and a dot for the expansion" && exit 1
fi

count_dot=0

for (( i=0; i < size_let_files; i++ )); do

    filename_letter=${letters_files:i:1}

    if [[ $filename_letter == '.' ]]; then 
        ((count_dot++));
    fi

    if [[ count_dot -ge 2 ]]; then  
        echo "More than one point entered in filename" && exit 1
    fi

done

if [[ $count_dot -eq 0 ]]; then
    echo "You did not entered an extension in filename" && exit 1
fi

filename=${letters_files%.*}
len_filename=${#filename}

if [ $len_filename -eq 0 ]; then
    echo "You have not entered filename" && exit 1
fi

if [ $len_filename -gt 7 ]; then
    echo "You entered more than 7 characters for the filename" && exit 1
fi

(check_duplicate_letters $filename $len_filename)

if [ $? -eq 1 ]; then
    echo "Contain duplicate letters in file name"
    exit 1
fi

extension=${letters_files##*.}
len_ext=${#extension}

if [ $len_ext -eq 0 ]; then
    echo "You have not entered extension" && exit 1
fi

if [ $len_ext -gt 3 ]; then
    echo "You have entered more than 3 letter for the extension" && exit 1
fi

############################################################ 333333
size_arg=$3
len_size=${#size}

kb=${size_arg:$((len_size - 2)):2}

if [[ "$kb" != "Mb" ]]; then
    echo "You must enter the size of the files in kilobytes" && exit 1
fi

filesize=${3%??}

if [[ ! "$filesize" =~ ^[0-9,]+$ ]]; then
    echo "You must enter number for file size" && exit 1
fi

if [[ "$filesize" -gt 100 ]]; then  
    echo "You must enter a file size of no more than 100 Mb" && exit 1
fi

copy_filename=$filename