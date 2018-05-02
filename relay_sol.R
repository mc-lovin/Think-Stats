source('relay.R')

speeds <- fetchData()

print (mean(speeds))

plotData(speeds - 7.5)
