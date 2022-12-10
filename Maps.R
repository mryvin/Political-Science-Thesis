library(maps)
library(ggplot2)
library(pillar)
library(dplyr)

setwd("/Users/mryvi/Documents/Capstone")

eucountries <- map_data("world", region= c("Austria","Italy","France","Spain","Portugal","Ireland", "Luxembourg", "Belgium",
                                           "Netherlands", "Germany","Denmark","Czech Republic","Poland", 
                                           "Slovakia","Hungary","Slovenia","Croatia", "Sweden", "Finland","Latvia",
                                           "Estonia","Lithuania","Greece","Malta","Bulgaria","Romania",
                                           "UK","Cyprus"))

votes2014 <- read.csv("2014RData.csv")
votes2019 <- read.csv("2019RData.csv")

votes2014[votes2014$COUNTRY. == 'United Kingdom','COUNTRY.'] <- 'UK'
votes2014[votes2014$COUNTRY. == 'Czechia','COUNTRY.'] <- 'Czech Republic'
votes2019[votes2019$COUNTRY. == 'United Kingdom','COUNTRY.'] <- 'UK'
votes2019[votes2019$COUNTRY. == 'Czechia','COUNTRY.'] <- 'Czech Republic'

###############################################################################
#Adding the Votes
##############################################################################

#ECR 2014
ECRvote2014 <- data.frame(region = unique(votes2014$COUNTRY.),
                            ECRseats2014 = votes2014$ECR.EFDD.2014,
                          ECRpredicted = votes2014$ECRpredict)

eucountries <- left_join(eucountries,ECRvote2014,by="region")

#ECR 2019
ECRvote2019 <- data.frame(region = unique(votes2019$COUNTRY.),
                            ECRseats2019 = votes2019$ECR.EFDD.2014,
                          ECRpredicted2019 = votes2019$ECRpredict)

eucountries <- left_join(eucountries,ECRvote2019,by="region")

##################

#EPP 2014
EPPvote2014 <- data.frame(region = unique(votes2014$COUNTRY.),
                            EPPseats2014 = votes2014$EPP.2014,
                          EPPpredicted = votes2014$EPPpredict)

eucountries <- left_join(eucountries,EPPvote2014,by="region")

#EPP 2019
EPPvote2019 <- data.frame(region = unique(votes2019$COUNTRY.),
                            EPPseats2019 = votes2019$EPP.2014,
                          EPPpredicted2019 = votes2019$EPPpredict)

eucountries <- left_join(eucountries,EPPvote2019,by="region")

##################

#ALDE 2014
ALDEvote2014 <- data.frame(region = unique(votes2014$COUNTRY.),
                          ALDEseats2014 = votes2014$ALDE.2014,
                          ALDEpredicted = votes2014$ALDEpredict)

eucountries <- left_join(eucountries,ALDEvote2014,by="region")

#ALDE 2019
ALDEvote2019 <- data.frame(region = unique(votes2019$COUNTRY.),
                          ALDEseats2019 = votes2019$ALDE.2014,
                          ALDEpredicted2019 = votes2019$ALDEpredict)

eucountries <- left_join(eucountries,ALDEvote2019,by="region")

#################

#Green 2014
greenvote2014 <- data.frame(region = unique(votes2014$COUNTRY.),
                        greenseats2014 = votes2014$Greens.EFA.2014,
                        Greenpredicted = votes2014$Greenpredict)

eucountries <- left_join(eucountries,greenvote2014,by="region")

#Green 2019
greenvote2019 <- data.frame(region = unique(votes2019$COUNTRY.),
                            greenseats2019 = votes2019$Greens.EFA.2014,
                            Greenpredicted2019 = votes2019$Greenpredict)

eucountries <- left_join(eucountries,greenvote2019,by="region")

##################

#S.D 2014
S.Dvote2014 <- data.frame(region = unique(votes2014$COUNTRY.),
                          S.Dseats2014 = votes2014$S.D.2014,
                          S.Dpredicted = votes2014$SDpredict)

eucountries <- left_join(eucountries,S.Dvote2014,by="region")

#S.D 2019
S.Dvote2019 <- data.frame(region = unique(votes2019$COUNTRY.),
                          S.Dseats2019 = votes2019$S.D.2014,
                          S.Dpredicted2019 = votes2019$SDpredict)

eucountries <- left_join(eucountries,S.Dvote2019,by="region")

##################

#GUE 2014
GUEvote2014 <- data.frame(region = unique(votes2014$COUNTRY.),
                          GUEseats2014 = votes2014$GUE.NGL.2014,
                          GUEpredicted = votes2014$GUEpredict)

eucountries <- left_join(eucountries,GUEvote2014,by="region")

#GUE 2019
GUEvote2019 <- data.frame(region = unique(votes2019$COUNTRY.),
                          GUEseats2019 = votes2019$GUE.NGL.2014,
                          GUEpredicted2019 = votes2014$GUEpredict)

eucountries <- left_join(eucountries,GUEvote2019,by="region")

#############################################################
#Plots ACTUAL
#############################################################

