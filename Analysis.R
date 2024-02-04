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

setwd()

# Read and clean 2014 data
Odata <- read.csv("2014Data.csv")
data <- Odata %>% select(-c(X, COUNTRY.,CODE.))

# Read and clean 2019 data
data2019 <- read.csv("2019Data.csv")
data2019 <- data2019 %>% select(-c(X, COUNTRY.,CODE.))

# Print column names
print(colnames(Odata))
print(colnames(data2019))


########################################################################################################################################
###### ECR
########################################################################################################################################
ECRdata <- Odata %>% select(COUNTRY.)

for(i in 1:ncol(data)) {
  model <- lm(ECR.EFDD.2014 ~ .[ , i], data = data)
  if(summary(model)$coefficients[2,4] < 0.25) {
    ECRdata <- cbind(ECRdata, data[ , i])
  }
}

ECRredata <- ECRdata %>% 
  select(-c(COUNTRY.,EPP.2014,GUE.NGL.2014,Unknown.Immigration.Change.2013.2014)) %>% 
  select_if(~!any(is.na(.)))

ECRmodstart <- lm(ECR.EFDD.2014 ~ 1, data = ECRredata)
ECRmod <- lm(ECR.EFDD.2014 ~ ., data = ECRredata)

step(ECRmodstart, direction = 'forward', scope = formula(ECRmod))

### Model with best predictive value
################################################

# ECRFinalmod = lm(formula = data$ECR.EFDD.2014 ~ log(X2014..Age.15.64.Education.Levels.0.2) + 
#                    log(X2014..Disagree.Country.Better.Off.if.Left.EU) + 
#                    X2014..Age.25.49 +
#                    X2014..Non.EU27.Immigration +
#                    X2013..Non.EU27.Immigration + 
#                    X2013..Total.Immigration + 
#                    X2014..Total.Immigration +
#                    X2013..EU27.Immigration +
#                    X2014..EU27.Immigration
#                  , data = data)

### Model with good R-squared (USE THIS MODEL)
################################################

ECRFinalmod <- lm(formula = ECR.EFDD.2014 ~ log(X2014..Age.15.64.Education.Levels.0.2) + 
                   X2013..Non.EU27.Immigration + 
                   X2014..Total.Immigration + 
                   X2014..EU27.Immigration, 
                 data = data)

summary(ECRFinalmod)

ECRtest1 = predict(ECRFinalmod,data)
datawrite$ECRpredict = ECRtest1

ECRtest2 = predict(ECRFinalmod,data2019)
data2019write$ECRpredict = ECRtest2


########################################################################################################################################
###### EPP
########################################################################################################################################
EPPdata <- Odata %>% select(COUNTRY.)

for(i in 1:ncol(data)) {
  model <- lm(EPP.2014 ~ .[ , i], data = data)
  if(summary(model)$coefficients[2,4] < 0.25) {
    EPPdata <- cbind(EPPdata, data[ , i])
  }
}

EPPredata <- EPPdata %>% 
  select(-c(COUNTRY.,ECR.EFDD.2014,ALDE.2014,Greens.EFA.2014,NI.Unknown.2014)) %>% 
  select_if(~!any(is.na(.)))

EPPmodstart <- lm(EPP.2014 ~ 1, data = EPPredata)
EPPmod <- lm(EPP.2014 ~ ., data = EPPredata)

step(EPPmodstart, direction = 'forward', scope = formula(EPPmod))

### Option 1
################################################

# EPPFinalmod = lm(formula = data$EPP.2014 ~ X2014..Age.35.44.Education.Levels.5.8 + 
#                    X2014..Age.45.64.Education.Levels.5.8 +
#                    X2013..Non.EU27.Immigration + X2014..Non.EU27.Immigration + 
#                    log(X2014..Age.0.14)
#                  , data = data)

### Option 2 (USE THIS MODEL)
################################################

EPPFinalmod = lm(formula = data$EPP.2014 ~ X2014..Age.55.64.Education.Levels.5.8 + 
                   X2013..Non.EU27.Immigration + X2014..Non.EU27.Immigration + 
                   log(X2014..Age.25.49) + 
                   X2014..Negative.EU.Opinion
                 , data = data)

summary(EPPFinalmod)

EPPtest1 = predict(EPPFinalmod,data)
datawrite$EPPpredict = EPPtest1

EPPtest2 = predict(EPPFinalmod,data2019)
data2019write$EPPpredict = EPPtest2


########################################################################################################################################
###### ALDE
########################################################################################################################################
ALDEdata <- Odata %>% select(COUNTRY.)

for(i in 1:ncol(data)) {
  model <- lm(ALDE.2014 ~ .[ , i], data = data)
  if(summary(model)$coefficients[2,4] < 0.25) {
    ALDEdata <- cbind(ALDEdata, data[ , i])
  }
}

ALDEredata <- ALDEdata %>% 
  select(-c(COUNTRY.,EPP.2014,S.D.2014,Greens.EFA.2014,NI.Unknown.2014,Unknown.Immigration.Change.2013.2014)) %>% 
  select_if(~!any(is.na(.)))

