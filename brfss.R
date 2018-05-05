source('helper.R')


brfss.fields <- data.frame(
  start = c(101,119, 127, 143, 1254, 1251),
  end = c(102, 122, 130, 143, 1258, 1253),
  name = c('age', 'weight2', 'wtyrago', 'sex', 'wtkg2', 'htm3')
)
brfss <- readFWFFromCache('data/CDBRFS08.ASC', brfss.fields, 'brfss')