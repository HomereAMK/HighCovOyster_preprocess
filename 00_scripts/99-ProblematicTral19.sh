#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N bwa__BASE__
#PBS -e 98_log_files/Map/bwa__BASE__.err
#PBS -o 98_log_files/Map/bwa__BASE__.out
#PBS -l nodes=1:ppn=24:thinnode
#PBS -l walltime=100:00:00
#PBS -l mem=120g
#PBS -m n
#PBS -r n


# Go to the directory from where the job was submitted (initial directory is $HOME)
echo Working directory is $PBS_O_WORKDIR
cd $PBS_O_WORKDIR

### Here follows the user commands:
# Define number of processors
NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS nodes

#TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
# Copy script as it was run
#SCRIPT=$0
#NAME=$(basename $0)
#LOG_FOLDER="98_log_files"
#cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

# Load all required modules for the job
module load gcc/8.2.0
module load tools
module load ngs
module load bwa/0.7.17
module load samtools/1.12


# Global variables
DATAOUTPUT="04_mapped"
DATAINPUT="03_trimmed"
GENOME="/home/projects/dp_00007/people/hmon/Shucking/01_infofiles/fileOegenome10scaffoldC3G.fasta"
NCPU=8
base=__BASE__



  # Align reads 1 step
bwa mem "$GENOME" "$DATAINPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1_1.paired.fq.gz "$DATAINPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1_2.paired.fq.gz >"$DATAOUTPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1.sam


samtools view -bS -h -q 30 -F 4 "$DATAOUTPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1.sam >"$DATAOUTPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1.bam


     echo "Creating sorted bam for $base"
        samtools sort "$DATAOUTPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1.bam -o "$DATAOUTPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1.sort.minq30.bam
        samtools index "$DATAOUTPUT"/TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1.sort.minq30.bam
   
   # Clean up
    echo "Removing "$DATAOUTPUT"/"$base".sam"
    echo "Removing "$DATAOUTPUT"/"$base".bam"

        rm "$DATAOUTPUT"/"$base".sam
        rm "$DATAOUTPUT"/"$base".bam

#map only on scaffold5
# because of a possible inversin at the begin of the chr for the scandinavian populations (see  )
#GENOME="01_infofiles/scaffold5.fa"
#bwa mem -t "$NCPU" \
 #       -R "$ID" \
  #      "$GENOME" \
   #     "$DATAINPUT"/"$base"_1.paired.fq.gz "$DATAINPUT"/"$base"_2.paired.fq.gz >"$DATAOUTPUT"/"$base".sam

#samtools view -bS -h -q 20 -F 4 \
 #   "$DATAOUTPUT"/"$base".sam >"$DATAOUTPUT"/"$base".bam

#samtools sort "$DATAOUTPUT"/"$base".bam -o "$DATAOUTPUT"/"$base".sort.minq20.scaffold5.bam
#samtools index "$DATAOUTPUT"/"$base".sort.minq20.scaffold5.bam

# Clean up
 #   echo "Removing "$DATAOUTPUT"/"$base".sam"
  #  echo "Removing "$DATAOUTPUT"/"$base".bam"

   #     rm "$DATAOUTPUT"/"$base".sam
    #    rm "$DATAOUTPUT"/"$base".bam