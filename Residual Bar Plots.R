library(maps)
library(ggplot2)
library(pillar)
library(dplyr)

setwd()

votes2014 <- read.csv("2014RData.csv")
votes2019 <- read.csv("2019RData.csv")

# Define a function to create the plots
create_plot <- function(data, predict_col, actual_col, title, fill_color) {
  ggplot(data, aes_string(x = paste0("(", predict_col, " - ", actual_col, ")"), y = "COUNTRY.")) +
    geom_bar(stat = "identity", fill = fill_color) +
    labs(title = title, x = 'Residual', y = 'Country') +
    theme_minimal() +
    theme(text = element_text(size = 20))
}

# Create plots for each year and party
parties <- list("ECR" = "dodgerblue3", "EPP" = "deepskyblue2", "ALDE" = "gold", "Green" = "green3", "SD" = "firebrick1", "GUE" = "darkred")
years <- list("2014" = votes2014, "2019" = votes2019)

for (year in names(years)) {
  for (party in names(parties)) {
    print(create_plot(years[[year]], paste0(party, "predict"), paste0(party, ".", year), paste0(party, " Residuals"), parties[[party]]))
  }
}
