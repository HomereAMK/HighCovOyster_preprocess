
#!/bin/bash

# Clean session

rm 00_scripts/MARKDUP*sh

# launch scripts for Colosse

for file in $(ls 04_mapped/*sort*.bam|sed -e 's/.sort.minq30.bam//g'|sort -u)
do

base=$(basename "$file")

	toEval="cat 00_scripts/04_MarkDuplicates_clipOverlap.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/MARKDUP_$base.sh
done


#Submit jobs
for i in $(ls 00_scripts/MARKDUP*sh); do qsub $i; done
