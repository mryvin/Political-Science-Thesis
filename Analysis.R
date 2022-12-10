setwd("/Users/mryvi/Documents/Capstone")

#install.packages("rockchalk")
#install.packages("texreg")
#install.packages("stargazer")

library(dplyr)
library(tidyverse)
library(caret)
library(leaps)
library(MASS)
library(ggplot2)
library(moderndive)
library(infer)
library(rockchalk)
library(texreg)
library(stargazer)

Odata <- read.csv("2014Data.csv")
colnames(Odata)
datawrite = Odata
data <- subset(Odata,select=-c(X, COUNTRY.,CODE.))

data2019 <- read.csv("2019Data.csv")
data2019write = data2019
data2019 <- subset(data2019,select=-c(X, COUNTRY.,CODE.))
colnames(data2019)

############################################################
# ECR
############################################################
ECRdata = subset(Odata,select=c(COUNTRY.))

for(i in 1:ncol(data)) {
  cat('\n',names(data[i]))
  model = lm(data$ECR.EFDD.2014 ~ data[ , i])
  cat('\np-value: ',summary(model)$coefficients[2,4],'\n')
  if(summary(model)$coefficients[2,4] < 0.25) {
    print('!!!!!!!!!!')
    ECRdata = cbind(ECRdata, data[i])
  }
}


ECRredata = subset(ECRdata,select=-c(COUNTRY.,EPP.2014,GUE.NGL.2014,Unknown.Immigration.Change.2013.2014))
ECRredata = ECRredata[ , apply(ECRredata, 2, function(x) !any(is.na(x)))]
ECRmodstart = lm(data$ECR.EFDD.2014 ~ 1, data = ECRredata)
ECRmod = lm(data$ECR.EFDD.2014 ~ ., data = ECRredata)
summary(ECRmodstart)
summary(ECRmod)

step(ECRmodstart, direction = 'forward', scope = formula(ECRmod))

# # Model with best predictive value
# ECRFinalmod = lm(formula = data$ECR.EFDD.2014 ~ log(X2014..Age.15.64.Education.Levels.0.2) + 
#                    log(X2014..Disagree.Country.Better.Off.if.Left.EU) + 
#                    #X2014..Age.25.49 +
#                    #X2014..Non.EU27.Immigration + #0.07405932  0.09297858    0.1059669     0.1456877
#                    X2013..Non.EU27.Immigration + #0.07374661  
#                    X2013..Total.Immigration + #0.07457719     0.07916634    
#                    #X2014..Total.Immigration + #0.07519883     0.08401859    0.08844838    0.1425835
#                    #X2013..EU27.Immigration + #0.07572195      0.08067745    0.1419704     0.152321
#                    X2014..EU27.Immigration #0.07569642        0.08373314    0.08428262    
#                  , data = data)
# Model with good R-squared (USE THIS MODEL)
ECRFinalmod = lm(formula = data$ECR.EFDD.2014 ~ log(X2014..Age.15.64.Education.Levels.0.2) + 
                   #log(X2014..Disagree.Country.Better.Off.if.Left.EU) + 
                   #X2014..Age.25.49 +
                   #X2014..Non.EU27.Immigration + #0.07405932  0.09297858    0.1059669     0.1456877
                   X2013..Non.EU27.Immigration + #0.07374661  
                   #X2013..Total.Immigration + #0.07457719     0.07916634    
                   X2014..Total.Immigration + #0.07519883     0.08401859    0.08844838    0.1425835
                   #X2013..EU27.Immigration + #0.07572195      0.08067745    0.1419704     0.152321
                   X2014..EU27.Immigration #0.07569642        0.08373314    0.08428262    
                 , data = data)

summary(ECRFinalmod)

ECRtest1 = predict(ECRFinalmod,data)
datawrite$ECRpredict = ECRtest1
(sum(abs(ECRtest1 - data$ECR.EFDD.2014),na.rm=TRUE))/27
(sum(ECRtest1 - data$ECR.EFDD.2014,na.rm=TRUE))/27

ECRtest2 = predict(ECRFinalmod,data2019)
data2019write$ECRpredict = ECRtest2
(sum(abs(ECRtest2 - data2019$ECR.EFDD.2014),na.rm=TRUE))/27
(sum(ECRtest2 - data2019$ECR.EFDD.2014,na.rm=TRUE))/27

