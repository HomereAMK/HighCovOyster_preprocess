### The BEGINNING ~~~~~
##
# ~ Plots Depth of the bam files for HC  | First written by Nicolas Lou  with later modifications by  Homère J. Alves Monteiro


# Cleans the environment ~ 
rm(list=ls())

# Sets working directory ~
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("~/Desktop/Scripts/")

# Loads required packages ~
pacman::p_load(optparse, tidyverse, plyr, RColorBrewer, extrafont, ggforce, ggrepel, ggstar, RcppCNPy)

# Load data
#Depth<-read.csv("Data/Depth/High-cov/HC_Total.bamdepth.csv", )
Depth <- read.csv("Data/Depth/High-cov/HC_Total.bamdepth.csv", header=TRUE, sep=",", dec=".", stringsAsFactors=FALSE)
str(Depth)
#Depth<-Depth[-c(7,12), ] # forgot to remove header in the concatenate on the server
# Remove path bamfile
Depth$bamfile=sub(".bam","",Depth$bamfile)
Depth$bamfile=sub(".+/","",Depth$bamfile)
Depth$bamfile
Depth$bamfile=sub(".depth.gz","",Depth$bamfile)
pop=substr(Depth$bamfile,0,4) #name only 4characters, pop identifier
mean(Depth$proportion_of_reference_covered)

# Proportion of flat oyster genome covered ~
Depth <- as.data.frame(cbind(Depth, pop))
Prop <-ggplot(data = Depth) + 
    geom_col(mapping = aes(x = bamfile, y = proportion_of_reference_covered, fill = pop))+
    labs(x = " samples", y = "Proportion of flat oyster genome covered")+
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())+
    #geom_hline(yintercept=XXX, color="red")+ #Mean prop of genome covered
    theme(legend.key = element_blank()) +
    theme(legend.title=element_blank()) +
    theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
    theme(legend.text=element_text(size=11)) +
    theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
    theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
    theme(panel.border = element_blank())
# Saves plot ~
Prop<- Prop+ggtitle("Genome coverage HC samples")
ggsave(Prop, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/Depth/HC_Proportion-genome-covered_jul22.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)
dev.off()

# Mean depth ~
Mean <-ggplot(data = Depth) + 
  geom_col(mapping = aes(x = bamfile, y = mean_depth , fill = pop))+
  labs(x = " samples", y = "Mean depth")+
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())+
  #geom_hline(yintercept=XXX, color="red")+ #Mean prop of genome covered
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())
# Saves plot ~
Mean<- Mean+ggtitle("Mean depth HC samples")
ggsave(Mean, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/Depth/HC_MeanDepth_jul22.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)
dev.off()
