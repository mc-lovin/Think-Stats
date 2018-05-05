library(dplyr)

readFWF <- function(filename, fields) {
  fields <- mutate(fields, gap = start - lag(end, default = 0) - 1, cur = end - start + 1)
  fields$gap = -fields$gap

  widths <- as.vector(rbind(fields$gap, fields$cur))
  widths <- widths[widths != 0]
  df <- read.fwf(filename, widths = widths)

  colnames(df) = fields$name
  return (df)
}

readFWFFromCache <- function(filename, fields, varname) {
  if (exists(varname)) {
    return (get(varname))
  }
  return (readFWF(filename, fields))
}

getPrettyFactors <- function(data, dataName, freqName) {
  # table should be a 1d integeral distribution
  data = table(data)
  df <- data.frame(
    dataName = as.numeric(rownames(data)),
    freqName = as.numeric(data)
  )
  rownames(df) <- NULL
  colnames(df) <- c(dataName, freqName)
  return (df)
}

makeCDF <- function(data, colName) {
  data[colName] = cumsum(data[colName] / sum(data[colName]))
  return (data)
}

makeCDFFromData <- function(data, dataName, freqName) {
  factors = getPrettyFactors(data, dataName, freqName)
  return (makeCDF(factors, freqName))
}

# The difference between this and make CDF is that this will return the normal
# model which represents this data, the actual cdf might not be the normal
# function
makeCDFNormalModel <- function(data, dataName, normName) {
  df <- data.frame(
    dataName = df$weight2,
    normName = pnorm(df$weight2, mean = mean(df$weight2), sd=sd(df$weight2))
  )
  colnames(df) <- c(dataName, normName)
  return (df)
}

savePlot <- function(fileName) {
  ggsave(fileName,
       plot = last_plot(),
       width = 5, height = 5,
       units = "in",
       dpi = 300)
}