ECRFakemod = lm(formula = data$ECR.EFDD.2014 ~ log(X2014..Age.15.64.Education.Levels.0.2), data = data)
summary(ECRFakemod)

############################################################
# EPP
############################################################
EPPdata = subset(Odata,select=c(COUNTRY.))

for(i in 1:ncol(data)) {
  cat('\n',names(data[i]))
  model = lm(data$EPP.2014 ~ data[ , i])
  cat('\np-value: ',summary(model)$coefficients[2,4],'\n')
  if(summary(model)$coefficients[2,4] < 0.25) {
    print('!!!!!!!!!!')
    EPPdata = cbind(EPPdata, data[i])
  }
}


EPPredata = subset(EPPdata,select=-c(COUNTRY.,ECR.EFDD.2014,ALDE.2014,Greens.EFA.2014,NI.Unknown.2014))
EPPredata = EPPredata[ , apply(EPPredata, 2, function(x) !any(is.na(x)))]
EPPmodstart = lm(data$EPP.2014 ~ 1, data = EPPredata)
EPPmod = lm(data$EPP.2014 ~ ., data = EPPredata)
summary(EPPmodstart)
summary(EPPmod)

step(EPPmodstart, direction = 'forward', scope = formula(EPPmod))
# X2014..Negative.EU.Opinion
# X2014..Personal..The.environment..climate.and.energy.issues..1
# X2014..Personal..The.environment..climate.and.energy.issues.
# X2014..Left.Political.Views
# X2014..Not.Satisfied.with.Life
# X2014..Satisfied.with.Life
# X2014..Non.EU27.Immigration
# X2013..Non.EU27.Immigration
# X2014..Age.55.64.Education.Levels.5.8
# X2014..Age.45.64.Education.Levels.5.8
# X2014..Age.45.54.Education.Levels.5.8
# X2014..Age.35.44.Education.Levels.5.8
# X2014..Age.30.34.Education.Levels.5.8
# X2014..Age.25.64.Education.Levels.5.8
# X2014..Age.25.34.Education.Levels.5.8
# X2014..Age.15.64.Education.Levels.5.8
# X2014..Age.80.
# X2014..Age.25.49
# X2014..Age.0.14

# # Option 1
# EPPFinalmod = lm(formula = data$EPP.2014 ~ X2014..Age.35.44.Education.Levels.5.8 + 
#                    X2014..Age.45.64.Education.Levels.5.8 +
#                    X2013..Non.EU27.Immigration + X2014..Non.EU27.Immigration + 
#                    log(X2014..Age.0.14)
#                  , data = data)

# Option 2 (USE THIS MODEL)
EPPFinalmod = lm(formula = data$EPP.2014 ~ X2014..Age.55.64.Education.Levels.5.8 + 
                   X2013..Non.EU27.Immigration + X2014..Non.EU27.Immigration + 
                   log(X2014..Age.25.49) + 
                   X2014..Negative.EU.Opinion
                 , data = data)

summary(EPPFinalmod)

EPPtest1 = predict(EPPFinalmod,data)
datawrite$EPPpredict = EPPtest1
(sum(abs(EPPtest1 - data$EPP.2014),na.rm=TRUE))/27
(sum(EPPtest1 - data$EPP.2014,na.rm=TRUE))/27

EPPtest2 = predict(EPPFinalmod,data2019)
data2019write$EPPpredict = EPPtest2
(sum(abs(EPPtest2 - data2019$EPP.2014),na.rm=TRUE))/27
(sum(EPPtest2 - data2019$EPP.2014,na.rm=TRUE))/27


############################################################
# ALDE
############################################################
ALDEdata = subset(Odata,select=c(COUNTRY.))

for(i in 1:ncol(data)) {
  cat('\n',names(data[i]))
  model = lm(data$ALDE.2014 ~ data[ , i])
  cat('\np-value: ',summary(model)$coefficients[2,4],'\n')
  if(summary(model)$coefficients[2,4] < 0.25) {
    print('!!!!!!!!!!')
    ALDEdata = cbind(ALDEdata, data[i])
  }
}


ALDEredata = subset(ALDEdata,select=-c(COUNTRY.,EPP.2014,S.D.2014,Greens.EFA.2014,NI.Unknown.2014,Unknown.Immigration.Change.2013.2014))
ALDEredata = ALDEredata[ , apply(ALDEredata, 2, function(x) !any(is.na(x)))]
ALDEmodstart = lm(data$ALDE.2014 ~ 1, data = ALDEredata)
ALDEmod = lm(data$ALDE.2014 ~ ., data = ALDEredata)
summary(ALDEmodstart)
summary(ALDEmod)

