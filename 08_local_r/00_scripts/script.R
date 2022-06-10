setwd("/Users/josepc/OneDrive - NTNU/ongoing_stuff_ambientedetrabalho/bhw/bhw_PSMC/02_secondTry/")

source("ploting.R")

#using the mutation rate as provided by Miks paper
#https://www.sciencedirect.com/science/article/pii/S2589004219300896?via%3Dihub#mmc1
whale_05<-psmc.result(file="17-05.psmc", g=50, mu=2.69e-08)
whale_07<-psmc.result(file="17-07.psmc", g=50, mu=2.69e-08)
whale_08<-psmc.result(file="17-08.psmc", g=50, mu=2.69e-08)
whale_10<-psmc.result(file="17-10.psmc", g=50, mu=2.69e-08)
whale_12<-psmc.result(file="17-12.psmc", g=50, mu=2.69e-08)
whale_17<-psmc.result(file="17-17.psmc", g=50, mu=2.69e-08)
whale_18<-psmc.result(file="17-18.psmc", g=50, mu=2.69e-08)
whale_19<-psmc.result(file="17-19.psmc", g=50, mu=2.69e-08)
whale_20<-psmc.result(file="17-20.psmc", g=50, mu=2.69e-08)
whale_21<-psmc.result(file="17-21.psmc", g=50, mu=2.69e-08)
whale_5<-psmc.result(file="18-05.psmc", g=50, mu=2.69e-08)
whale_6<-psmc.result(file="18-06.psmc", g=50, mu=2.69e-08)

whale_05$whale<-"whale_05"
whale_07$whale<-"whale_07"
whale_08$whale<-"whale_08"
whale_10$whale<-"whale_10"
whale_12$whale<-"whale_12"
whale_17$whale<-"whale_17"
whale_18$whale<-"whale_18"
whale_19$whale<-"whale_19"
whale_20$whale<-"whale_20"
whale_21$whale<-"whale_21"
whale_5$whale<-"whale_5"
whale_6$whale<-"whale_6"

all_whales<-rbind(whale_05, whale_07, whale_08,
                  whale_10, whale_12, whale_17,
                  whale_18, whale_19, whale_20, whale_21,
                  whale_5, whale_6)

library(tidyverse)
a <- ggplot(all_whales, aes(YearsAgo, Ne, colour = whale)) +  geom_line(linetype = "solid")
a <- a + ylim (0, 40000) + xlim(0,1500000)
a + theme_bw()




write.table(whale_05, file = "17-05.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_07, file = "17-07.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_08, file = "17-08.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_10, file = "17-10.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_12, file = "17-12.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_17, file = "17-17.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_18, file = "17-18.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_19, file = "19-05.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_20, file = "17-20.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_21, file = "17-21.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_5, file = "18-05.txt", sep = "\t", quote = FALSE, row.names = F)
write.table(whale_6, file = "18-06.txt", sep = "\t", quote = FALSE, row.names = F)

