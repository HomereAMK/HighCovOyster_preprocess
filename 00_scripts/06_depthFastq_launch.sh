#!/bin/bash

# Clean up
rm 00_scripts/DEPTHFASTQ*sh

# launch scripts for Colosse
for file in $(ls /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/02_data/*.fq.gz|sed -e 's/_[12].fq.gz//'|sort -u)    #or #for file in $(ls 02_data/*fastq.gz|perl -pe 's/.f(ast)?q.gz//'|sort -u)

do
	base=$(basename "$file")
	toEval="cat 00_scripts/06_depthFastq.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/DEPTHFASTQ_"$base".sh
done


#change jobs header

#Submit jobs
for i in $(ls 00_scripts/DEPTHFASTQ*sh); do qsub $i; done

#create the receiving txt file
rm 07_depth/Summary_depth*
touch 07_depth/Summary_depth_19aug22.txt