step(ALDEmodstart, direction = 'forward', scope = formula(ALDEmod))

#USE THIS MODEL
ALDEFinalmod = lm(formula = data$ALDE.2014 ~ X2014..Age.55.64.Education.Levels.5.8 + 
                    X2014..Negative.EU.Opinion + 
                    X2014..Disagree.Country.Better.Off.if.Left.EU + 
                    Non.EU27.Immigration.Change.2013.2014 + 
                    X2014..Satisfied.with.Life + 
                    X2014..Age.25.49
                  , data = data)


summary(ALDEFinalmod)

ALDEtest1 = predict(ALDEFinalmod,data)
datawrite$ALDEpredict = ALDEtest1
(sum(abs(ALDEtest1 - data$ALDE.2014),na.rm=TRUE))/27
(sum(ALDEtest1 - data$ALDE.2014,na.rm=TRUE))/27

ALDEtest2 = predict(ALDEFinalmod,data2019)
data2019write$ALDEpredict = ALDEtest2
(sum(abs(ALDEtest2 - data2019$ALDE.2014),na.rm=TRUE))/27
(sum(ALDEtest2 - data2019$ALDE.2014,na.rm=TRUE))/27


############################################################
# Green
############################################################
Greendata = subset(Odata,select=c(COUNTRY.))

for(i in 1:ncol(data)) {
  cat('\n',names(data[i]))
  model = lm(data$Greens.EFA.2014 ~ data[ , i])
  cat('\np-value: ',summary(model)$coefficients[2,4],'\n')
  if(summary(model)$coefficients[2,4] < 0.25) {
    print('!!!!!!!!!!')
    Greendata = cbind(Greendata, data[i])
  }
}


Greenredata = subset(Greendata,select=-c(COUNTRY.,EPP.2014,S.D.2014,ALDE.2014,GUE.NGL.2014,Unknown.Immigration.Change.2013.2014))
Greenredata = Greenredata[ , apply(Greenredata, 2, function(x) !any(is.na(x)))]
Greenmodstart = lm(data$Greens.EFA.2014 ~ 1, data = Greenredata)
Greenmod = lm(data$Greens.EFA.2014 ~ ., data = Greenredata)
summary(Greenmodstart)
summary(Greenmod)

step(Greenmodstart, direction = 'forward', scope = formula(Greenmod))
#X2014..Disagree.Country.Better.Off.if.Left.EU
#X2014..EU..Climate.change
#X2014..EU..The.environment
#X2014..Personal..The.environment..climate.and.energy.issues.
#X2014..Left.Political.Views
#X2014..Yes.Feel.Like.EU.Citizen
#X2014..Satisfied.with.Life
#X2014..Foreign.country.Immigration..Percent.of.Total.Population.
#X2014..EU28.Immigration..Percent.of.Total.Population.
#X2014..EU28.Immigration..Percent.of.Total.Population.
#X2014..EU27.Immigration..Percent.of.Total.Population.
#X2014..Age.55.64.Education.Levels.5.8
#X2014..Age.45.64.Education.Levels.5.8
#X2014..Age.45.54.Education.Levels.5.8
#X2014..Age.35.44.Education.Levels.5.8
#X2014..Age.35.44.Education.Levels.0.2
#X2014..Age.30.34.Education.Levels.5.8
#X2014..Age.30.34.Education.Levels.0.2
#X2014..Age.25.64.Education.Levels.5.8
#X2014..Age.25.34.Education.Levels.5.8
#X2014..Age.15.64.Education.Levels.5.8
#X2014..Age.25.49
#X2014.GDP..PPP..International.Dollars
#X2013.GDP..PPP..International.Dollars

