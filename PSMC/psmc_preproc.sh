#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
#PBS -W group_list=dp_00007
#PBS -A dp_00007
#PBS -N PsmcPreproc
#PBS -o 98_log_files/PsmcPreproc.out
#PBS -e 98_log_files/PsmcPreproc.err
#PBS -l nodes=2:ppn=36:fatnode
#PBS -l walltime=600:00:00
#PBS -l mem=1300gb
#PBS -m n
#PBS -r n

module load tools computerome_utils/2.0
module load htslib/1.13
module load bcftools/1.14
module load samtools/1.13
module load pigz/2.3.4
module load psmc/0.6.5
module load gnuplot/5.4.0


### PSMC
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
##### Creates `.psmsfa` files:
for POP in VAGS
do
    for IND in `echo -n 13 06`
    do
    bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
    fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa
    done
done

for POP in TRAL
do
    for IND in `echo -n 19`
    do
    bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
    #fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa  
    done
done

for POP in CLEW
do
    for IND in `echo -n 03`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa
    done
done

for POP in HYPP
do
    for IND in `echo -n 06 04`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa
    done
done

for POP in WADD
do
    for IND in `echo -n 12 13`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa
    done
done

for POP in ORIS
do
    for IND in `echo -n 19`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa
    done
done

for POP in PONT
do
    for IND in `echo -n 03 13`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa
    done
done

