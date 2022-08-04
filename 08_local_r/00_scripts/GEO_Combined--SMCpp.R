### The BEGINNING ~~~~~
##
# ~ Plots BSG_Combined--SMC++ | By George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(tidyverse, dplyr, reshape2, lemon, extrafont)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Defines parameters ~
data_list <- as.data.frame(dir(pattern = ".csv")); colnames(data_list) <- c("SMCfile")


# Loads PSMC data ~
fulldf <- list()
for (k in 1:nrow(data_list)){
  fulldf[[k]] <- read.table(file = data_list$SMCfile[k], sep = ",", header = TRUE)
  fulldf[[k]]$Sample <- gsub("_*.csv", "", data_list[k, 1])
  fulldf[[k]]$Species <- gsub("_[A-z]*", "", fulldf[[k]]$Sample)
  fulldf[[k]]$Population <- gsub("[A-z]*_", "", fulldf[[k]]$Sample)}


# Melts PSMC data ~
fulldfUp <- melt(fulldf, id = c("label", "x", "y", "plot_type", "plot_num", "Sample", "Species", "Population"))


# Corrects Species names ~
levels(fulldfUp$Species <- sub("AtlanticCod", "Atlantic Cod", fulldfUp$Species))
levels(fulldfUp$Species <- sub("EuropeanFlounder", "European Flounder", fulldfUp$Species))
levels(fulldfUp$Species <- sub("NEWAtlanticHerring", "New Atlantic Herring", fulldfUp$Species))
levels(fulldfUp$Species <- sub("AtlanticHerring", "Atlantic Herring", fulldfUp$Species))


# Reorders Population ~
fulldfUp$Species <- factor(fulldfUp$Species, ordered = T,
                           levels = c("Turbot",
                                      "European Flounder",
                                      "Atlantic Cod",
                                      "Atlantic Herring",
                                      "New Atlantic Herring",
                                      "Lumpfish"))


# Corrects Population names ~
levels(fulldfUp$Population <- sub("Oeresund", "?resund", fulldfUp$Population))
levels(fulldfUp$Population <- sub("BalticSeaAutumnSpawning", "Baltic Sea Autumn Spawning", fulldfUp$Population))
levels(fulldfUp$Population <- sub("BalticSea", "Baltic Sea", fulldfUp$Population))
levels(fulldfUp$Population <- sub("NorthSea", "North Sea", fulldfUp$Population))
levels(fulldfUp$Population <- sub("BornholmBasin", "Bornholm Basin", fulldfUp$Population))


# Reorders Population ~
fulldfUp$Population <- factor(fulldfUp$Population, ordered = T,
                              levels = c("Skagerrak",
                                         "North Sea",
                                         "Kattegat",
                                         "?resund",
                                         "Bornholm Basin",
                                         "Baltic Sea",
                                         "Baltic Sea Autumn Spawning"))


# Creates SMC++ ~
SMCpp_Plot <-
 ggplot(data = fulldfUp, aes(x = x, y = y, colour = Population)) +
  geom_path(size = 1.1, linejoin = "round", lineend = "butt", linemitre = 10) +
  coord_trans(x = "log1p", y = "log1p") +
  facet_rep_grid(Species ~. , scales = "free_x") +
  scale_colour_manual(values = c("#3288bd", "#af8dc3", "#fee08b", "#fc8d59", "#e6f598", "#99d594", "#d53e4f")) +
  scale_x_continuous("Years Ago",
                     breaks = c(100, 250, 500, 1000, 2000, 3000, 4000, 5000, 10000, 15000, 20000, 25000, 30000), 
                     labels = c("100", "250", "500", "1Kb", "2Kb", "3Kb", "4Kb", "5Kb", "10Kb", "15Kb", "20Kb", "25Kb", "30Kb"),
                     limits = c(0, 2000500),
                     expand = c(0, 0)) +
  scale_y_continuous("Population Size",
                     breaks = c(2000, 4000, 6000, 8000, 10000), 
                     labels = c("2Kb", "4Kb", "6Kb", "8Kb", "10Kb"),
                     expand = c(0, 0)) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.major = element_line(color = "#ededed", linetype = "dashed", size = .00005),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title.x = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 30, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 0, r = 30, b = 0, l = 0)),
        axis.text.x = element_text(colour = "#000000", size = 12, face = "bold", angle = 45, vjust = 1, hjust = 1),
        axis.text.y = element_text(colour = "#000000", size = 12, face = "bold"),
        axis.ticks = element_line(color = "#000000", size = .3),
        strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = .3),
        strip.text = element_text(colour = "#000000", size = 12, face = "bold"),
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