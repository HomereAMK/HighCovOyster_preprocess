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

#### Loads data Sally_HCminind7_27jun22  ~ ####
data <- as.matrix(read.table("Data/HC_pca/Sally_HCminind7_27jun22.covMat")) 
annot <- read.table("Data/HC_pca/list_HC_noluri.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
#MissingData <- read.table("Data/PCA/Leona20dec21.GL-MissingData.txt", sep = "\t", header = FALSE)
#colnames(MissingData) <- c("Sample_ID", "NumberMissing", "PercentageMissing")

# Runs PCA ~
PCA <- eigen(data)

# Merges the first 3 PCs with annot ~
PCA_Annot <- as.data.frame(cbind(annot, PCA$vectors[, c(1:6)]))
colnames(PCA_Annot) <- c("Sample_ID", "Population", "PCA_1", "PCA_2", "PCA_3", "PCA_4", "PCA_5", "PCA_6")

# Reorders Population ~
PCA_Annot$Population <- factor(PCA_Annot$Population, ordered = T,
                            levels = c("ORIS", "PONT", 
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
varPC4 <-(PCA$values[4]/PCA_Eigenval_Sum)*100
varPC5 <-(PCA$values[5]/PCA_Eigenval_Sum)*100
varPC6 <-(PCA$values[6]/PCA_Eigenval_Sum)*100

#### Create PCA plot With Countries colors #### 
PCA<- ggplot(data = PCA_Annot) + 
  geom_point(aes(x = PCA_1, y = PCA_4, color = Population, shape=Population), size=5) +
  theme(legend.title  = element_blank())+
  scale_colour_manual(values =c( 
                                 "#AD5B35","#CC480C",
                                 "#C89AD1", "#C89AD1",
                                 "#91BD96",
                                 "#02630C",
                                 "#FFFF52",
                                 "#240377"))+
  scale_shape_manual(values=c(
                              16,17,
                              16,18,
                              16,
                              16,
                              16,
                              16))+
  xlab(paste("PC1, ", round(varPC1,digits =3), "% variation", sep="")) + 
  ylab(paste("PC4, ",round(varPC4, digits = 3),"% variation", sep="")) + 
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.background = element_rect(fill = '#FAFAFA')) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())
# Saves plot ~
PCA<- PCA+ggtitle("HC oysters SNPs sites present in at least 50% of the individuals (n=7), SNPs count: 3.576,381")
ggsave(PCA, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/HC_pca/with_minIND/HC_pcaMinind50percenNoluri_Pc1vsPc4.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)
dev.off()

# Cleans the environment ~ 
rm(list=ls())

#### Loads data Frida_HC_30jun22.covMat   ~ ####
data <- as.matrix(read.table("Data/HC_pca/Frida_HC_30jun22.covMat")) 
annot <- read.table("Data/HC_pca/list_HC_noluri.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
#MissingData <- read.table("Data/PCA/Leona20dec21.GL-MissingData.txt", sep = "\t", header = FALSE)
#colnames(MissingData) <- c("Sample_ID", "NumberMissing", "PercentageMissing")

# Runs PCA ~
PCA <- eigen(data)

# Merges the first 3 PCs with annot ~
PCA_Annot <- as.data.frame(cbind(annot, PCA$vectors[, c(1:6)]))
colnames(PCA_Annot) <- c("Sample_ID", "Population", "PCA_1", "PCA_2", "PCA_3", "PCA_4", "PCA_5", "PCA_6")

# Reorders Population ~
PCA_Annot$Population <- factor(PCA_Annot$Population, ordered = T,
                               levels = c("ORIS", "PONT", 
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
varPC4 <-(PCA$values[4]/PCA_Eigenval_Sum)*100
varPC5 <-(PCA$values[5]/PCA_Eigenval_Sum)*100
varPC6 <-(PCA$values[6]/PCA_Eigenval_Sum)*100

#### Create PCA plot With Countries colors #### 
PCA<- ggplot(data = PCA_Annot) + 
  geom_point(aes(x = PCA_1, y = PCA_4, color = Population, shape=Population), size=5) +
  theme(legend.title  = element_blank())+
  scale_colour_manual(values =c( 
    "#AD5B35","#CC480C",
    "#C89AD1", "#C89AD1",
    "#91BD96",
    "#02630C",
    "#FFFF52",
    "#240377"))+
  scale_shape_manual(values=c(
    16,17,
    16,18,
    16,
    16,
    16,
    16))+
  xlab(paste("PC1, ", round(varPC1,digits =3), "% variation", sep="")) + 
  ylab(paste("PC4, ",round(varPC4, digits = 3),"% variation", sep="")) + 
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.background = element_rect(fill = '#FAFAFA')) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())
# Saves plot ~
PCA<- PCA+ggtitle("HC oysters with no restrictions on SNPs, SNPs count: 4.087,795")
ggsave(PCA, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/HC_pca/without_minIND/HC_pcaNorestrictionsSites_Noluri_Pc1vsPc4.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)
dev.off()
