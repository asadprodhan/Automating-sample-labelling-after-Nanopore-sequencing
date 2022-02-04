#!/bin/bash

#metadata
metadata=barcodeNames.csv
#
Red="$(tput setaf 1)"
Green="$(tput setaf 2)"
Bold=$(tput bold)
reset=`tput sgr0` # turns off all atribute
while IFS=, read -r field1 field2  

do  
    echo "${Red}${Bold}Processing ${reset}: "${field1}"" 
    echo ""
    echo Renaming ${field1} directory as ${field2} 
    mv ${field1} ${field2} 
    echo Concatenating ${field2} reads
    cd "${field2}" &&
    cat *fastq.gz > ${field2}.fastq
    echo Moving ${field2}.fastq into home directory
    mv ${field2}.fastq ../
    cd "../"
    echo "${Green}${Bold}Completed ${reset}: ${field1}"
    echo ""
done < ${metadata}

