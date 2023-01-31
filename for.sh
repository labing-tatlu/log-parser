#!/bin/bash

file='neutron-openvswitch-agent.log-20180129-1517214601'

ERROR=(`awk '($4 ~ /ERROR/)' $file | awk '{print $4}' | uniq -c`)
INFO=(`awk '($4 ~ /INFO/)' $file | awk '{print $4}' | uniq -c`)
WARNING=(`awk '($4 ~ /WARNING/)' $file | awk '{print $4}' | uniq -c`)

echo -e "Count sum of ERROR messages: $ERROR" > log_info.txt
echo -e "Count sum of INFO messages: $INFO" >> log_info.txt
echo -e "Count sum of WARNING messages: $WARNING\n\n" >> log_info.txt

cat $file | awk '{x = int(substr($2,1,2)/6) * 6; printf "%s %02d:00-%02d:59 %s\n", $1, x, x+5, $4}' | sort | uniq -c  >> log_info.txt