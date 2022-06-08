#### Pre-Analysis:
 
##### Loads modules:
 
```
module load tools computerome_utils/2.0
module load htslib/1.13
module load bcftools/1.14
module load samtools/1.13
module load pigz/2.3.4
module load psmc/0.6.5
module load gnuplot/5.4.0
```
 
### PSMC
 
```
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
for POP in BalticSeaAutumnSpawning
do
    for IND in `seq -w 03 04`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
    done
done
```