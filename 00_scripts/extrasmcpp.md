### Converts the .bcf into ´.smc´ per chromosome:
> Nissum #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.NISS.${query2}.smc.gz ${query2} NISS:NISS_08_EKDL220000316-1a-AK19154-AK31214_HWHMNDSX2_L4,NISS_13_EKDL220000317-1a-AK31212-AK31213_HWHVMDSX2_L1
done
```
> VAGS #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.VAGS.${query2}.smc.gz ${query2} VAGS:VAGS_06_EKDL220000317-1a-AK31205-AK31206_HWHVMDSX2_L1,VAGS_13_EKDL220000316-1a-AK19085-AK31204_HWHMNDSX2_L4
done
```
> TRAL #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.TRAL.${query2}.smc.gz ${query2} TRAL:TRAL_19_EKDL220000317-1a-AK19261-AK31202_HWHVMDSX2_L1
done
```

> CLEW #
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.CLEW.${query2}.smc.gz ${query2} CLEW:CLEW_03_EKDL220000317-1a-AK19153-AK31203_HWHVMDSX2_L1
done
```
> HYPP#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.HYPP.${query2}.smc.gz ${query2} HYPP:HYPP_04_EKDL220000316-1a-AK19284-AK31207_HWHMNDSX2_L4,HYPP_06_EKDL220000315-1a-AK19202-AK18625_HWHMNDSX2_L1and2Merged 
done
```

> WADD#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.WADD.${query2}.smc.gz ${query2} WADD:WADD_12_EKDL220000316-1a-AK19239-AK22948_HWHMNDSX2_L4,WADD_13_EKDL220000317-1a-AK19244-AK31215_HWHVMDSX2_L1 
done
```
> ORIS#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.ORIS.${query2}.smc.gz ${query2} ORIS:ORIS_17_EKDL220000315-1a-AK31218-AK31219_HWHMNDSX2_L1and2Merged,ORIS_19_EKDL220000315-1a-AK19073-AK31217_HWHMNDSX2_L1and2Merged
done
```
> PONT#
```
for query2 in ${CHRs[*]}
    do
    smc++ vcf2smc /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited2.bcf.gz /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.PONT.${query2}.smc.gz ${query2} PONT:PONT_03_EKDL220000315-1a-AK19049-AK31216_HWHMNDSX2_L1and2Merged,PONT_13_EKDL220000317-1a-AK31208-AK31209_HWHVMDSX2_L1
done
```


### Fits a population size history: mutation rate 0.3e-08 #estuarine oyster value
```
for query in ${POPs[*]}
do
smc++ estimate 0.3e-08 /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/HCSamplesNoLuri--SNPs_Ind75_aug22_OnlyBiallelic.Edited.${query}.*.smc.gz -o /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/NoLuri/${query}/
done
```

#tryout
POPs=("NISS" "VAGS" "TRAL" "CLEW" "HYPP" "WADD" "ORIS" "PONT")
CHRs=("scaffold1" "scaffold2" "scaffold3" "scaffold4" "scaffold5" "scaffold6" "scaffold7" "scaffold8" "scaffold9" "scaffold10")
for query in ${POPs[*]}
do
smc++ plot /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/NoLuri/${query}/${query}.pdf -g 1 -c /home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/smcpp/NoLuri/${query}/model.final.json
done