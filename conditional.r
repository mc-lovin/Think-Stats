source('survey.r')
library(ggplot2)

getProbabilities = function(data, start, end) {
  count = table(data$prglength)
  count = count / nrow(data)
  probabilites = sapply(start:end, function(week) count[toString(week)])
  return (probabilites)
}

first.babies = getProbabilities(pregnancy %>% subset(birthord == 1), 35, 46)
other.babies = getProbabilities(pregnancy %>% subset(birthord != 1), 35, 46)
other.babies = other.babies[!is.na(other.babies)]

# Find a way to represent this data.
first.babies = as.data.frame(first.babies)
colnames(first.babies) = c("freq")
first.babies$week = as.integer(rownames(first.babies))
first.babies$freq = as.double(first.babies$freq)
rownames(first.babies) <- NULL

other.babies = as.data.frame(other.babies)
colnames(other.babies) = c("freq")
other.babies$week = as.integer(rownames(other.babies))
other.babies$freq = as.double(other.babies$freq)
rownames(other.babies) <- NULL

print (
  ggplot() 
  + geom_line(data=first.babies, aes(week, freq), color='red')
  + geom_line(data=other.babies, aes(week, freq), color='blue'))