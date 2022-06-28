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

# Global variables
base=__BASE__
zcat 02_data/$base"_1.fq.gz" | wc -l  > 07_depth/$base".count_fastq_1.tmp" 
zcat 02_data/$base"_1.fq.gz" | awk 'NR%4==2' | tr -d "\n" | wc -m > 07_depth/$base".count_fastq_1.tmp" 
RAWREADS='cat 07_depth/$base".count_fastq_1.tmp'
RAWBASES='cat 07_depth/$base".count_fastq_2.tmp'
printf "%s\t%s\t%s\n" $base $((RAWREADS/4)) $RAWBASES > 07_depth/Fastq_depth_14jun22.txt

        