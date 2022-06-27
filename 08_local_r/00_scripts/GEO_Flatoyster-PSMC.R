### The BEGINNING ~~~~~
##
# ~ Plots Flatoyster--PSMC | First written by Jos? Cerca with later modification by George Pacheco. 


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(tidyverse, dplyr, reshape2, lemon, extrafont)


# Loads helper function ~
source("ploting.R")


# Imports extra fonts ~
#loadfonts(device = "win", quiet = TRUE)


# Defines parameters ~
FishMut = 0.3e-08 #estuarine oyster value
data_list <- as.data.frame(dir(pattern = ".psmc")); colnames(data_list) <- c("PSMCfile")
data_list$GenTime <- ifelse(grepl("AtlanticHerring", data_list$PSMCfile), 1, 1)


# Loads PSMC data ~
fulldf <- list()
for (k in 1:nrow(data_list)){
  fulldf[[k]] <- psmc.result(file = data_list$PSMCfile[k], g = data_list$GenTime[k], mu = FishMut, s = 500)
  fulldf[[k]]$Sample_ID <- gsub(".psmc", "", data_list[k, 1])
  fulldf[[k]]$Population <- gsub("[A-z]*HC-", "", fulldf[[k]]$Sample_ID)
  fulldf[[k]]$Population <- gsub("_[0-9]*", "", fulldf[[k]]$Population)}


# Melts PSMC data ~
fulldfUp <- melt(fulldf, id = c("Sample_ID", "Population", "YearsAgo", "Ne"))


# Corrects Species names ~
levels(fulldfUp$Species <- sub("EuropeanFlounder", "European Flounder", fulldfUp$Species))
levels(fulldfUp$Species <- sub("AtlanticCod", "Atlantic Cod", fulldfUp$Species))
levels(fulldfUp$Species <- sub("AtlanticHerring", "Atlantic Herring", fulldfUp$Species))


# Corrects Population names ~
levels(fulldfUp$Population <- sub("NorthSea", "North Sea", fulldfUp$Population))
levels(fulldfUp$Population <- sub("Oeresund", "?resund", fulldfUp$Population))
levels(fulldfUp$Population <- sub("BornholmBasin", "Bornholm Basin", fulldfUp$Population))
levels(fulldfUp$Population <- sub("BalticSeaAutumnSpawning", "Baltic Sea Autumn Spawning", fulldfUp$Population))
levels(fulldfUp$Population <- sub("BalticSea", "Baltic Sea", fulldfUp$Population))


# Reorders Species ~
fulldfUp$Species <- factor(fulldfUp$Species, ordered = T,
                           levels = c("Turbot",
                                      "European Flounder",
                                      "Atlantic Cod",
                                      "Atlantic Herring",
                                      "Lumpfish"))


# Reorders Population ~
fulldfUp$Population <- factor(fulldfUp$Population, ordered = T,
                              levels = c("North Sea",
                                         "Skagerrak",
                                         "Kattegat",
                                         "?resund",
                                         "Bornholm Basin",
                                         "Baltic Sea",
                                         "Baltic Sea Autumn Spawning"))


# Limits YearsAgo to 12K - 100K ~
fulldfUpUp <- fulldfUp %>% filter(YearsAgo >= 1500 & YearsAgo <= 1000000)


# Custom y-axis breaks ~
breaks_fun <- function(y){
  caseVal <- min(y)
  print(y)
  if (round(caseVal) == 4349){
    c(5000, 10000, 15000, 20000, 30000)}
  else if (round(caseVal) == 2457){
    c(5000, 10000, 15000, 25000, 50000)}
  else if (round(caseVal) == 2347){
    c(10000, 25000, 50000, 100000, 150000)}
  else if (round(caseVal) ==  17201){
    c(25000, 50000, 75000, 100000, 150000)}
  else if (round(caseVal) == 2663){
    seq(2000, 12000, by = 2000)}}


