source('relay.R')
source('helper.R')

speeds <- fetchData()
plotData(speeds)

# Let us see how do the first babies vs the other babies weight
source('survey.r')
first.babies <- pregnancy %>% subset(birthord == 1)

# weight on these guys are discrete random variables, it should be a different probability
# distribution
first.babies = getPrettyFactors(first.babies$birthwgt_oz, 'weight', 'freq')
first.babies = makeCDF(first.babies, 'freq')

other.babies <- pregnancy %>% subset(birthord != 1)
other.babies = getPrettyFactors(other.babies$birthwgt_oz, 'weight', 'freq')
other.babies = makeCDF(other.babies, 'freq')

print (
  ggplot()
  + geom_line(data=first.babies, aes(weight, freq), color='red')
  + geom_line(data=other.babies, aes(weight, freq), color='blue')
  + ggtitle("Red: First Born, Blue: Others"))
savePlot('cdf-baby-weights.pdf')

# Generate random numbers b//w 1..100 and lets see there cdf ? Should look like a uniform distribution
random.distribution <- table(sample(1:100, 1000, replace=T))
random.distribution = getPrettyFactors(random.distribution, 'number', 'freq')
random.distribution = makeCDF(random.distribution, 'freq')
print (
  ggplot()
  + geom_line(data=random.distribution, aes(number, freq)))
savePlot('cdf-random-distribution.pdf')