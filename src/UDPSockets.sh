#!/bin/bash

result="["
declare -i n=0
declare -i resvSum=0
declare -i sendSum=0
while read line; do
    n+=1
    result+="{\"row\":${n},"

    col1=$(echo $line | awk '{print $1}')
    result+="\"State\":\"${col1}\","

    col2=$(echo $line | awk '{print $2}')
    result+="\"Recv-Queue\":${col2},"
    resvSum+=$col2

    col3=$(echo $line | awk '{print $3}')
    result+="\"Send-Queue\":${col3},"
    sendSum+=$col3

    col4=$(echo $line | awk '{print $4}')
    result+="\"Local Address:Port\":\"${col4}\","

    col5=$(echo $line | awk '{print $5}')
    result+="\"Peer Address:Port\":\"${col5}\"}, "
done < <(ss -u -a | awk 'NR>1')

result+="{\"ResvSum\":$resvSum,"
result+="\"SendSum\":$sendSum}"

echo "${result}]"
