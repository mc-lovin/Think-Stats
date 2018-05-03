source('helper.R')
library(VGAM)

records = readLines('data/babyboom.dat')
times = c()
for (line in 1:length(records)) {
  record = records[line]
  record <- strsplit(record, ' ')[[1]]
  record <- record[record != '' & !is.na(as.numeric(record))]
  if (length(record) != 4) {
    next
  }
  times = c(times, as.integer(record[4]))
}

# Calculate interarrival times
times <- mutate(as.data.frame(times), times = times - lag(times))$times
times <- times[!is.na(times)]

cdf <- makeCDFFromData(times, 'time', 'freq')
print (ggplot() + geom_line(data=cdf, aes(time, freq), color='blue'))
savePlot('4_cdf.pdf')

print (ggplot() + geom_line(data=cdf, aes(time, log(1-freq)), color='red'))
savePlot('4_ccdf.pdf')

# Let us see how cdf and ccdf look like for random distributions
random.distribution <- sample(1:100, 10000, replace=T)
cdf <- makeCDFFromData(random.distribution, 'value', 'freq')

print (ggplot() + geom_line(data=cdf, aes(value, freq), color='blue'))
savePlot('4_random_cdf.pdf')

print (ggplot() + geom_line(data=cdf, aes(value, log(1-freq)), color='red'))
savePlot('4_random_ccdf.pdf')

# Pareto Distribution
# https://stackoverflow.com/questions/21792380/random-pareto-distribution-in-r-with-30-of-values-being-specified-amount

paretoDistribution <- function(noOfRecords, val, percentile)  {
  set.seed(1461)
  alpha <- 1  # For simplicity let us assume alpha to be 1
  k <- (1 - percentile) * (val) ^ (1/alpha)
  return (data.frame(
    no = rpareto(noOfRecords, k, alpha),
    density = dpareto(1:100, k, alpha)
  ))
}

pareto <- paretoDistribution(100, 40, 0.8)
print (ggplot(pareto, aes(x=no))
       + geom_histogram(color='black', aes(y=..density..), alpha=0)
       + geom_density(color='red'))