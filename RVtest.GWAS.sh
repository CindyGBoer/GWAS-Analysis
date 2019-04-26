###################################################
###             RVtest GWAS                    ####
###################################################
# creator: C. G. Boer
###################################################
# input to script
# $1 = Check RS1 RS3 RS3 [cohort name]
# $2 = ped prefix = output prefix
####################################################
# RV-test GWAS QTL loop for chr 1:22
for i in {1..22}
do
rvtest --inVcf ~/$1/Imputed/HRC_release1.1/chr$i.dose.vcf.gz --pheno $2.ped\
                                                                # manual input of covar names: 
                                                                --covar $2.covar --covar-name startage\
                                                                --single wald --dosage DS\
                                                                --out out.chr$i.$2 \
                                                                --numThread 5 --hide-covar
done

##################
# Merge Chr output files into 1 file
touch $2.RVtest.out.GWAS.txt

head -1 out.chr1.$2.SingleWald.assoc > $2.RVtest.out.GWAS.txt; tail -n +2 -q *$2.SingleWald.assoc >> $2.RVtest.out.GWAS.txt
rm *$2.SingleWald.assoc

################# log  output files into 1 file

touch LOG.$2.RVtest.out.GWAS.txt
cat out.chr1.$2.log  > LOG.$2.RVtest.out.GWAS.txt; cat *.$2.log  >> LOG.$2.RVtest.out.GWAS.txt
rm *.$2.log

################ gzip final file to save storage
gzip $2.RVtest.out.GWAS.txt

################
exit