#ECR 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ECRseats2014),
               colour="white")+
  scale_fill_gradient(name="ECR/EFDD Vote Share %", low="grey93", high="dodgerblue3",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election ECR/EFDD Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#ECR 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ECRseats2019),
               colour="white")+
  scale_fill_gradient(name="ECR/ID Vote Share %", low="grey93", high="dodgerblue3",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election ECR/ID Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################
##################

#EPP 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=EPPseats2014),
               colour="white")+
  scale_fill_gradient(name="EPP Vote Share %", low="grey93", high="deepskyblue2",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election EPP Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#EPP 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=EPPseats2019),
               colour="white")+
  scale_fill_gradient(name="EPP Seat Share %", low="grey93", high="deepskyblue2",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election EPP Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################
##################

#ALDE 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ALDEseats2014),
               colour="white")+
  scale_fill_gradient(name="ALDE Seat Share %", low="grey93", high="gold",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election ALDE Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#ALDE 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ALDEseats2019),
               colour="white")+
  scale_fill_gradient(name="RE Seat Share %", low="grey93", high="gold",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election RE Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################
##################

#Green 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=greenseats2014),
               colour="white")+
  scale_fill_gradient(name="Greens/EFA Seat Share %", low="grey93", high="green3",limits = c(0,0.3))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election Greens/EFA Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#Green 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=greenseats2019),
               colour="white")+
  scale_fill_gradient(name="Greens/EFA Seat Share %", low="grey93", high="green3",limits = c(0,0.4))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election Greens/EFA Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################
##################

#S.D 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=S.Dseats2014),
               colour="white")+
  scale_fill_gradient(name="S&D Seat Share %", low="grey93", high="firebrick1",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election S&D Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#S.D 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=S.Dseats2019),
               colour="white")+
  scale_fill_gradient(name="S&D Seat Share %", low="grey93", high="firebrick1",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election S&D Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################
##################

#GUE 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=GUEseats2014),
               colour="white")+
  scale_fill_gradient(name="GUE/NGL Seat Share %", low="grey93", high="darkred",limits = c(0,0.4))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election GUE/NGL Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#GUE 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=GUEseats2019),
               colour="white")+
  scale_fill_gradient(name="GUE/NGL Seat Share %", low="grey93", high="darkred",limits = c(0,0.4))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election GUE/NGL Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

















#############################################################
#Plots Predicted
#############################################################

#ECR 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ECRpredicted),
               colour="white")+
  scale_fill_gradient(name="ECR/EFDD Predicted Vote Share %", low="grey93", high="dodgerblue3",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election ECR/EFDD Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#ECR 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ECRpredicted2019),
               colour="white")+
  scale_fill_gradient(name="ECR/ID Predicted Vote Share %", low="grey93", high="dodgerblue3",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election ECR/ID Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#EPP 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=EPPpredicted),
               colour="white")+
  scale_fill_gradient(name="EPP Predicted Vote Share %", low="grey93", high="deepskyblue2",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election EPP Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#EPP 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=EPPpredicted2019),
               colour="white")+
  scale_fill_gradient(name="EPP Predicted Vote Share %", low="grey93", high="deepskyblue2",limits = c(0,0.6))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election EPP Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#ALDE 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ALDEpredicted),
               colour="white")+
  scale_fill_gradient(name="ALDE Predicted Vote Share %", low="grey93", high="gold",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election ALDE Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#RE 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=ALDEpredicted2019),
               colour="white")+
  scale_fill_gradient(name="RE Predicted Vote Share %", low="grey93", high="gold",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election RE Results by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#Green 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=Greenpredicted),
               colour="white")+
  scale_fill_gradient(name="Greens/EFA Predicted Vote Share %", low="grey93", high="green3",limits = c(0,0.3))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election Greens/EFA Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#Green 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=Greenpredicted2019),
               colour="white")+
  scale_fill_gradient(name="Greens/EFA Predicted Vote Share %", low="grey93", high="green3",limits = c(0,0.4))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election Greens/EFA Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#SD 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=S.Dpredicted),
               colour="white")+
  scale_fill_gradient(name="S&D Predicted Vote Share %", low="grey93", high="firebrick1",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election S&D Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#SD 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=S.Dpredicted2019),
               colour="white")+
  scale_fill_gradient(name="S&D Predicted Vote Share %", low="grey93", high="firebrick1",limits = c(0,0.5))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election S&D Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#GUE 2014
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=GUEpredicted),
               colour="white")+
  scale_fill_gradient(name="GUE/NGL Predicted Vote Share %", low="grey93", high="darkred",limits = c(0,0.4))+
  
  ## remove background
  theme_void()+
  ggtitle("2014 EU Parliament Election GUE/NGL Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################

#GUE 2019
ggplot()+
  
  geom_polygon(data=eucountries, aes(x=long, y=lat, 
                                     group=group, 
                                     fill=GUEpredicted2019),
               colour="white")+
  scale_fill_gradient(name="GUE/NGL Predicted Vote Share %", low="grey93", high="darkred",limits = c(0,0.4))+
  
  ## remove background
  theme_void()+
  ggtitle("2019 EU Parliament Election GUE/NGL Predicted by Country")+
  theme(plot.title = element_text(size=40),legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(5, 'cm'), #change legend key height
        legend.key.width = unit(2, 'cm'), #change legend key width
        legend.title = element_text(size=30), #change legend title font size
        legend.text = element_text(size=30)) +
  coord_quickmap()

##################