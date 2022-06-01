#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N indelreal__q30BASE__
#PBS -o 98_log_files/IndelRealign/__BASE__q30indelreal.out
#PBS -e 98_log_files/IndelRealign/__BASE__q30indelreal.err
#PBS -l nodes=1:ppn=28 # number of nodes, til 28
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

#ressources
module load tools
module load ngs
module load samtools/1.12
module load parallel/20160822
module load java/1.8.0
module load bamutil/1.0.14
module load gatk/3.8-0
module load jre/1.8.0-openjdk
module load picard-tools/2.25.2

# Global variables
DATAOUTPUT="06_realigned"
DATAINPUT="05_dedup"
GENOME="/home/projects/dp_00007/people/hmon/Shucking/01_infofiles/fileOegenome10scaffoldC3G.fasta"

#move to present working dir
cd $PBS_O_WORKDIR

base=__BASE__

#scripts
#fasta seq dictionary file ref picard
#java -jar /services/tools/picard-tools/2.9.1/picard.jar CreateSequenceDictionary R= $GENOME

#-fai ref
#samtools faidx $GENOME

# Index bam files
samtools index "$DATAINPUT"/"$base".nocig.dedup_clipoverlap.minq30.bam 

## Create list of potential in-dels nocig
java -jar /services/tools/gatk/3.8-0/GenomeAnalysisTK.jar \
-T RealignerTargetCreator \
-R $GENOME \
-I "$DATAINPUT"/"$base".nocig.dedup_clipoverlap.minq30.bam  \
-o "$DATAOUTPUT"/"$base".all_samples_for_indel_realigner.nocig.minq30.intervals 

## Run the indel realigner tool nocig
java -jar /services/tools/gatk/3.8-0/GenomeAnalysisTK.jar \
-T IndelRealigner \
-R $GENOME \
-I "$DATAINPUT"/"$base".nocig.dedup_clipoverlap.minq30.bam \
-targetIntervals "$DATAOUTPUT"/"$base".all_samples_for_indel_realigner.nocig.minq30.intervals \
--consensusDeterminationModel USE_READS  --nWayOut realigned.bam

##
mv *realigned.bam 06_realigned/
mv *realigned.bai 06_realigned/