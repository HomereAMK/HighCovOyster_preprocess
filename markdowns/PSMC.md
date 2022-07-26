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
>Nissum
```
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
for POP in NISS
do
    for IND in `seq -w 08 13`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
    done
done
```
>Vagstrånda
```
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
for POP in VAGS
do
    for IND in `echo -n 06 13`
    do
bcftools mpileup --threads 40 -C50 -Ou -f $REF /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/06_realigned/${POP}_${IND}*.minq30realigned.bam | bcftools call -c --threads 40 | vcfutils.pl vcf2fq -d 3 | pigz -p 40 > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz
    done
done

```
##### Creates `.psmsfa` files:
>Nissum
```
for POP in NISS
do
    for IND in `seq -w 08 13`
    do
    fq2psmcfa -q20 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.diploid.fq.gz > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa
    done
done
```

##### Runs `PSMC`:
>Nissum
```
for POP in NISS
do
    for IND in `seq -w 08 13`
    do
    psmc -N25 -t15 -r5 -p "4+25*2+4+6" /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmcfa -o /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PSMC/${POP}_${IND}.psmc
    done
done
```

##### Concatenates `.psmc` files:
>Nissum only
```
cat PSMC/NISS_08.psmc PSMC/NISS_13.psmc > NISSHC-Allind_01_NoBS.psmc
```


##### Plots concatenated `.psmc` results:
 
```
psmc_plot.pl -g 2.5 -u 3.7e-8 -p -G -R -L -M 'LumpfishHC-Skagerrak_01_NoBS,LumpfishHC-Kattegat_01_NoBS,LumpfishHC-Oeresund_01_NoBS,LumpfishHC-BalticSea_01_NoBS' LumpfishHC-AllPops_01_NoBS LumpfishHC-AllPops_01_NoBS.psmc
```
 
##### Plots `PSMC` results:
 
```
for POP in Skagerrak Kattegat Oeresund BalticSea
do
    for IND in 01
    do
    psmc_plot.pl -g 2.5 -u 3.7e-8 -p -G LumpfishHC-${POP}_${IND} /home/projects/dp_00007/people/geopac/Analyses/Lumpfish/Lumpfish_PSMC/LumpfishHC-${POP}_${IND}_NoBS.psmc
    done
done
```
 
##### Performs bootstrapping:
 
```
/groups/hologenomics/software/psmc/v0.6.5/utils/splitfa ~/data/VampireGenomics/PSMCBAMs/D1_4.diploid.psmcfa > ~/data/VampireGenomics/PSMCBAMs/D1_4.diploid.split.psmcfa
```