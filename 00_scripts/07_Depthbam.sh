#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N bam_depth
#PBS -e 98_log_files/Covstat/__BASE__depth.err
#PBS -o 98_log_files/Covstat/__BASE__depth.out
#PBS -l nodes=1:ppn=25:thinnode
#PBS -l walltime=100:00:00
#PBS -l mem=100g
#PBS -m n
#PBS -r n

# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is $PBS_O_WORKDIR
cd $PBS_O_WORKDIR

### Here follows the user commands:
# Define number of processors
NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS nodes

#module
module load tools
module load ngs
module load samtools/1.14

#move to present working dir
cd $PBS_O_WORKDIR

base=__BASE__

######################################################################################################################
samtools depth -aa 06_realigned/"$base".nocig.dedup_clipoverlap.minq20realigned.bam | cut -f 3 | gzip > 07_depth/"$base"_depth.gz