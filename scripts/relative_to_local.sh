#!/bin/bash
#
# Convert all blog links in blog folder from relative path to absolute path
#
cd humanwhocodes.com/blog

for html in $(find . -type f -name index.html)
do
    if [  $(echo "$html" | grep "index.html") ];then
        folder=$(echo "$html" | cut -d "/" -f 2- | rev | cut -d "/" -f 2- | rev)
        cat $html |  grep -Po 'href="(\.\.\/)+[0-9]+\/.*index.html?' | rev | cut -d "/" -f 2- | rev | sort | uniq |  while read -r url ; do
            relative=$(echo "$url" | sed 's/href="//')
            cd "/home/ubuntu/Documents/github/Nicholas-C.-Zakas/humanwhocodes.com/blog/$folder"
            current=$(pwd)
            absolute=$(realpath --relative-to="/home/ubuntu/Documents/github/Nicholas-C.-Zakas/humanwhocodes.com/" "$relative")
            echo "  current path:   $current"
            echo "  absolute path:  $absolute"
            echo "  relative path:  $relative"
            before=$(echo "$relative" | sed 's/\//\\\//g')
            after=$(echo "http://127.0.0.1:8000/$absolute" | sed 's/\//\\\//g')
            echo "sed -i 's/$before/$after/g'       $html" #| bash  > ~/sed_output.txt 2> ~/sed_errors.txt
            echo "sed -i 's/$before/$after/g'       index.html" | bash  > ~/sed_output.txt 2> ~/sed_errors.txt
            echo ""
        done
        
    fi
    cd "/home/ubuntu/Documents/github/Nicholas-C.-Zakas/humanwhocodes.com/blog"
done
