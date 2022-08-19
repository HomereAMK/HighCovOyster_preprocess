#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007
#PBS -A dp_00007
#PBS -N fastp
#PBS -o 98_log_files/Trim/__BASE__fastp.out
#PBS -e 98_log_files/Trim/__BASE__fastp.err
#PBS -l walltime=00:05:00:00
#PBS -l mem=20g
#PBS -r n


## Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is $PBS_O_WORKDIR
cd $PBS_O_WORKDIR

### Here follows the user commands:
# Define number of processors
NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS nodes

# Load all required modules for the job
module load tools
module load ngs
module load fastp/0.20.1

# Global variables
base=__BASE__        

fastp -w 3 \
        -i /home/projects/dp_00007/people/hmon/HighCovOysters/"$base"_1.fq.gz \
        -I /home/projects/dp_00007/people/hmon/HighCovOysters/"$base"_2.fq.gz \
        -o 03_trimmed/"$base"_1.fastped.fq.gz \
        -O 03_trimmed/"$base"_2.fastped.fq.gz \
        -j QC/fastp/"$base".json \
        -h QC/fastp/"$base".html