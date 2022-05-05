#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007
#PBS -A dp_00007
#PBS -N trimmomatic
#PBS -o 98_log_files/Trim/__BASE__trim.out
#PBS -e 98_log_files/Trim/__BASE__trim.err
#PBS -l walltime=00:10:00:00
#PBS -l nodes=1:ppn=30
#PBS -l mem=100g
#PBS -r n


# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is $PBS_O_WORKDIR
cd $PBS_O_WORKDIR

### Here follows the user commands:
# Define number of processors
NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS nodes

# Load all required modules for the job
module load tools
module load ngs
module load jre/1.8.0-openjdk
module load trimmomatic/0.38

# Global variables
base=__BASE__
ADAPTERS=/home/projects/dp_00007/people/hmon/Shucking/01_infofiles/NexteraPE_NT.fa

java -jar /services/tools/trimmomatic/0.38/trimmomatic-0.38.jar PE \
        -threads 8 \
        -phred33 \
        /home/projects/dp_00007/people/hmon/HighCovOysters/"$base"_1.fq.gz \
        /home/projects/dp_00007/people/hmon/HighCovOysters/"$base"_2.fq.gz \
        03_trimmed/"$base"_1.paired.fq.gz \
        03_trimmed/"$base"_1.single.fq.gz \
        03_trimmed/"$base"_2.paired.fq.gz \
        03_trimmed/"$base"_2.single.fq.gz \
        ILLUMINACLIP:$ADAPTERS:2:30:10:1:true LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:40
        
        
