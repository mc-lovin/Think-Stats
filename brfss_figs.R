library(ggplot2)
source('brfss.R')

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