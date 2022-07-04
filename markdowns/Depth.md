# Irrelevant: made a "qsub" looping script!

##### Loads modules:
```
module load tools computerome_utils/2.0
module load htslib/1.13
module load bcftools/1.14
module load samtools/1.14
```

##### Make SAMPLELIST
# Path to a list of prefixes of the raw fastq files. 
```
cd /home/projects/dp_00007/people/hmon/HighCovOysters/
ls *.fq.gz|sed -e 's/_[12].fq.gz//'|sort -u >> ../HighCovOyster_preprocess/01_infofiles/list_HCsamplelist_jun22.txt
```

##### Count_fastq
```
SAMPLELIST=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess/01_infofiles/list_HCsamplelist_jun22.txt
RAWFASTQDIR=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
BASEDIR=/home/projects/dp_00007/people/hmon/HighCovOyster_preprocess
# Loop over each sample in the sample table

for file in $(ls 02_data/*.fq.gz|sed -e 's/_[12].fq.gz//'|sort -u); do
	RAWFASTQFILES=$RAWFASTQDIR/$file'_1.fq.gz'  # The input path and file prefix
	
	# Count the number of reads in raw fastq files. We only need to count the forward reads, since the reverse will contain exactly the same number of reads. fastq files contain 4 lines per read, so the number of total reads will be half of this line number. 
	zcat $RAWFASTQFILES | wc -l  > $BASEDIR/07_depth/${file}.count_fastq_1.tmp &
	
	# Count the number of bases in raw fastq files. We only need to count the forward reads, since the reverse will contain exactly the same number of bases. The total number of reads will be twice this count. 
	zcat $RAWFASTQFILES | awk 'NR%4==2' | tr -d "\n" | wc -m > $BASEDIR/07_depth/${file}.count_fastq_2.tmp  &
	
	wait
		RAWREADS='cat $BASEDIR/07_depth/${file}.count_fastq_1.tmp'
		RAWBASES='cat $BASEDIR/07_depth/${file}.count_fastq_2.tmp'
		printf "%s\t%s\t%s\n" $file $((RAWREADS/4)) $RAWBASES > 07_depth/Fastq_depth_14jun22.txt
done
done
rm *_[12].tmp
```




for file in $(ls 02_data/*_1.fq.gz); do
zcat $file | wc -l  > $BASEDIR/07_depth/count_fastq_1.tmp &
	# Count the number of bases in raw fastq files. We only need to count the forward reads, since the reverse will contain exactly the same number of bases. The total number of reads will be twice this count. 
	zcat $file | awk 'NR%4==2' | tr -d "\n" | wc -m > $BASEDIR/07_depth/count_fastq_2.tmp
	wait
		RAWREADS='cat $BASEDIR/07_depth/count_fastq_1.tmp'
		RAWBASES='cat $BASEDIR/07_depth/count_fastq_2.tmp'
		printf "%s\t%s\t%s\n" $file $((RAWREADS/4)) $RAWBASES > 07_depth/Fastq_depth_14jun22.txt
done
done
rm *_[12].tmp



##### Header on the depth file generated1
#vim it but not optimal 
#sample_seq_id\traw_reads\traw_bases


##### Count after trim/clipping bam
#try: samtools stats 04_mapped/ORIS_19_EKDL220000315-1a-AK19073-AK31217_HWHMNDSX2_L1and2Merged.sort.minq30.bam | grep ^SN | cut -f 2- | grep "^bases mapped (cigar)" | cut -f 2
#works!
```
for SAMPLEFILE in `cat $SAMPLELIST`; do
	## Count raw mapped bases
	RAWBAMFILE=$BASEDIR'04_mapped/'$SAMPLEFILE'.sort.minq30.bam'
	MAPPEDBASES=`samtools stats $RAWBAMFILE -@ 5 | grep ^SN | cut -f 2- | grep "^bases mapped (cigar)" | cut -f 2`
	printf "%s\t%s\n" $SAMPLEFILE $MAPPEDBASES >> 01_infofiles/bam_depth_14jun22.txt
done
```
##### Header on the depth file generated2
#vim it but not optimal 
#sample_seq_id\tmapped_bases



##### Count after dedup/realigned bam
#try: samtools stats 04_mapped/ORIS_19_EKDL220000315-1a-AK19073-AK31217_HWHMNDSX2_L1and2Merged.sort.minq30.bam | grep ^SN | cut -f 2- | grep "^bases mapped (cigar)" | cut -f 2
#works!
#try2: samtools view -q 20 05_dedup/ORIS_14_EKDL210009122-1a-AK31115-AK31116_HTVH3DSX2_L3.nocig.dedup_clipoverlap.minq20.bam | grep YT:Z:CP | awk '{sum+=sqrt($9^2)} END {printf "%f", sum/NR}'
```
for SAMPLEFILE in `cat $SAMPLELIST`; do
	## Count raw mapped bases
	RAWBAMFILE2=$BASEDIR'06_mapped/'$SAMPLEFILE'.nocig.dedup_clipoverlap.minq30realigned.bam'
	MAPPEDBASES2=`samtools stats $RAWBAMFILE -@ 5 | grep ^SN | cut -f 2- | grep "^bases mapped (cigar)" | cut -f 2`
	printf "%s\t%s\n" $SAMPLEFILE2 $MAPPEDBASES2 >> 01_infofiles/Fastq_bam_14jun22.txt
	## Calculate average fragment length for paired end reads
		AVGFRAG=`samtools view -q 30 $BASEDIR'05_dedup/'$SAMPLEFILE'.nocig.dedup.minq30.bam' | grep YT:Z:CP | awk '{sum+=sqrt($9^2)} END {printf "%f", sum/NR}'`
		if [ "$AVGFRAG" == '' ]; then AVGFRAG=0 ; fi
	printf "%s\t%s\t%s\n" $SAMPLEFILE2 $MAPPEDBASES2 $AVGFRAG >> 01_infofiles/cleanbam_14jun22.txt
done
```

























##### Header on the depth file generated3
#vim it but not optimal 
#sample_seq_id\tdedup_mapped_bases\tavg_fragment_size

##### Merged the tables in R
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
# Cleans the environment ~ 
```
rm(list=ls())
pacman::p_load(optparse, tidyverse, plyr, RColorBrewer, extrafont, ggforce, ggrepel, ggstar, RcppCNPy)
fastqcount <- read.table("01_infofiles/Fastq_depth_14jun22.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
bamcount <- read.table("01_infofiles/bam_depth_14jun22.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
cleanbamcount <- read.table("01_infofiles/cleanbam_14jun22.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)

DepthHC <- merge(fastqcount, bamcount, by = "sample_seq_id")
DepthHC <- merge(DepthHC, cleanbamcount, by = "sample_seq_id")
