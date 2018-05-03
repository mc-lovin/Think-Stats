source('helper.R')
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

# Since we don't expect this to be a uniform distribution because there are less no of records
random.distribution <- sample(1:100, 10000, replace=T)
cdf <- makeCDFFromData(random.distribution, 'value', 'freq')

print (ggplot() + geom_line(data=cdf, aes(value, freq), color='blue'))
savePlot('4_random_cdf.pdf')

print (ggplot() + geom_line(data=cdf, aes(value, log(1-freq)), color='red'))
savePlot('4_random_ccdf.pdf')