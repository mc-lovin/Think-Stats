source('relay.R')
speeds <- fetchData()
plotData(speeds)

# Let us see how do the first babies vs the other babies weight
source('survey.r')
first.babies <- pregnancy %>% subset(birthord == 1)

# weight on these guys are discrete random variables, it should be a different probability
# distribution
first.babies.weights <- table(first.babies$birthwgt_oz)
first.babies.weights <- first.babies.weight[-1]

first.babies <- data.frame(
  weights = as.numeric(rownames(first.babies.weights)),
  freq = cumsum(first.babies.weights / sum(first.babies.weights))
)

other.babies <- pregnancy %>% subset(birthord != 1)

# weight on these guys are discrete random variables, it should be a different probability
# distribution
other.babies.weights <- table(other.babies$birthwgt_oz)
other.babies.weights <- other.babies.weights[-1]

other.babies <- data.frame(
  weights = as.numeric(rownames(other.babies.weights)),
  freq = cumsum(other.babies.weights / sum(other.babies.weights))
)

print (
  ggplot()
  + geom_line(data=first.babies, aes(weights, freq), color='red')
  + geom_line(data=other.babies, aes(weights, freq), color='blue')
  + ggtitle("Red: First Born, Blue: Others"))
