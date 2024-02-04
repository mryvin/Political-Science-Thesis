library(maps)
library(ggplot2)
library(pillar)
library(dplyr)

# Set working directory
setwd()

# Define EU countries
eucountries <- map_data("world", region= c("Austria","Italy","France","Spain","Portugal","Ireland", 
                                            "Luxembourg", "Belgium","Netherlands", "Germany","Denmark",
                                            "Czech Republic","Poland", "Slovakia","Hungary","Slovenia",
                                            "Croatia", "Sweden", "Finland","Latvia","Estonia","Lithuania",
                                            "Greece","Malta","Bulgaria","Romania","UK","Cyprus"))

# Read data
votes2014 <- read.csv("2014RData.csv")
votes2019 <- read.csv("2019RData.csv")

# Clean data
votes2014$COUNTRY.[votes2014$COUNTRY. == 'United Kingdom'] <- 'UK'
votes2014$COUNTRY.[votes2014$COUNTRY. == 'Czechia'] <- 'Czech Republic'
votes2019$COUNTRY.[votes2019$COUNTRY. == 'United Kingdom'] <- 'UK'
votes2019$COUNTRY.[votes2019$COUNTRY. == 'Czechia'] <- 'Czech Republic'

##################################################################################################################################
##### Adding the Votes
##################################################################################################################################

# Define a function to create a data frame and join it with eucountries
join_votes <- function(votes, year, parties) {
  for (party in parties) {
    vote <- data.frame(region = unique(votes$COUNTRY.),
                       seats = votes[[paste0(party, ".", year)]],
                       predicted = votes[[paste0(party, "predict")]])
    names(vote)[2:3] <- paste0(party, c("seats", "predicted"), year)
    eucountries <<- left_join(eucountries, vote, by="region")
  }
}

# Parties to consider
parties <- c("ECR", "EPP", "ALDE", "Green", "S.D", "GUE")

# Join 2014 votes
join_votes(votes2014, "2014", parties)

# Join 2019 votes
join_votes(votes2019, "2019", parties)


##################################################################################################################################
##### Maps of Actual Vote Share
##################################################################################################################################

# Define a function to create a ggplot for each party and year
create_plot <- function(party, year, color) {
  ggplot() +
    geom_polygon(data = eucountries, 
                 aes(x = long, y = lat, group = group, fill = get(paste0(party, "seats", year))),
                 colour = "white") +
    scale_fill_gradient(name = paste0(party, " Vote Share %"), low = "grey93", high = color, limits = c(0, 0.6)) +
    theme_void() +
    ggtitle(paste0(year, " EU Parliament Election ", party, " Results by Country")) +
    theme(plot.title = element_text(size = 40),
          legend.key.size = unit(1, 'cm'),
          legend.key.height = unit(5, 'cm'),
          legend.key.width = unit(2, 'cm'),
          legend.title = element_text(size = 30),
          legend.text = element_text(size = 30)) +
    coord_quickmap()
}

# Parties to consider
parties <- c("ECR", "EPP", "ALDE", "Green", "S.D", "GUE")

# Years to consider
years <- c("2014", "2019")

# Colors for each party
colors <- c("dodgerblue3", "deepskyblue2", "gold", "green3", "firebrick1", "darkred")

# Create a ggplot for each party and year
for (i in seq_along(parties)) {
  for (year in years) {
    print(create_plot(parties[i], year, colors[i]))
  }
}


##################################################################################################################################
##### Maps of Predicted Vote Share
##################################################################################################################################

# Define a function to create a ggplot for each party and year
create_plot <- function(party, year, color) {
  ggplot() +
    geom_polygon(data = eucountries, 
                 aes(x = long, y = lat, group = group, fill = get(paste0(party, "predicted", year))),
                 colour = "white") +
    scale_fill_gradient(name = paste0(party, " Predicted Vote Share %"), low = "grey93", high = color, limits = c(0, 0.6)) +
    theme_void() +
    ggtitle(paste0(year, " EU Parliament Election ", party, " Predicted by Country")) +
    theme(plot.title = element_text(size = 40),
          legend.key.size = unit(1, 'cm'),
          legend.key.height = unit(5, 'cm'),
          legend.key.width = unit(2, 'cm'),
          legend.title = element_text(size = 30),
          legend.text = element_text(size = 30)) +
    coord_quickmap()
}

# Parties to consider
parties <- c("ECR", "EPP", "ALDE", "Green", "S.D", "GUE")

# Years to consider
years <- c("2014", "2019")

# Colors for each party
colors <- c("dodgerblue3", "deepskyblue2", "gold", "green3", "firebrick1", "darkred")

# Create a ggplot for each party and year
for (i in seq_along(parties)) {
  for (year in years) {
    print(create_plot(parties[i], year, colors[i]))
  }
}
