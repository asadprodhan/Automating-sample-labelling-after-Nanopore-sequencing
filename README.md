# **Nanopore Data Tools** <br />



## **Automating the labelling of the barcodes and the sequencing reads**



The sequencing reads from a multiplex library are grouped in different directories named after the corresponding barcode. The first step of the analysis workflow is to rename these directories as per the sample name or id. Then, concatenate all the reads into a single fastq file sample-wise. Again, the concatenated fastq files should be named after the sample names or ids. Any mislabelling would lead to misleading results.


Here, I have compiled a bash script that automates this whole process. It is not only time-efficient but also takes away the potential risk of mislabelling the sequencing reads.



### **The script**


```
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
    echo Completed ${field1} 
    echo "${Green}${Bold}Completed ${reset}: ${field1}"
    echo ""
done < ${metadata}

```



### **Metadata**



It is a csv file containing the list of the barcodes and the corresponding sample names



 ![alt text](https://github.com/asadprodhan/Nanopore-Data-Tools/blob/main/MetaData.PNG)
 
 
 
 
### **How to use the script?**



>Keep the script and the metadata file in the same directory that contains the barcode directories. 
>
>Then, run the script as follows:
>
>./barcodesRenamed.sh



### **Output**



The script renames the barcode directories, concatenated the reads sample-wise, and collect the concatenated fastq files into the home directory. These files are now ready for QC and the downstream analysis. 


The screenshot demonstrating the contents before and after executing the above script: 



 ![alt text]()
 
 
