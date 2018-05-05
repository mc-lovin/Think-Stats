source('helper.R')
library(ggplot2)

# This tells if the given data forms some sort of model.
saveNormalDistributionPlot <- function(data, fileName) {
  df = data.frame(
    data = sort(data),
    norm = sort(rnorm(length(data), 0, 1))
    )
  print(ggplot(df, aes(x=norm, y=data)) + geom_point(size=0.5, color='green'))
  savePlot(fileName)
}