#!/bin/bash

permissible_size=$((249-$size_let_dirs))

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

for (( j=0; j<$count_dirs; j++)); do
    . free_space_control.sh

    result=$(create_name $letters_dirs dir_map)

    date_dir=$(date +%d%m%y)
    log_date_dir=$(date +%F)
    mkdir "$absolute_path"/"$result"_"$date_dir" 2>> error.log
    echo "$log_date_dir"" ""$absolute_path"/"$letters_dirs"_"$date_dir" >> 01.log
#######################################################################################
    for (( l=0; l<$count_files; l++ )); do

        . free_space_control.sh

        result_f=$(create_name $filename file_map)
        #echo $result_f
        date_file=$(date +%d%m%y)
        log_date_file=$(date +%F)

        touch "$absolute_path"/"$result"_"$date_dir"/"$result_f"_"$date_file"."$extension" 2>> error.log
		fallocate -l "$filesize"K "$absolute_path"/"$result"_"$date_dir"/"$result_f"_"$date_file"."$extension" 2>> error.log
		echo "$log_date_file""    ""$absolute_path"/"$result"_"$date_dir"/"$result_f"_"$date_file"."$extension""	""$filesize"KB >> 01.log

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

# ls -l  /home/gearhead/Projects/temp/azcc_110124/ | grep '^d'  |wc -l
# ls -A  /home/gearhead/Projects/temp/azcc_110124/ | wc -l