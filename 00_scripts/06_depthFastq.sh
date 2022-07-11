#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007
#PBS -A dp_00007
#PBS -N depthfastq
#PBS -o 98_log_files/Trim/__BASE__depthfastq.out
#PBS -e 98_log_files/Trim/__BASE__depthfastq.err
#PBS -l walltime=00:10:00:00
#PBS -l nodes=1:ppn=10
#PBS -l mem=60g
#PBS -r n


# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is $PBS_O_WORKDIR
cd $PBS_O_WORKDIR

### Here follows the user commands:
# Define number of processors
NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS nodes

# Module 
module load tools
module load ngs
module load samtools/1.14

# Global variables
base=__BASE__
rm 07_depth/"$base"*.tmp

#raw reads
a=`zcat 02_data/"$base"_1.fq.gz  | wc -l | awk '{print $1/4}'` #raw read forward
b=`zcat 02_data/"$base"_2.fq.gz | wc -l | awk '{print $1/4}'` #raw read reverse
echo $(( $a + $b )) > 07_depth/"$base".count_fastq_1.tmp
#raw bases
c=`zcat 02_data/"$base"_1.fq.gz | awk 'NR%4==2' | tr -d "\n" | wc -m` 
d=`zcat 02_data/"$base"_2.fq.gz | awk 'NR%4==2' | tr -d "\n" | wc -m`
echo $(( $c + $d )) > 07_depth/"$base".count_fastq_2.tmp
#trim bases
e=`zcat 03_trimmed/"$base"_1.paired.fq.gz | awk 'NR%4==2' | tr -d "\n" | wc -m` 
f=`zcat 03_trimmed/"$base"_2.paired.fq.gz | awk 'NR%4==2' | tr -d "\n" | wc -m` 
echo $(( $e + $f )) > 07_depth/"$base".count_fastq_3.tmp 
#mapped bases
samtools stats 04_mapped/"$base".sort.minq30.bam -@ 12 | grep ^SN | cut -f 2- | grep "^bases mapped (cigar)" | cut -f 2 > 07_depth/"$base".count_bam_1.tmp
#deduplicate mapped bases
samtools stats 05_dedup/"$base".nocig.dedup_clipoverlap.minq30.bam -@ 12 | grep ^SN | cut -f 2- | grep "^bases mapped (cigar)" | cut -f 2  > 07_depth/"$base".count_bam_2.tmp
#realigned around indels mapped bases
samtools stats 06_realigned/"$base".nocig.dedup_clipoverlap.minq30realigned.bam -@ 12 | grep ^SN | cut -f 2- | grep "^bases mapped (cigar)" | cut -f 2  > 07_depth/"$base".count_bam_3.tmp
#population tag
echo 02_data/"$base"_1.fq.gz |awk '{split($0,a,"_"); print a[2]}' | awk '{split($0,a,"/"); print a[2]}' > 07_depth/"$base".count_pop_1.tmp

RAWREADS=`cat 07_depth/"$base".count_fastq_1.tmp`
RAWBASES=`cat 07_depth/"$base".count_fastq_2.tmp`
ADPTERCLIPBASES=`cat 07_depth/"$base".count_fastq_3.tmp`
MAPPEDBASES=`cat 07_depth/"$base".count_bam_1.tmp`
DEDUPMAPPEDBASES=`cat 07_depth/"$base".count_bam_2.tmp`
REALIGNEDMAPPEDBASES=`cat 07_depth/"$base".count_bam_3.tmp`
POP=`07_depth/"$base".count_pop_1.tmp`

printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" $base $POP $((RAWREADS/4)) $RAWBASES $ADPTERCLIPBASES $MAPPEDBASES $DEDUPMAPPEDBASES $REALIGNEDMAPPEDBASES >> 07_depth/Summary_depth_29jun22.txt


