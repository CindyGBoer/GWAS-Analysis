#!/bin/bash
# Extract Dosages from VCF files
# by C.G. Boer V1.2 04/2019

# S1 = name cohort [RS1/RS2/RS3/CHECK]
# S2 = .txt file with CHR:POS of SNPs
# $3 = output.prefix

while read p; do

        CHR_in=$(echo $p |cut -d ":" -f 1)
        VCF_in=~/$1/Imputed/HRC_release1.1/chr$CHR_in.dose.vcf.gz
        bcftools view -O v -r "$p" "$VCF_in" | grep -v "#" >> $3.temp

done < $2

zcat ~/$1/Imputed/HRC_release1.1/chr1.dose.vcf.gz | head -n 12 > $3.lookup.vcf
cat $3.temp >> $3.lookup.vcf
rm $3.temp

vcftools --vcf $3.lookup.vcf --extract-FORMAT-info DS --out $3
rm $3.lookup.vcf

exit

