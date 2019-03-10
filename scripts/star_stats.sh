#!/bin/bash

echo -en "sample_names\t" > names.txt
echo -en "total_in_feaure\t" > totals.txt
cat 02-STAR_alignment/*/*ReadsPerGene.out.tab | head -4 | cut -f1 > stats.txt
cat samples.txt | while read sample; do
    echo ${sample}
    echo -en "${sample}\t" >> names.txt
    head -4 02-STAR_alignment/${sample}/${sample}_ReadsPerGene.out.tab | cut -f4 > temp1
    paste stats.txt temp1 > temp2
    mv temp2 stats.txt
    tail -n +5 02-STAR_alignment/${sample}/${sample}_ReadsPerGene.out.tab | cut -f4 | \
        perl -ne '$tot+=$_ }{ print "$tot\t"' >> totals.txt
done
cat names.txt stats.txt totals.txt > temp1
mv temp1 summary_alignments.txt
rm names.txt
rm totals.txt
