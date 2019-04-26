
#!/bin/bash
# C.G Boer version 2.0
# March 2019

# Usage:
# $1 = PATH to folder with meta-analysis .txt.gz files
# $1 = snp.look-up.list.txt
# $2 = output.file.prefix

# Look-upLoop
for i in $(ls -d $1/*.txt.gz)
        do
        var=$(echo $i| sed 's/\.txt.gz/\t/g' | cut -f 2)
        zcat $i | grep -wFf $2 > $3.$var.txt
done
exit
