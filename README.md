# **Nanopore Data Tools** <br />



## **Automating sample labelling after sequencing**



The sequencing reads from a multiplex library are grouped into different directories named after the corresponding barcodes. The first step of analysing these reads is to label the barcode directories as per their sample names or ids. Then, concatenating the reads of a sample into a single fastq file. Again, these concatenated fastq files should be named after their sample names or ids. Any mislabelling of the reads would lead to misleading results.


Here, I have compiled a bash script that automates this whole process. It is not only time-efficient but also takes away the potential risk of mislabelling the sequencing reads.



### **The script**


```
#!/bin/bash

#metadata
metadata=barcodeNames.csv

# text formatting
Red="$(tput setaf 1)"
Green="$(tput setaf 2)"
Bold=$(tput bold)
reset=`tput sgr0` # turns off all atribute

while IFS=, read -r field1 field2 # reading the metadata file line-by-line, each column is a field

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

```



### **Metadata**



It is a csv file containing the list of the barcodes and the corresponding sample names



 ![alt text](https://github.com/asadprodhan/Nanopore-Data-Tools/blob/main/MetaData.PNG)
 
 
 
Note that if you make this csv file in Windows computer, you will need to convert it to unix format for using it in Linux computer. Because Windows uses \r\n as line-ending while Unix uses \n. To do so, install the dos2unix package as follows:


```
sudo apt install dos2unix
```


Then run


```
dos2unix metadata.csv
```


This will convert the Windows formatting to the Unix one. 


### **How to use the script?**



>Keep the script and the metadata file in the same directory that contains the barcode directories. 
>
>Then, run the script as follows:
>
>./barcodesRenamed.sh



### **Output**



The script renames the barcode directories, concatenates the reads sample-wise, and collects the concatenated fastq files into the home directory. These files are now ready to be used in QC and any downstream analysis. 


The screenshot demonstrating the contents before and after executing the above script: 



 ![alt text](https://github.com/asadprodhan/Nanopore-Data-Tools/blob/main/TerminalScreenShot.PNG)
 
 
