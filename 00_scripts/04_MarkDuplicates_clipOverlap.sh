#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N markdupnClip__BASE__
#PBS -e 98_log_files/DuplicateClip/__BASE__markdnClip.err
#PBS -o 98_log_files/DuplicateClip/__BASE__markdnClip.out
#PBS -l nodes=1:ppn=25 # number of nodes, til 28
#PBS -l walltime=20:00:00
#PBS -l mem=80g
#PBS -m n
#PBS -r n

# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is $PBS_O_WORKDIR
cd $PBS_O_WORKDIR

### Here follows the user commands:
# Define number of processors
NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS nodes
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)


#loading modules
module load tools
module load ngs
module load jre/1.8.0
module load picard-tools/2.25.2
module load parallel/20160822
module load java/1.8.0
module load bamutil/1.0.14

# Global variables
DATAOUTPUT="05_dedup"
DATAINPUT="04_mapped"
base=__BASE__

#scripts MarkDuplicates
#java -jar /services/tools/picard-tools/2.25.2/picard.jar MarkDuplicatesWithMateCigar \
#I="$DATAINPUT"/"$base".sort.minq20.bam \
#O="$DATAOUTPUT"/"$base".cig.dedup.minq20.bam \
#M="$DATAOUTPUT"/"$base".duprmmetrics.txt \
#REMOVE_DUPLICATES=true VALIDATION_STRINGENCY=SILENT

#scripts ClipOverlap
#/services/tools/bamutil/1.0.14/bam clipOverlap \
#--in "$DATAOUTPUT"/"$base".cig.dedup.minq20.bam \
#--out "$DATAOUTPUT"/"$base".cig.dedup_clipoverlap.minq20.bam \
#--stats


#tryout with NO CIGAR on MarkDuplicates
java -jar /services/tools/picard-tools/2.25.2/picard.jar MarkDuplicates \
I="$DATAINPUT"/"$base".sort.minq30.bam \
O="$DATAOUTPUT"/"$base".nocig.dedup.minq30.bam \
M="$DATAOUTPUT"/"$base".duprmmetrics.txt \
REMOVE_DUPLICATES=true VALIDATION_STRINGENCY=SILENT

#scripts ClipOverlap with NO CIGAR on MarkDuplicates
/services/tools/bamutil/1.0.14/bam clipOverlap \
--in "$DATAOUTPUT"/"$base".nocig.dedup.minq30.bam \
--out "$DATAOUTPUT"/"$base".nocig.dedup_clipoverlap.minq30.bam \
--stats

#KEPT the nocig 