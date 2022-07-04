#!/bin/bash

# Clean session

rm 00_scripts/DEPTH*sh

# launch scripts for Colosse

for file in $(ls 06_realigned/*.bam |sed -e 's/.nocig.dedup_clipoverlap.minq30realigned.bam//g'|sort -u)  #only the nocig retry
do

base=$(basename "$file")

	toEval="cat 00_scripts/06_aDepth.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/DEPTH_$base.sh
done

for file in $(ls USAM_MORL/*.bam |sed -e 's/.nocig.dedup_clipoverlap.minq20_minq20.nocig.realigned.1.5X.bam//g'|sort -u)  #only the nocig retry
do

base=$(basename "$file")

	toEval="cat 00_scripts/06_aDepth.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/DEPTH_$base.sh
done

#Submit jobs
for i in $(ls 00_scripts/DEPTH*sh); do qsub $i; done