ALDEmodstart <- lm(ALDE.2014 ~ 1, data = ALDEredata)
ALDEmod <- lm(ALDE.2014 ~ ., data = ALDEredata)

step(ALDEmodstart, direction = 'forward', scope = formula(ALDEmod))

### USE THIS MODEL
################################################

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

ALDEtest2 = predict(ALDEFinalmod,data2019)
data2019write$ALDEpredict = ALDEtest2


########################################################################################################################################
###### Green
########################################################################################################################################
Greendata <- Odata %>% select(COUNTRY.)

for(i in 1:ncol(data)) {
  model <- lm(Greens.EFA.2014 ~ .[ , i], data = data)
  if(summary(model)$coefficients[2,4] < 0.25) {
    Greendata <- cbind(Greendata, data[ , i])
  }
}

Greenredata <- Greendata %>% 
  select(-c(COUNTRY.,EPP.2014,S.D.2014,ALDE.2014,GUE.NGL.2014,Unknown.Immigration.Change.2013.2014)) %>% 
  select_if(~!any(is.na(.)))

Greenmodstart <- lm(Greens.EFA.2014 ~ 1, data = Greenredata)
Greenmod <- lm(Greens.EFA.2014 ~ ., data = Greenredata)

step(Greenmodstart, direction = 'forward', scope = formula(Greenmod))

### USE THIS MODEL
################################################

GreenFinalmod = lm(formula = data$Greens.EFA.2014 ~ X2014..EU..Climate.change +
                     X2014..EU28.Immigration..Percent.of.Total.Population.+
                     X2014..Age.55.64.Education.Levels.5.8+
                   X2014..Age.45.64.Education.Levels.5.8+
                   X2014..Age.45.54.Education.Levels.5.8+
                   X2014..Age.35.44.Education.Levels.5.8+
                   X2014..Age.35.44.Education.Levels.0.2+
                   X2014..Age.25.64.Education.Levels.5.8
                   , data = data)

summary(GreenFinalmod)

Greentest1 = predict(GreenFinalmod,data)
datawrite$Greenpredict = Greentest1

Greentest2 = predict(GreenFinalmod,data2019)
data2019write$Greenpredict = Greentest2


########################################################################################################################################
###### SD
########################################################################################################################################
SDdata <- Odata %>% select(COUNTRY.)

for(i in 1:ncol(data)) {
  model <- lm(S.D.2014 ~ .[ , i], data = data)
  if(summary(model)$coefficients[2,4] < 0.25) {
    SDdata <- cbind(SDdata, data[ , i])
  }
}

SDredata <- SDdata %>% 
  select(-c(COUNTRY.,NI.Unknown.2014,Greens.EFA.2014,ALDE.2014,GUE.NGL.2014)) %>% 
  select_if(~!any(is.na(.)))

SDmodstart <- lm(S.D.2014 ~ 1, data = SDredata)
SDmod <- lm(S.D.2014 ~ ., data = SDredata)

step(SDmodstart, direction = 'forward', scope = formula(SDmod))

### Stepwise Model
################################################

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

### USE THIS MODEL
################################################

SDFinalmod = lm(formula = data$S.D.2014 ~ X2014..Age.30.34.Education.Levels.0.2 + 
                  X2014..Age.15.64.Education.Levels.3.4 + X2014..Right.Political.Views, 
                data = SDredata)

summary(SDFinalmod)

SDtest1 = predict(SDFinalmod,data)
datawrite$SDpredict = SDtest1

SDtest2 = predict(SDFinalmod,data2019)
data2019write$SDpredict = SDtest2


########################################################################################################################################
###### GUE.NGL
########################################################################################################################################
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

### Stepwise Model
################################################
                                       
# GUE.NGLFinalmod = lm(formula = data$GUE.NGL.2014 ~ X2014..Age.50.64 + X2014..EU..Energy.supply, 
#                      data = data)

### USE THIS MODEL
################################################
                                       
GUE.NGLFinalmod = lm(formula = data$GUE.NGL.2014 ~ X2014..Age.55.64.Education.Levels.3.4+
                       X2014..Age.45.64.Education.Levels.0.2+
                       X2014..Age.45.54.Education.Levels.3.4+
                       X2014..Age.25.64.Education.Levels.3.4+
                       X2014..Age.25.64.Education.Levels.0.2+
                       X2014..Age.25.34.Education.Levels.3.4+
                     X2014..Age.15.64.Education.Levels.3.4#+
                     , data = data)

summary(GUE.NGLFinalmod)

GUE.NGLtest1 = predict(GUE.NGLFinalmod,data)
datawrite$GUEpredict = GUE.NGLtest1

GUE.NGLtest2 = predict(GUE.NGLFinalmod,data2019)
data2019write$GUEpredict = GUE.NGLtest2

########################################################################################################################################
###### Export the Data
########################################################################################################################################
                                       
write.csv(datawrite,"/Users/mryvi/Documents/Capstone/2014RData.csv", row.names = FALSE)
write.csv(data2019write,"/Users/mryvi/Documents/Capstone/2019RData.csv", row.names = FALSE)
