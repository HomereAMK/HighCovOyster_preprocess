# Irrelevant: made a "qsub" looping script!

##### Loads modules:
```
module load tools computerome_utils/2.0
module load htslib/1.13
module load bcftools/1.14
module load samtools/1.14
```
# Path to a list of prefixes of the raw fastq files. 
```
cd /home/projects/dp_00007/people/hmon/HighCovOysters/
ls *.fq.gz|sed -e 's/_[12].fq.gz//'|sort -u >> ../HighCovOyster_preprocess/01_infofiles/list_HCsamplelist_jun22.txt
```
## Make depth list
```
BAMSDEPTH=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/07_depth/*L4_depth.gz
ls $BAMSDEPTH > 07_depth/list_depth_HC_L4
BAMSDEPTH=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/07_depth/*L1_depth.gz
ls $BAMSDEPTH > 07_depth/list_depth_HC_L1
BAMSDEPTH=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/07_depth/*L1and2Merged_depth.gz
ls $BAMSDEPTH > 07_depth/list_depth_HC_Merged

```

#####  in R
# Load modules FOR R AND NGSLD
```
module load gsl/2.6
module load perl/5.20.1
module load imagemagick/7.0.10-13
module load gdal/2.2.3
module load geos/3.8.0
module load jags/4.2.0
module load hdf5
module load netcdf
module load boost/1.74.0
module load openssl/1.0.0
module load lapack
module load udunits/2.2.26
module load proj/7.0.0
module load gcc/10.2.0
module load intel/perflibs/64/2020_update2
module load R/4.0.0
```
# R script ~ 
```
#Clean space
rm(list=ls())

#
library(Rserve)
library(tidyverse)

#var
basedir <- "/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess" # Make sure to edit this to match your $BASEDIR
bam_list <- read_lines(paste0(basedir, "/07_depth/list_depth_HC_Merged"))

for (i in 1:length(bam_list)){

  bamfile = bam_list[i]
  # Compute depth stats
  depth <- read_tsv(paste0(bamfile), col_names = F)$X1
  mean_depth <- mean(depth)
  sd_depth <- sd(depth)
  mean_depth_nonzero <- mean(depth[depth > 0])
  mean_depth_within2sd <- mean(depth[depth < mean_depth + 2 * sd_depth])
  median <- median(depth)
  presence <- as.logical(depth)
  proportion_of_reference_covered <- mean(presence)

# Bind stats into dataframe and store sample-specific per base depth and presence data
  if (i==1){
    output <- data.frame(bamfile, mean_depth, sd_depth, mean_depth_nonzero, mean_depth_within2sd, median, proportion_of_reference_covered)
    total_depth <- depth
    total_presence <- presence
  } else {
    output <- rbind(output, cbind(bamfile, mean_depth, sd_depth, mean_depth_nonzero, mean_depth_within2sd, median, proportion_of_reference_covered))
    total_depth <- total_depth + depth
    total_presence <- total_presence + presence
  }
}
print(output)
write_csv(output, file="/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/output.HC_Merged.bamdepth.csv")  #change path
write_tsv(output, file="/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/output.HC_Merged.bamdepth.tsv")  #change path

output2 <- output %>%
  mutate(across(where(is.numeric), round, 3))%>% 
  write_csv(output2, file = "samplespe_per_base_depth_presenceData.HC_Merged.bamdepth.csv")
```

# Concatenate the 2 csv
cat output.HC_L1.bamdepth.csv output.HC_L4.bamdepth.csv output.HC_Merged.bamdepth.csv > HC_Total.bamdepth.csv