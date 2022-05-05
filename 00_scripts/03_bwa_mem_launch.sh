#!/bin/bash

# Clean session

rm 00_scripts/BWA*sh

# launch scripts for Colosse

for file in $(ls 03_trimmed/*.paired.fq.gz|sed -e 's/_[12].paired.fq.gz//'|sort -u)

do

base=$(basename "$file")

        toEval="cat 00_scripts/03_bwa_mem.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/BWA_$base.sh
done


#Submit jobs
for i in $(ls 00_scripts/BWA*sh); do qsub $i; done
