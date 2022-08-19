#!/bin/bash

# Clean session

rm 00_scripts/DEPTH*sh

# launch scripts for Colosse

for file in $(ls 06_realigned/*minq20realigned.bam |sed -e 's/.nocig.dedup_clipoverlap.minq20realigned.bam//g'|sort -u)  #only the nocig retry
do

base=$(basename "$file")

	toEval="cat 00_scripts/07_Depthbam.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/DEPTH_$base.sh
done
#Submit jobs
for i in $(ls 00_scripts/DEPTH_*sh); do qsub $i; done
