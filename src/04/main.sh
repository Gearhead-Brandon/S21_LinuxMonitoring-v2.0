#!/bin/bash

day=$(date +%d)
date_now=$(date +%b/%Y)

source storage.sh

rm -rf *.log

for (( i=1; i<=5; i++ )); do

   number_of_records=$((RANDOM%900+100))
   #number_of_records=1000
   . log.sh

   for (( j=0; j < number_of_records; j++)); do

        (( time += 60 ))
        date=$(date -d "@$time" '+%T')

        . create_ip.sh
        . get_method.sh
        . get_url.sh
        . get_code.sh
        . get_user_agent.sh

        echo "$ip1"."$ip2"."$ip3"."$ip4" "- - "["$day"/"$date_now":"$date" +0000] \
        '"'${methods[$method_index]} /$url_num/${url_links[$url_index]} HTTP/1.1'"' "${http_codes[$code]}"\
        "- "'"'"Mozilla/5.0 ${user_agent[$user_agent_id]}"'"'>> access_$i.log
   done

   (( day-- ))

done