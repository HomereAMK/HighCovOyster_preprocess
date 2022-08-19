### The BEGINNING ~~~~~
##
# ~ Plots BSG_Combined--SMC++ | By George Pacheco modified by Homère J. Alves Monteiro


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(tidyverse, dplyr, reshape2, lemon, extrafont)


# Defines parameters ~
data_list <- as.data.frame(dir(pattern = ".csv")); colnames(data_list) <- c("SMCfile")


# Loads PSMC data ~ with Lurida, now in a separate folder
#fulldf <- list()
#for (k in 1:nrow(data_list)){
#  fulldf[[k]] <- read.table(file = data_list$SMCfile[k], sep = ",", header = TRUE)
#  fulldf[[k]]$Sample <- gsub("_*.csv", "", data_list[k, 1])
#  fulldf[[k]]$Population <- gsub("[A-z]*_", "", fulldf[[k]]$Sample)}

# Loads PSMC data ~ No lurida
fulldf <- list()
for (k in 1:nrow(data_list)){
  fulldf[[k]] <- read.table(file = data_list$SMCfile[k], sep = ",", header = TRUE)
  fulldf[[k]]$Sample <- gsub("_*noluri.csv", "", data_list[k, 1])
  fulldf[[k]]$Population <- gsub("[A-z]*_", "", fulldf[[k]]$Sample)}

# Melts PSMC data ~
fulldfUp <- melt(fulldf, id = c("label", "x", "y", "plot_type", "plot_num", "Sample", "Population"))


# Corrects Species names ~
#levels(fulldfUp$Species <- sub("AtlanticCod", "Atlantic Cod", fulldfUp$Species))
#levels(fulldfUp$Species <- sub("EuropeanFlounder", "European Flounder", fulldfUp$Species))
#levels(fulldfUp$Species <- sub("NEWAtlanticHerring", "New Atlantic Herring", fulldfUp$Species))
#levels(fulldfUp$Species <- sub("AtlanticHerring", "Atlantic Herring", fulldfUp$Species))


# Reorders Population ~
fulldfUp$Population <- factor(fulldfUp$Population, ordered = T,
                           levels = c("ORIS", "PONT", 
                             "TRAL", "CLEW", "WADD", "NISS",
                                      "HYPP",
                                      "VAGS"
                                      ))


# Corrects Population names ~
#levels(fulldfUp$Population <- sub("Oeresund", "?resund", fulldfUp$Population))
#levels(fulldfUp$Population <- sub("BalticSeaAutumnSpawning", "Baltic Sea Autumn Spawning", fulldfUp$Population))
#levels(fulldfUp$Population <- sub("BalticSea", "Baltic Sea", fulldfUp$Population))
#levels(fulldfUp$Population <- sub("NorthSea", "North Sea", fulldfUp$Population))
#levels(fulldfUp$Population <- sub("BornholmBasin", "Bornholm Basin", fulldfUp$Population))




# Creates SMC++ ~
SMCpp_Plot <-
 ggplot(data = fulldfUp, aes(x = x, y = y, colour = Population)) +
  geom_path(size = 1.1, linejoin = "round", lineend = "butt", linemitre = 10) +
  coord_trans(x = "log1p", y = "log1p") +
  #facet_rep_grid(Population ~. , scales = "free_x") +
  scale_colour_manual(values = c("#AD5B35", "#CC480C", "#C89AD1", "#C89AD1","#91BD96","#02630C","#45D1F7","#240377")) +
  scale_x_continuous("Years Ago",
                     breaks = c(0, 50, 10000, 15000, 20000, 30000,  40000,  50000, 60000, 100000), 
                     labels = c("0", "50", "10Kb", "15Kb", "20Kb",  "30Kb", "40Kb",  "50Kb", "60Kb", "100Kb"),
                     limits = c(0, 3000000),
                     expand = c(0, 0)) +
  scale_y_continuous("Effective Population Size (Ne)",
                     breaks = c(0, 50, 10000, 15000, 20000, 30000,  40000,  50000, 60000, 100000), 
                     labels = c("0", "50", "10Kb", "15Kb", "20Kb",  "30Kb", "40Kb",  "50Kb", "60Kb", "100Kb"),
                     expand = c(0, 0)) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        #panel.grid.major = element_line(color = "#ededed", linetype = "dashed", size = .00005),
        #panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title.x = element_text(size = 15, face = "bold", color = "#000000", margin = margin(t = 30, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 15, face = "bold", color = "#000000", margin = margin(t = 0, r = 30, b = 0, l = 0)),
        axis.text.x = element_text(colour = "#000000", size = 12, face = "bold", angle = 45, vjust = 1, hjust = 1),
        axis.text.y = element_text(colour = "#000000", size = 12, face = "bold"),
        axis.ticks = element_line(color = "#000000", size = .3),
        #strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = .3),
        #strip.text = element_text(colour = "#000000", size = 12, face = "bold"),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 30, b = 25, r = 0, l = 0),
        legend.key = element_rect(fill = NA),
        legend.background = element_blank()) +
  guides(colour = guide_legend(title = "Populations:", title.theme = element_text(size = 19, face = "bold"),
                               label.theme = element_text(size = 17), override.aes = list(size = 1.4), nrow = 1))
  
  
# Saves SMC++ plot ~
ggsave(SMCpp_Plot, file = "SMC_Combined_SMCpp_x2M.pdf",
       device = cairo_pdf, scale = 1, width = 18, height = 16, dpi = 600)
ggsave(SMCpp_Plot, file = "BSG_Combined_SMCpp.jpg",
       scale = 1, width = 16, height = 12, dpi = 600)


#
##
### The END ~~~~~