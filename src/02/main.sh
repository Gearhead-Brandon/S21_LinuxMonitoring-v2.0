#!/bin/bash

source functions.sh

. log.sh
. arguments_validation.sh
. free_space_control.sh
. create_maps.sh
. create_dirs_with_files.sh

dateend=$(date +%s.%N)
datetotal=$( echo "$dateend-$datestart" | bc)
echo "Completion-$(date +"%D-%T"). The script's running time is $datetotal seconds." >> 02.log
echo -e "\nStart-$datestartscript. Completion-$(date +"%D-%T"). The script's running time is $datetotal seconds." 