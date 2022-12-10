library(maps)
library(ggplot2)
library(pillar)
library(dplyr)

setwd("/Users/mryvi/Documents/Capstone")

votes2014 <- read.csv("2014RData.csv")
votes2019 <- read.csv("2019RData.csv")


#ECR 2014
ggplot(data=votes2014, aes(x=(ECRpredict - ECR.EFDD.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'dodgerblue3') +
  labs(title = 'ECR/EFDD Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#ECR 2019
ggplot(data=votes2019, aes(x=(ECRpredict - ECR.EFDD.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'dodgerblue3') +
  labs(title = 'ECR/ID Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#EPP 2014
ggplot(data=votes2014, aes(x=(EPPpredict - EPP.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'deepskyblue2') +
  labs(title = 'EPP Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
    theme(text = element_text(size = 20))

#EPP 2019
ggplot(data=votes2019, aes(x=(EPPpredict - EPP.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'deepskyblue2') +
  labs(title = 'EPP Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#ALDE 2014
ggplot(data=votes2014, aes(x=(ALDEpredict - ALDE.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'gold') +
  labs(title = 'ALDE Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#ALDE 2019
ggplot(data=votes2019, aes(x=(ALDEpredict - ALDE.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'gold') +
  labs(title = 'RE Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#Green 2014
ggplot(data=votes2014, aes(x=(Greenpredict - Greens.EFA.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'green3') +
  labs(title = 'Green Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#Green 2019
ggplot(data=votes2019, aes(x=(Greenpredict - Greens.EFA.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'green3') +
  labs(title = 'Green Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#SD 2014
ggplot(data=votes2014, aes(x=(SDpredict - S.D.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'firebrick1') +
  labs(title = 'S&D Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#SD 2019
ggplot(data=votes2019, aes(x=(SDpredict - S.D.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'firebrick1') +
  labs(title = 'S&D Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#GUE/NGL 2014
ggplot(data=votes2014, aes(x=(GUEpredict - GUE.NGL.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'darkred') +
  labs(title = 'GUE/NGL Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))

#GUE/NGL 2019
ggplot(data=votes2019, aes(x=(GUEpredict - GUE.NGL.2014), y=COUNTRY.)) +
  geom_bar(stat="identity", fill = 'darkred') +
  labs(title = 'GUE/NGL Residuals', x = 'Residual', y = 'Country') +
  theme_minimal() +
  theme(text = element_text(size = 20))
