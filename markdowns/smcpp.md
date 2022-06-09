### Angsd job
```
module load tools computerome_utils/2.0
module load htslib/1.13
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.937
module load bcftools/1.14
```
```
N_IND=`cat /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/list_HC_9jun22.txt | wc -l`
BAMLIST="/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/list_HC_9jun22.txt"
GENOME="/home/projects/dp_00007/people/hmon/Shucking/01_infofiles/fileOegenome10scaffoldC3G.fasta"
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $GENOME -bam $BAMLIST -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*75/100)) -MinMaf 0.05 -setMaxDepth $((N_IND*100)) -doCounts 1 -doGlf 2 -GL 1 -doMajorMinor 4 -doMaf 1 -SNP_pval 1e-6 -postCutoff 0.95 -doPost 2 -doPlink 2 -doBcf 1 -doGeno 2 -dumpCounts 2 -out /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamples--SNPs_Ind75_jun22
```