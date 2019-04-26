#!/bin/bash
# C.G Boer version 1.0
# April 2019

# Input:
# $1 input folder with GWAS fils .txt.gz
# $2 snp.look-up.list.txt [identifiers SNP, one per line]
# $3 output.prefix

SNP_list=$2
OUT_file=$3.lookup.results.txt
cat header.txt >  $OUT_file

# Grep Loop

for i in $(ls -d $1/*.txt.gz)
        do zcat $i |grep -wFf $SNP_list > $3.temp
        
        #optional sed/cut for only certain part of file name
        var=$(echo $i| sed 's/\.txt.gz/\t/g' | cut -f 3)
        var2=$(echo $var)
        
        awk -v var3=$var2 '{print $0"\t"var3}' $3.temp > $3.temp2
        cat $3.temp2 >> $OUT_file

done

# Clean-up
rm $3.temp
rm $3.temp2

exit
