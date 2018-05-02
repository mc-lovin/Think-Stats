source('relay.R')

speeds <- fetchData()

cat ('Mean Speed is ', mean(speeds), '\n')

plotData(speeds - 7.5)
# Since the mean is ~7, the proability distribution is pretty symmetrical