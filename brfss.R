source('helper.R')
source('rankit.R')
library(ggplot2)
library(truncnorm)

brfss.fields <- data.frame(
  start = c(101,119, 127, 143, 1254, 1251),
  end = c(102, 122, 130, 143, 1258, 1253),
  name = c('age', 'weight2', 'wtyrago', 'sex', 'wtkg2', 'htm3')
)

brfss <- readFWFFromCache('data/CDBRFS08.ASC', brfss.fields, 'brfss')
df <- brfss[,-7]

df$weight2[df$weight2 == 9999 | df$weight2 == 7777] = NA
df = na.omit(df)

df$weight2[df$weight2 < 1000] = df$weight2[df$weight2 < 1000] / 2.2
df$weight2[df$weight2 > 9000 & df$weight2 < 9999] = df$weight2[df$weight2 > 9000 & df$weight2 < 9999] - 9000

cdf <- makeCDFFromData(df$weight2, 'weight', 'freq')
model <- makeCDFNormalModel(df$weight2, 'weight', 'freq')

print (ggplot() +
         geom_line(data=model, aes(weight, freq), color='red') +
         geom_line(data=cdf, aes(weight, freq), color='blue') +
         xlim(0, 160))
savePlot('4_weight_model.pdf')