library(ggplot2)
source('helper.R')

df <- read.csv('populations.csv')
df <- df[c(-1)]

df <- df[, c(ncol(df) - 1)]

df <- lapply(df, function(from) as.integer(gsub(",", "", from)))

df <- df[!is.na(df)]
df <- unlist(df)

# Let us plot the cdf for df
cdf <- makeCDFFromData(df, 'weight', 'freq')
print (ggplot() + geom_line(data=cdf, aes(weight, freq), color='green'))
savePlot('population.pdf')

print (ggplot() + geom_line(data=cdf, aes(log(weight), freq), color='blue'))
savePlot('population_log.pdf')

print (ggplot() + geom_line(data=cdf, aes(log(weight), log(1 - freq)), color='blue'))
savePlot('population_log_log.pdf')

