source('survey.R')
library(dplyr)
library(ggplot2)

info <- function() {
  live.births = pregnancy %>% subset(outcome == 1)
  cat('Number of live births', nrow(live.births), '\n')
  
  first.born = live.births %>% subset(birthord == 1)
  other.born = live.births %>% subset(birthord != 1)
  
  cat('Number of first born live births', nrow(first.born), '\n')
  cat('Average Pregnancy time in hours', mean(first.born$prglength) * 7 * 24, '\n')
  cat('Variance Pregnancy time in hours', var(first.born$prglength) * 7 * 24, '\n')
  cat('TOP 5 Preganancy weeks')
  print (sort(table(first.born$prglength), decreasing = T)[1:5])
  
  cat('Number of secondary live births', nrow(other.born), '\n')
  cat('Average Pregnancy time in hours', mean(other.born$prglength) * 7 * 24, '\n')
  cat('Variance Pregnancy time in hours', var(other.born$prglength) * 7 * 24, '\n')
  cat('TOP 5 Preganancy weeks')
  print (sort(table(other.born$prglength), decreasing = T)[1:5])

  # PLOT GRAPH BETWEEN PREGNANCY LENGTHS
  preg.data <- rbind(data.frame(type='first', value=first.born$prglength),
              data.frame(type='other', value=other.born$prglength))
  print (ggplot(preg.data, aes(value, fill=type)) + geom_histogram(position = "dodge"))
}

info()