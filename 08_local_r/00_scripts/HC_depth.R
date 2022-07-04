### The BEGINNING ~~~~~
##
# ~ Plots depth for High-cov and Low-cov libraries | Written on the template of Nicolas Lou script by  Homère J. Alves Monteiro

# Cleans the environment ~ 
rm(list=ls())

# Sets working directory ~
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("~/Desktop/Scripts/")

# Loads required packages ~
pacman::p_load( tidyverse,cowplot,knitr)

# Define useful function
select_relevant_rows <- function(x){
  dplyr::select(x, Sample_ID, pops,raw_reads, raw_bases, adapter_clipped_bases, mapped_bases, dedup_mapped_bases, realigned_mapped_bases)
}
sum_count <- function(x){
  summarize(x, raw_bases=sum(as.numeric(raw_bases)), 
            adapter_clipped_bases=sum(as.numeric(adapter_clipped_bases)), 
            mapped_bases=sum(as.numeric(mapped_bases)), 
            dedup_mapped_bases=sum(as.numeric(dedup_mapped_bases)),
            realigned_mapped_bases=sum(as.numeric(realigned_mapped_bases)))%>%
    ungroup()
}

# sum_count <- function(x){
#   summarize(x, raw_bases=sum(as.numeric(raw_bases)), 
#             adapter_clipped_bases=sum(as.numeric(adapter_clipped_bases)), 
#             qual_filtered_bases=sum(as.numeric(qual_filtered_bases)), 
#             mapped_bases=sum(as.numeric(mapped_bases)), 
#             qual_filtered_mapped_bases=sum(as.numeric(qual_filtered_mapped_bases)),
#             dedup_mapped_bases=sum(as.numeric(dedup_mapped_bases))) %>%
#     ungroup()
# }

##### Load High-cov data #####
depthHC <-read.table("Data/Depth/High-cov/Summary_HCdepth_29jun22.txt", sep = "\t", header = FALSE)
depthHC <- depthHC %>% discard(~all(is.na(.) | . ==""))

#name columns
colnames(depthHC) <- c("Sample_ID", "raw_reads", "raw_bases", "adapter_clipped_bases","mapped_bases", "dedup_mapped_bases", "realigned_mapped_bases")
pops=substr(depthHC$Sample_ID,0,4)
depthHC <- as.data.frame(cbind(depthHC, pops))

#Read in the data
depthHC<- depthHC  %>% select_relevant_rows()
count_by_pop <- group_by(depthHC, pops) %>%
  sum_count() %>%
  gather(key="steps", value = base_count, 2:5) %>%
  mutate(steps=fct_reorder(steps,base_count, mean, .desc = T))
sums <- group_by(depthHC, pops) %>%
  summarise(sum=sum(as.numeric(dedup_mapped_bases)))
means <- group_by(depthHC, pops) %>%
  summarise(mean=mean(dedup_mapped_bases))
proportion_retained <-group_by(depthHC, pops) %>%
  summarise(proportion=mean(dedup_mapped_bases/raw_bases))

#Total number of bases per individual, grouped by populations #(in GB)
set.seed(1)
Base <-ggplot(depthHC, aes(x=pops, y=dedup_mapped_bases/10^9)) +
  geom_jitter(aes(color=pops), height=0) +
  geom_boxplot(alpha=0, outlier.colour=NA) +
  #geom_label(data=means, aes(label = round(mean/10^9, 3), y = mean/10^9), alpha=1) +
  coord_flip() +
  theme_cowplot()
last_plot()
# Saves plot ~
ggsave(Base, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/Depth/HC_Totalnumber_basesperindividual_groupedby_pop.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)
dev.off()

# Sum of bases retained in each step per population (in GB)
sumbase<-ggplot(count_by_pop) +
  geom_bar(mapping=aes(x=pops, y=base_count/10^9, fill=steps), stat="identity", pos="identity", color="black", width = 0.8) +
  #geom_label(data=sums, aes(label=round(sum/10^9,2), x=population, y=sum/10^9-0.8)) +
  coord_flip() +
  theme_cowplot()
last_plot()
# Saves plot ~
ggsave(sumbase, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/Depth/HC_Sumbasesretainedstepperpop.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)
dev.off()

# Percentage of bases retained after all mapping and QC steps, grouped by populations (in percent)
set.seed(1)
aftermap <- ggplot(depthHC, aes(x=pops, y=realigned_mapped_bases/mapped_bases*100)) +
  geom_jitter(aes(color=pops), height=0) +
  geom_boxplot(alpha=0, outlier.colour="yellow") +
  #geom_label(data=proportion_retained, aes(label = round(proportion*100, 1), y = proportion*100), alpha=1) +
  coord_flip() +
  theme_cowplot()
last_plot()
# Saves plot ~
ggsave(aftermap, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/Depth/HC_PercentagebasesretainedafterMapRealigned.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)
dev.off()













