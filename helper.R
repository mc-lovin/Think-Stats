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

savePlot <- function(fileName) {
  ggsave(fileName,
       plot = last_plot(),
       width = 5, height = 5,
       units = "in",
       dpi = 300)
}
