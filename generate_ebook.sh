#!/bin/bash
ebook-convert "Human_Who_Codes.recipe" .mobi \
        --authors="Nicholas C. Zakas" \
        --title="Human Who Codes" \
        --pubdate="2021-11-09" \
        --output-profile=kindle_pw3 \
        --mobi-file-type=new \
        -vv