#USE THIS MODEL
GreenFinalmod = lm(formula = data$Greens.EFA.2014 ~ #X2014..Disagree.Country.Better.Off.if.Left.EU +
                     X2014..EU..Climate.change +
                     #X2014..EU..The.environment+
                     #X2014..Personal..The.environment..climate.and.energy.issues.+
                     #X2014..Left.Political.Views+
                     #X2014..Yes.Feel.Like.EU.Citizen+
                     #X2014..Satisfied.with.Life+
                     #X2014..Foreign.country.Immigration..Percent.of.Total.Population.+
                     X2014..EU28.Immigration..Percent.of.Total.Population.+
                     X2014..Age.55.64.Education.Levels.5.8+
                   X2014..Age.45.64.Education.Levels.5.8+
                   X2014..Age.45.54.Education.Levels.5.8+
                   X2014..Age.35.44.Education.Levels.5.8+
                   X2014..Age.35.44.Education.Levels.0.2+
                   X2014..Age.25.64.Education.Levels.5.8#+
                   #X2014..Age.25.49+
                   #X2014.GDP..PPP..International.Dollars+
                   #X2013.GDP..PPP..International.Dollars
                   , data = data)


summary(GreenFinalmod)

Greentest1 = predict(GreenFinalmod,data)
datawrite$Greenpredict = Greentest1
(sum(abs(Greentest1 - data$Greens.EFA.2014),na.rm=TRUE))/22
(sum(Greentest1 - data$Greens.EFA.2014,na.rm=TRUE))/22

Greentest2 = predict(GreenFinalmod,data2019)
data2019write$Greenpredict = Greentest2
(sum(abs(Greentest2 - data2019$Greens.EFA.2014),na.rm=TRUE))/24
(sum(Greentest2 - data2019$Greens.EFA.2014,na.rm=TRUE))/24


############################################################
# SD
############################################################
SDdata = subset(Odata,select=c(COUNTRY.))

for(i in 1:ncol(data)) {
  cat('\n',names(data[i]))
  model = lm(data$S.D.2014 ~ data[ , i])
  cat('\np-value: ',summary(model)$coefficients[2,4],'\n')
  if(summary(model)$coefficients[2,4] < 0.25) {
    print('!!!!!!!!!!')
    SDdata = cbind(SDdata, data[i])
  }
}
#X2014..Right.Political.Views *
#

SDredata = subset(SDdata,select=-c(COUNTRY.,NI.Unknown.2014,Greens.EFA.2014,ALDE.2014,GUE.NGL.2014))
SDredata = SDredata[ , apply(SDredata, 2, function(x) !any(is.na(x)))]
SDmodstart = lm(data$S.D.2014 ~ 1, data = SDredata)
SDmod = lm(data$S.D.2014 ~ ., data = SDredata)
summary(SDmodstart)
summary(SDmod)

step(SDmodstart, direction = 'forward', scope = formula(SDmod))

#USE THIS MODEL
SDFinalmod = lm(formula = data$S.D.2014 ~ X2014..Age.30.34.Education.Levels.0.2 + 
                  X2014..Age.15.64.Education.Levels.3.4 + X2014..Right.Political.Views, 
                data = SDredata)


# SDFinalmod = lm(formula = data$S.D.2014 ~ #X2014..Age.30.34.Education.Levels.0.2 + 
#                   X2014..Age.15.64.Education.Levels.3.4 + 
#                   #X2014..Right.Political.Views +
#                   #X2014..Age.0.14 +
#                   X2014..Age.15.64.Education.Levels.0.2 +
#                   X2014..Age.15.64.Education.Levels.5.8 +
#                   X2014..Age.25.34.Education.Levels.0.2 +
#                   X2014..Age.25.64.Education.Levels.0.2 +
#                   X2014..Age.25.64.Education.Levels.5.8 +
#                   #X2014..Age.30.34.Education.Levels.5.8 +
#                   X2014..Age.35.44.Education.Levels.0.2 +
#                   X2014..Age.35.44.Education.Levels.5.8 +
#                   X2014..Age.45.54.Education.Levels.0.2 +
#                   #X2014..Age.45.64.Education.Levels.0.2 +
#                   #X2014..Age.45.64.Education.Levels.5.8 +
#                   #X2014..Age.55.64.Education.Levels.0.2 +
#                   X2014..Age.55.64.Education.Levels.3.4 +
#                   X2014..Age.55.64.Education.Levels.5.8
#                 , data = SDredata)


summary(SDFinalmod)

SDtest1 = predict(SDFinalmod,data)
datawrite$SDpredict = SDtest1
(sum(abs(SDtest1 - data$S.D.2014),na.rm=TRUE))/28
(sum(SDtest1 - data$S.D.2014,na.rm=TRUE))/28

