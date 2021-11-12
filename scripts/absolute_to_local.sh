#!/bin/bash
#
# Convert all blog links in blog folder from absolute url to local url
#
cd humanwhocodes.com/blog

for html in $(find . -type f -name index.html)
do
    if [  $(echo "$html" | grep "index.html") ];then
        folder=$(echo "$html" | rev | cut -d "/" -f 2- | rev)
        cat $html |  grep -Po "https://humanwhocodes.com/blog/20.*?(index.html)" | rev | cut -d "/" -f 2- | rev | sort | uniq |  while read -r url ; do
            absolute=$(echo "$url"  | cut -d "/" -f 5- )
            before=$(echo "https://humanwhocodes.com/blog/$absolute" | sed 's/\//\\\//g')
            after=$(echo "http://127.0.0.1:8000/blog/$absolute" | sed 's/\//\\\//g')
            echo "sed -i 's/$before/$after/g'       $html" #| bash  > ~/sed_output.txt 2> ~/sed_errors.txt
            echo "sed -i 's/$before/$after/g'       $html" | bash  > ~/sed_output.txt 2> ~/sed_errors.txt
            echo ""
        done
        
    fi
done