# Custom y-axis limits ~
limits_fun <- function(x){
  caseVal <- min(x)
  print(x)
  if (round(caseVal) == 3123 || round(caseVal) == 5171){
    c(5000, 30000)}
  else if (round(caseVal) == 2624 || round(caseVal) == 3312){
    c(3000, 60000)}
  else if (round(caseVal) == 4064 || round(caseVal) == 6718){
    c(3000, 150000)}
  else if (round(caseVal) == 9249 || round(caseVal) == 20222){
    c(20000, 150000)}
  else {
    c(3000, 12000)}}


# Custom y-axis labels ~
plot_index_labels <- 0
labels_fun <- function(x) {
  plot_index_labels <<- plot_index_labels + 1L
  switch(plot_index_labels,
         scales::label_number(accuracy = 1, scale = 1/1000, big.mark = "", suffix = "K")(x),
         scales::label_number(accuracy = 1, scale = 1/1000, big.mark = "", suffix = "K")(x),
         scales::label_number(accuracy = 1, scale = 1/1000, big.mark = "", suffix = "K")(x),
         scales::label_number(accuracy = 1, scale = 1/1000, big.mark = "", suffix = "K")(x),
         scales::label_number(accuracy = 1, scale = 1/1000, big.mark = "", suffix = "K")(x))}


# Creates plot ~
PSMC_plot <-
 ggplot(fulldfUpUp, aes(YearsAgo, Ne, group = Sample_ID, colour = Population)) +
        geom_line(linetype = 1, size = .75, alpha = .9) +
        coord_trans(x = "log", y = "log") +
        facet_rep_grid(Population ~. , scales = "free_y") +
        scale_colour_manual(values = c("#4575b4", "#4575b4", "#8c510a", "#fee090", "#fc8d59", "#d73027", "#1b7837")) +
        scale_x_continuous("Years Ago",
                     breaks = c(5000, 10000, 15000, 25000),
                     labels = c("5K", "10K", "15K", "25K"),
                     #limits = c(1500, 25200),
                     expand = c(.005, .005)) +
        scale_y_continuous("Effective Population Size",
                     #limits = limits_fun,
                     #breaks = breaks_fun,
                     #labels = labels_fun,
                     expand = c(.05, .05)) +
        theme(panel.background = element_rect(fill = "#ffffff"),
              panel.border = element_blank(),
              panel.spacing.y = unit(1, "cm"),
              panel.grid.major = element_line(color = "#ededed", linetype = "dashed", size = .5),
              panel.grid.minor = element_blank(), 
              legend.position = "top",
              legend.background = element_blank(),
              legend.key = element_blank(),
              legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
              legend.box.margin = margin(t = 10, b = 30, r = 0, l = 0),
              axis.title.x = element_text(size = 22, face = "bold", margin = margin(t = 30, r = 0, b = 10, l = 0)),
              axis.title.y = element_text(size = 22, face = "bold", margin = margin(t = 0, r = 30, b = 0, l = 10)),
              axis.text = element_text(color = "#000000", size = 13, face = "bold"),
              axis.ticks = element_line(color = "#000000", size = .3),
              strip.text = element_text(colour = "#000000", size = 17, face = "bold"),
              strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = 0.3),
              axis.line = element_line(colour = "#000000", size = .3)) +
        guides(colour = guide_legend(title = "Populations:", title.theme = element_text(size = 20, face = "bold"),
                        label.theme = element_text(size = 19), override.aes = list(size = 2, alpha = .9), nrow = 1))

  
# Saves plot ~
ggsave(PSMC_plot, file = "~/Desktop/Scripts/HighCovOyster_preprocess/08_local_r/03_results/PSMC/HC_Nissum_mu0.3e-8_Jun22.pdf",
       device = cairo_pdf, width = 14, height = 14, scale = 1.35, dpi = 600)
dev.off()

#
##
### The END ~~~~~