SDtest2 = predict(SDFinalmod,data2019)
data2019write$SDpredict = SDtest2
(sum(abs(SDtest2 - data2019$S.D.2014),na.rm=TRUE))/28
(sum(SDtest2 - data2019$S.D.2014,na.rm=TRUE))/28


############################################################
# GUE.NGL
############################################################
GUE.NGLdata = subset(Odata,select=c(COUNTRY.))

for(i in 1:ncol(data)) {
  cat('\n',names(data[i]))
  model = lm(data$GUE.NGL.2014 ~ data[ , i])
  cat('\np-value: ',summary(model)$coefficients[2,4],'\n')
  if(summary(model)$coefficients[2,4] < 0.2) {
    print('!!!!!!!!!!')
    GUE.NGLdata = cbind(GUE.NGLdata, data[i])
  }
}


GUE.NGLredata = subset(GUE.NGLdata,select=-c(COUNTRY.,ECR.EFDD.2014,X2014..EU..Energy.supply.1 ))
GUE.NGLredata = GUE.NGLredata[ , apply(GUE.NGLredata, 2, function(x) !any(is.na(x)))]
GUE.NGLmodstart = lm(data$GUE.NGL.2014 ~ 1, data = GUE.NGLredata)
GUE.NGLmod = lm(data$GUE.NGL.2014 ~ ., data = GUE.NGLredata)
summary(GUE.NGLmodstart)
summary(GUE.NGLmod)

step(GUE.NGLmodstart, direction = 'forward', scope = formula(GUE.NGLmod))
#X2014..Negative.EU.Opinion
#X2014..Positive.EU.Opinion
#X2014..EU..Energy.supply
#X2014..Age.55.64.Education.Levels.3.4
#X2014..Age.55.64.Education.Levels.0.2
#X2014..Age.45.64.Education.Levels.3.4
#X2014..Age.45.64.Education.Levels.0.2
#X2014..Age.45.54.Education.Levels.3.4
#X2014..Age.45.54.Education.Levels.0.2
#X2014..Age.25.64.Education.Levels.3.4
#X2014..Age.25.64.Education.Levels.0.2
#X2014..Age.25.34.Education.Levels.3.4
#X2014..Age.15.64.Education.Levels.3.4
#X2014..Age.50.64
#X2014..Age.0.14

# GUE.NGLFinalmod = lm(formula = data$GUE.NGL.2014 ~ X2014..Age.50.64 + X2014..EU..Energy.supply, 
#                      data = data)

#USE THIS MODEL
GUE.NGLFinalmod = lm(formula = data$GUE.NGL.2014 ~ #X2014..Negative.EU.Opinion +
                       #X2014..Positive.EU.Opinion+
                       #X2014..EU..Energy.supply+
                       X2014..Age.55.64.Education.Levels.3.4+
                       #X2014..Age.55.64.Education.Levels.0.2+
                       #X2014..Age.45.64.Education.Levels.3.4+
                       X2014..Age.45.64.Education.Levels.0.2+
                       X2014..Age.45.54.Education.Levels.3.4+
                       #X2014..Age.45.54.Education.Levels.0.2+
                       X2014..Age.25.64.Education.Levels.3.4+
                       X2014..Age.25.64.Education.Levels.0.2+
                       X2014..Age.25.34.Education.Levels.3.4+
                     X2014..Age.15.64.Education.Levels.3.4#+
                     #X2014..Age.50.64+
                     #X2014..Age.0.14
                     , data = data)


summary(GUE.NGLFinalmod)

GUE.NGLtest1 = predict(GUE.NGLFinalmod,data)
datawrite$GUEpredict = GUE.NGLtest1
(sum(abs(GUE.NGLtest1 - data$GUE.NGL.2014),na.rm=TRUE))/28
(sum(GUE.NGLtest1 - data$GUE.NGL.2014,na.rm=TRUE))/28

GUE.NGLtest2 = predict(GUE.NGLFinalmod,data2019)
data2019write$GUEpredict = GUE.NGLtest2
(sum(abs(GUE.NGLtest2 - data2019$GUE.NGL.2014),na.rm=TRUE))/28
(sum(GUE.NGLtest2 - data2019$GUE.NGL.2014,na.rm=TRUE))/28


######################################
write.csv(datawrite,"/Users/mryvi/Documents/Capstone/2014RData.csv", row.names = FALSE)
write.csv(data2019write,"/Users/mryvi/Documents/Capstone/2019RData.csv", row.names = FALSE)
