#!/bin/bash

permissible_size=$((249-$size_let_dirs))

size_file_system=$(df -k / | awk 'NR==2 {print $4}')
while [[  $size_file_system -gt 1048576 ]]; do
#for (( i=0 ; i<1 ; i++ )); do

    directory=$(get_random_directory)
    #directory="/home/gearhead/Projects/temp"

    if [[ -v used_directories[$directory] ]]; then
        echo here
        while [[ ${used_directories[$directory]+_} ]]; do
            directory=$(get_random_directory)
            echo dir = $directory
        done
    fi

    used_directories[$directory]=0

    echo $directory
######################################################
#####################################################
###################################################

size_word=0
for key in "${!dir_map[@]}"; do
  value="${dir_map[$key]}"
  ((size_word+=value))
done

size_word_f=0
for key in "${!file_map[@]}"; do
  value="${file_map[$key]}"
  ((size_word_f+=value))
done

base_word=$(create_name $letters_dirs dir_map)
base_word_f=$(create_name $filename file_map)

copy_let_dirs=$base_word
copy_let_files=$base_word_f

current_letter=0
current_letter_f=0

count_dirs=$((RANDOM % 100 + 1))
echo count_dirs= $count_dirs
#######################################################################################
for (( j=0; j<$count_dirs; j++)); do
    . free_space_control.sh

    result=$(create_name $letters_dirs dir_map)

    date_dir=$(date +%d%m%y)
    log_date_dir=$(date +%F)
    sudo mkdir "$directory"/"$result"_"$date_dir" 2>> error.log
    echo "$log_date_dir"" ""$directory"/"$result"_"$date_dir" >> 02.log
#######################################################################################
    count_files=$((RANDOM % 100 + 1))
    echo count_files = $count_files
    for (( l=0; l<$count_files; l++ )); do

        . free_space_control.sh

        result_f=$(create_name $filename file_map)
        date_file=$(date +%d%m%y)
        log_date_file=$(date +%F)

        sudo touch "$directory"/"$result"_"$date_dir"/"$result_f"_"$date_file"."$extension" 2>> error.log
		sudo fallocate -l "$filesize"M "$directory"/"$result"_"$date_dir"/"$result_f"_"$date_file"."$extension" 2>> error.log
		echo "$log_date_file""    ""$directory"/"$result"_"$date_dir"/"$result_f"_"$date_file"."$extension""	""$filesize"KB >> 02.log

        sym=${filename:current_letter_f:1}
        ((file_map[$sym]++))

        ((size_word_f++))

        if [ $size_word_f -eq $permissible_size ]; then
            ((current_letter_f++))
        fi

        if [ $current_letter_f -eq $len_filename ];then

            random_number=$((RANDOM % 30 + 1))
            base_word_f=$(generate_base_word $copy_let_files $random_number)
            size_base=${#base_word_f}

            if [ $size_base -lt 4 ]; then 
                for (( ; size_base<4; )); do
                    random_number=$((RANDOM % 30 + 1))
                    base_word_f=$(generate_base_word $copy_let_files $random_number)
                    size_base=${#base_word_f}
                done
            fi
            current_letter_f=0
            size_word_f=$permissible_size
        fi

        if [ $size_word_f -eq $permissible_size ]; then

            result_f=$base_word_f
            size_word_f=${#base_word_f}
            unset file_map && declare -A file_map

            for (( t=0; t<size_word_f; t++)); do
                sym=${base_word_f:t:1}
                if [ "${file_map[$sym]+value}" ]; then
                ((file_map[$sym]++))
                else
                    file_map[$sym]=1
                fi
            done

        fi

    done
################################################################################
    current_letter_f=0
    unset file_map
    declare -A file_map
    create_map file_map $filename $len_filename

    sym=${letters_dirs:current_letter:1}
    ((dir_map[$sym]++))

    ((size_word++))

    if [ $size_word -eq $permissible_size ]; then
        ((current_letter++))
    fi

    if [ $current_letter -eq $size_let_dirs ];then

        random_number=$((RANDOM % 30 + 1))
        base_word=$(generate_base_word $copy_let_dirs $random_number)
        size_base=${#base_word}

        if [ $size_base -lt 4 ]; then 
            for (( ; size_base<4; )); do
                random_number=$((RANDOM % 30 + 1))
                base_word=$(generate_base_word $copy_let_dirs $random_number)
                size_base=${#base_word}
            done
        fi

        current_letter=0
        size_word=$permissible_size
    fi

    if [ $size_word -eq $permissible_size ]; then

        result=$base_word
        size_word=${#base_word}
        unset dir_map && declare -A dir_map

        for (( t=0; t<size_word; t++)); do
            sym=${base_word:t:1}
            if [ "${dir_map[$sym]+value}" ]; then
               ((dir_map[$sym]++))
            else
                dir_map[$sym]=1
            fi
        done

    fi

done
######################################################
#####################################################
###################################################
    unset dir_map
    declare -A dir_map
    create_map dir_map $letters_dirs $size_let_dirs

    size_file_system=$(df -k / | awk 'NR==2 {print $4}')
done

# ls -l  /home/gearhead/Projects/temp grep '^d'  |wc -l
# ls -A  /home/gearhead/Projects/temp | wc -l