### Angsd job with Lurida
```
module load tools computerome_utils/2.0
module load htslib/1.14
module load bcftools/1.14
module load bedtools/2.30.0
module load smcpp/1.15.5
module load gnuplot/5.4.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.937
```
```
N_IND=`cat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_9jun22.txt | wc -l`
BAMLIST="/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_9jun22.txt"
GENOME="/home/projects/dp_00007/people/hmon/Shucking/01_infofiles/fileOegenome10scaffoldC3G.fasta"
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $GENOME -bam $BAMLIST -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*75/100)) -MinMaf 0.05 -setMaxDepth $((N_IND*100)) -doCounts 1 -doGlf 2 -GL 1 -doMajorMinor 4 -doMaf 1 -SNP_pval 1e-6 -postCutoff 0.95 -doPost 2 -doPlink 2 -doBcf 1 -doGeno 2 -dumpCounts 2 -out /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22
```
>7 199 137 SNPS
```
N_IND=`cat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_noluri.txt | wc -l`
BAMLIST="/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HC_noluri.txt"
GENOME="/home/projects/dp_00007/people/hmon/Shucking/01_infofiles/fileOegenome10scaffoldC3G.fasta"
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $GENOME -bam $BAMLIST -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*75/100)) -MinMaf 0.05 -setMaxDepth $((N_IND*100)) -doCounts 1 -doGlf 2 -GL 1 -doMajorMinor 4 -doMaf 1 -SNP_pval 1e-6 -postCutoff 0.95 -doPost 2 -doPlink 2 -doBcf 1 -doGeno 2 -dumpCounts 2 -out /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22
```
>7 418 745 SNPS
### Creates a new .bcf file containing only biallelic SNPs:
```
bcftools view -m2 -M2 -v snps /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22.bcf.gz | bgzip > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.bcf.gz

-

bcftools view -m2 -M2 -v snps /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22.bcf.gz | bgzip > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.bcf.gz
```
### Edits .bcf file:
```
zcat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.bcf.gz | sed -e 's/\/home\/projects\/dp_00007\/people\/hmon\/HighCovOyster_preprocess\/06_realigned\///g' | sed -e 's/.bam//g' | bgzip > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited.bcf.gz

zcat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited.bcf.gz | sed 's/.nocig.dedup_clipoverlap.minq30realigned//g' | bgzip > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz

-

zcat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.bcf.gz | sed -e 's/\/home\/projects\/dp_00007\/people\/hmon\/HighCovOyster_preprocess\/06_realigned\///g' | sed -e 's/.bam//g' | bgzip > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.bcf.gz

zcat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.bcf.gz | sed 's/.nocig.dedup_clipoverlap.minq30realigned//g' | bgzip > /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz

```

### Indexes the .bcf file:
```
bcftools index /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz

-

bcftools index /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz

```
### Set variables
```
POPs=("NISS" "VAGS" "TRAL" "CLEW" "HYPP" "WADD" "ORIS" "PONT" "LURI")
CHRs=("scaffold1" "scaffold2" "scaffold3" "scaffold4" "scaffold5" "scaffold6" "scaffold7" "scaffold8" "scaffold9" "scaffold10")
```
### Converts the .bcf into ´.smc´ per chromosome:
> Nissum #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.NISS.${query2}.smc.gz ${query2} NISS:NISS_08_EKDL220000316-1a-AK19154-AK31214_HWHMNDSX2_L4,NISS_13_EKDL220000317-1a-AK31212-AK31213_HWHVMDSX2_L1
done
```
> VAGS #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.VAGS.${query2}.smc.gz ${query2} VAGS:VAGS_06_EKDL220000317-1a-AK31205-AK31206_HWHVMDSX2_L1,VAGS_13_EKDL220000316-1a-AK19085-AK31204_HWHMNDSX2_L4
done
```
> TRAL #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.TRAL.${query2}.smc.gz ${query2} TRAL:TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1
done
```

> CLEW #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.CLEW.${query2}.smc.gz ${query2} CLEW:CLEW_03_EKDL220000317-1a-AK19153-AK31203_HWHVMDSX2_L1
done
```
> HYPP#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.HYPP.${query2}.smc.gz ${query2} HYPP:HYPP_04_EKDL220000316-1a-AK19284-AK31207_HWHMNDSX2_L4,HYPP_06_EKDL220000315-1a-AK19202-AK18625_HWHMNDSX2_L1and2Merged 
done
```

> WADD#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.WADD.${query2}.smc.gz ${query2} WADD:WADD_12_EKDL220000316-1a-AK19239-AK22948_HWHMNDSX2_L4,WADD_13_EKDL220000317-1a-AK19244-AK31215_HWHVMDSX2_L1 
done
```
> ORIS#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.ORIS.${query2}.smc.gz ${query2} ORIS:ORIS_17_EKDL220000315-1a-AK31218-AK31219_HWHMNDSX2_L1and2Merged,ORIS_19_EKDL220000315-1a-AK19073-AK31217_HWHMNDSX2_L1and2Merged
done
```
> PONT#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.PONT.${query2}.smc.gz ${query2} PONT:PONT_03_EKDL220000315-1a-AK19049-AK31216_HWHMNDSX2_L1and2Merged,PONT_13_EKDL220000317-1a-AK31208-AK31209_HWHVMDSX2_L1
done
```

> LURI
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.LURI.${query2}.smc.gz ${query2} LURI:LURI_08_EKDL220000315-1a-AK31210-AK31211_HWHMNDSX2_L1and2Merged
done
```
### Fits a population size history: mutation rate 0.3e-08 #estuarine oyster value
```
for query in ${POPs[*]}
do
smc++ estimate 0.3e-08 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_OnlyBiallelic.Edited.${query}.*.smc.gz -o /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/${query}/
done
```

### Plots results: generation time =1
```
#tryout
POPs=("NISS" "VAGS" "TRAL" "CLEW" "HYPP" "WADD" "ORIS" "PONT" "LURI")
CHRs=("scaffold1" "scaffold2" "scaffold3" "scaffold4" "scaffold5" "scaffold6" "scaffold7" "scaffold8" "scaffold9" "scaffold10")
for query in ${POPs[*]}
do
smc++ plot /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/${query}/${query}.pdf -g 1 -c /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/${query}/model.final.json
done
```
