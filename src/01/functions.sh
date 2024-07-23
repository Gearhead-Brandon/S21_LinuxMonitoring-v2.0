#!/bin/bash

#functions

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

create_name(){
    local letters=$1
    local -n map=$2
    local result=""
    local sym=""
    local num=""

    for (( i=0; i<${#letters}; i++)); do
        sym=${letters:i:1}
        num=${map[$sym]}

        for (( j=0; j<$num; j++)); do
            result+=$sym
        done

    done

    echo $result
}

generate_base_word() {
  sequence=$1
  length=$2
  sequence_length=${#sequence}
  result=''

  for ((i=0; i<sequence_length; i++)); do
    char="${sequence:i:1}"
    count=$((RANDOM % length + 1))
    for ((j=0; j<count; j++)); do
      result+="$char"
    done
  done
  
  echo $result
}

create_map() {

    local -n map=$1
    local word=$2
    local size=$3

    for (( i=0; i<$size; i++ )); do
        sym=${word:i:1}
        map[$sym]=1
    done

    if [ $size -eq 2 ]; then
        for (( i=0; i<2; i++ )); do
            sym=${word:i:1}
            map[$sym]=2
        done
    fi

    if [ $size -lt 4 ] && [ $size -ne 2 ]; then 
        diff=$((4-size))
        sym=${word:$((size-1)):1}
        ((map[$sym]+=$diff))
    fi
}