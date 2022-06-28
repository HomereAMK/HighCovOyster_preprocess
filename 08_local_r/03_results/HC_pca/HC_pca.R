### The BEGINNING ~~~~~
##
# ~ Plots High-cov PCA | First written by George Pacheco  with later modifications by  Homère J. Alves Monteiro


# Cleans the environment ~ 
rm(list=ls())

# Sets working directory ~
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("~/Desktop/Scripts/")

# Loads required packages ~
pacman::p_load(optparse, tidyverse, plyr, RColorBrewer, extrafont, ggforce, ggrepel, ggstar, RcppCNPy)

#### Loads data ~ ####
data <- as.matrix(read.table("Data/HC_pca/Monika_HC_22jun22.covMat")) 
annot <- read.table("Data/HC_pca/list_HC_9jun22.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
#MissingData <- read.table("Data/PCA/Leona20dec21.GL-MissingData.txt", sep = "\t", header = FALSE)
#colnames(MissingData) <- c("Sample_ID", "NumberMissing", "PercentageMissing")

# Runs PCA ~
PCA <- eigen(data)

# Merges the first 3 PCs with annot ~
PCA_Annot <- as.data.frame(cbind(annot, PCA$vectors[, c(1:3)]))
colnames(PCA_Annot) <- c("Sample_ID", "Population", "PCA_1", "PCA_2", "PCA_3")

# Reorders Population ~
PCA_Annot$Population <- factor(PCA_Annot$Population, ordered = T,
                            levels = c("LURI", 
                                       "ORIS", "PONT", 
                                       "CLEW","TRAL", 
                                       "WADD", 
                                       "NISS", 
                                       "HYPP", 
                                       "VAGS"))

# Gets Eigenvalues of each Eigenvectors ~
PCA_Eigenval_Sum <- sum(PCA$values)
varPC1 <-(PCA$values[1]/PCA_Eigenval_Sum)*100
varPC2 <-(PCA$values[2]/PCA_Eigenval_Sum)*100
varPC3 <-(PCA$values[3]/PCA_Eigenval_Sum)*100

#### Create PCA plot With Countries colors #### 
PCA<- ggplot(data = PCA_Annot) + 
  geom_point(aes(x = PCA_1, y = PCA_2, color = Population, shape=Population)) +
  theme(legend.title  = element_blank())+
  scale_colour_manual(values =c( "#000000",
                                 "#AD5B35","#CC480C",
                                 "#C89AD1", "#C89AD1",
                                 "#91BD96",
                                 "#02630C",
                                 "#FFFF52",
                                 "#240377"
                              
     ))+
  scale_shape_manual(values=c(16,
                              16,17,
                              16,18,
                              16,
                              16,
                              16,
                              16))+
  xlab(paste("PC1, ", round(varPC1,digits =3), "% variation", sep="")) + 
  ylab(paste("PC2, ",round(varPC2, digits = 3),"% variation", sep="")) + 
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.background = element_rect(fill = '#FAFAFA')) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())
