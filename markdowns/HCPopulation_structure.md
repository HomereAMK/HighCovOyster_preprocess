
- [Genome-wide-pca](#genome-wide-pca)
- [Genome-wide-pca-nolurida](#genome-wide-pca-nolurida)

## Genome-wide-pca
```
SAMPLELIST=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HCsamplelist_jun22.txt
WORKDIR=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/
#Get the label list from the bam list
awk '{split($0,a,"/"); print a[9]}' $SAMPLELIST | awk '{split($0,b,"_"); print b[1]"_"b[2]}' > $WORKDIR/01_infofiles/list_HCsamplelist_jun22.labels
```
```
#Get the annotation file 
cat $WORKDIR/01_infofiles/list_HCsamplelist_jun22.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > $WORKDIR/01_infofiles/list_HCsamplelist_jun22.annot
```

```
# Load module angsd
module load tools ngs computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.937
```
```
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
BAMLIST=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_9jun22.txt
OUTPUTDIR=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PCA
```
> no minInd flag
```
angsd -b $BAMLIST -ref $REF -out $OUTPUTDIR/Monika_HC_22jun22 \
-remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 30 -MinMaf 0.015 -SNP_pval 1e-6 -postCutoff 0.95 \
-GL 2 -doMajorMinor 4 -doMaf 1 -doCounts 1 -doGlf 2 -doPost 2 -doGeno 2 -dumpCounts 2 -doHaploCall 1 -doIBS 1 -doDepth 1 \
-doCov 1 -makeMatrix 1 -P 36
```

```
#Get the label list from the bam list
awk '{split($0,a,"/"); print a[9]}' $BAMLIST | awk '{split($0,b,"_"); print b[1]"_"b[2]}' > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_9jun22.labels
```
```
#Get the annotation file 
cat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_9jun22.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_9jun22.annot
```


>Get Real Coverage (_Genotype Likelihoods_):
```

  zcat $OUTPUTDIR/Monika_HC_22jun22.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste $BAMLIST - > $OUTPUTDIR/Monika_HC_22jun22.GL-RealCoverage.txt
```
> Get Missing Data (_Genotype Likelihoods_):
```
  N_SITES='zcat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PCA/Monika_HC_22jun22.beagle.gz | tail -n +2 | wc -l'

  zcat $OUTPUTDIR/Monika_HC_22jun22.beagle.gz | tail -n +2 | perl /home/projects/dp_00007/apps/Scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_9jun22.labels - | awk -v N_SITESawk="$N_SITES" '{print $1"\t"$3"\t"$3*100/N_SITESawk}' > $OUTPUTDIR/Monika_HC_22jun22.GL-MissingData.txt

```

## Genome-wide-pca-nolurida
>Including the outgroup lurida in the analysis generates lot of missing data, in this run we choose to only study SNPs sites present in at least 50% of the individuals (n=7)
```
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
BAMLIST=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_noluri.txt
OUTPUTDIR=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PCA
```
>  -minInd 50% flag
```
angsd -b $BAMLIST -ref $REF -out $OUTPUTDIR/Sally_HCminind7_27jun22 \
-remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 30 -MinMaf 0.015 -SNP_pval 1e-6 -postCutoff 0.95 -minInd 7 \
-GL 2 -doMajorMinor 4 -doMaf 1 -doCounts 1 -doGlf 2 -doPost 2 -doGeno 2 -dumpCounts 2 -doHaploCall 1 -doIBS 1 -doDepth 1 \
-doCov 1 -makeMatrix 1 -P 36
```
```
#Get the label list from the bam list
awk '{split($0,a,"/"); print a[9]}' $BAMLIST | awk '{split($0,b,"_"); print b[1]"_"b[2]}' > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_noluri.labels
```
```
#Get the annotation file 
cat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_noluri.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_noluri.annot
```


>Get Real Coverage (_Genotype Likelihoods_):
```

  zcat $OUTPUTDIR/Sally_HCminind7_27jun22.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste $BAMLIST - > $OUTPUTDIR/Sally_HCminind7_27jun22.GL-RealCoverage.txt
```
> Get Missing Data (_Genotype Likelihoods_):
```
  N_SITES='zcat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/PCA/Sally_HCminind7_27jun22.beagle.gz | tail -n +2 | wc -l'

  zcat $OUTPUTDIR/Sally_HCminind7_27jun22.beagle.gz | tail -n +2 | perl /home/projects/dp_00007/apps/Scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_noluri.labels - | awk -v N_SITESawk="$N_SITES" '{print $1"\t"$3"\t"$3*100/N_SITESawk}' > $OUTPUTDIR/Sally_HCminind7_27jun22.GL-MissingData.txt

```
