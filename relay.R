library(stringr)

fetchData <- function() {
  url <- 'http://www.coolrunning.com/results/10/ma/Apr25_27thAn_set1.shtml'
  lines <- readLines(url)
  no.records <- length(lines)
  speeds <- c()
  
  for (i in 1:no.records) {
    record = lines[i]
    record <- strsplit(record, ' ')[[1]]
    record <- record[record != '']
    
    if (str_count(paste(record[4], record[5], record[6]), ':') < 3) {
      next
    }
    
    speeds <- c(speeds, convertPaceToMPH(record[6]))
  }
  return (speeds)
}

convertPaceToMPH <- function(entry) {
  # Pace is formated as Minute : Seconds / Mile
  entry <- strsplit(entry, ':')[[1]]
  seconds <- as.integer(entry[1]) * 60 + as.integer(entry[2])
  return ((1.0 / seconds) * 60 * 60)
}

# Since this is a continuous random distribution, making histogram plots does not make sense
# Convert this into a probability distribution and plot it

plotData <- function (speeds) {
  par(mfrow=c(1,2))
  plot(speeds, dnorm(speeds), type="l", xlab="speed", ylab="probability")
  plot(speeds, pnorm(speeds), type="l", xlab="speed", ylab="cummulative probability")
}

speeds <- fetchData()
# plotData(speeds)