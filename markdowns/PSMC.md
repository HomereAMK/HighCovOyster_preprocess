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
 
### Lumpfish:
 
##### Creates `.diploid.fq` files:
 
##### Creates `.OnlyCHRs` scaffold list:
 
```
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
cut -f 1 "$REF".fai | grep -v "MT_genome" > /home/projects/dp_00007/hmon/HighCovOyster_preprocess/01_infofiles/Oedulis.CHRNames.txt
```