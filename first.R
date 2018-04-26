source('survey.R')
library(dplyr)

info <- function() {
  live.births = pregnancy %>% subset(outcome == 1)
  cat('Number of live births', nrow(live.births), '\n')
  
  first.born = live.births %>% subset(birthord == 1)
  other.born = live.births %>% subset(birthord != 1)
  
  cat('Number of first born live births', nrow(first.born), '\n')
  cat('First born average pregnancy time', mean(first.born$prglength), '\n')
  
  cat('Number of non first live births', nrow(other.born), '\n')
  cat('Non first child average pregnancy time', mean(other.born$prglength), '\n')
}

info()