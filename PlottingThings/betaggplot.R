#Load libraries
library(dplyr)
library(ggplot2)

#Read in the data
LOBdata <- read.csv("~/Desktop/LOBsetPos.csv")

names(LOBdata)

# Get rid of low-confidence compounds
##Make a new column with the sum of the first three "C" columns
ConfVals <- select(LOBdata, c(C1, C1x, C2a))
LOBRowSums <- rowSums(ConfVals)
LOBdata$ConfVals <- LOBRowSums


LOBdata <- filter(LOBdata, ConfVals==1)

sumLOBdata <- select(LOBdata, 12:29)
LOBRowSums <- rowSums(sumLOBdata)
LOBdata$HowMuch <- LOBRowSums

summarize(group_by(LOBdata, lipid_class), "ClassSum"=sum(HowMuch))

classLOBdata <- LOBdata %>% 
  group_by(., lipid_class, species) %>% 
  summarize(., "ClassSum"=sum(HowMuch))

barplot(classLOBdata$ClassSum)
barplot(classLOBdata$ClassSum, names.arg = classLOBdata$lipid_class, las=3)


ggplot() + 
  geom_bar(data = classLOBdata, 
           aes(x=species, y=ClassSum), stat = "identity") +
  facet_wrap(~lipid_class, scales = "free")


ggplot() + 
  geom_point(data=LOBdata, aes(x=peakgroup_rt, y=peakgroup_mz, color=species)) +
  facet_wrap(~lipid_class)


ggplot() +
  geom_point(data=classLOBdata, aes(x=peakgroup_rt, y=))