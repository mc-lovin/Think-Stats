library(dplyr)

FORCE_LOAD = F;

readFWF <- function(filename, fields) {
  fields <- mutate(fields, gap = start - lag(end, default = 0) - 1, cur = end - start + 1)
  fields$gap = -fields$gap

  widths <- as.vector(rbind(fields$gap, fields$cur))
  widths <- widths[widths != 0]
  df <- read.fwf(filename, widths = widths)
  
  colnames(df) = fields$name
  return (df)
}

# Create the pregnancy table
pregnancy.fields <- data.frame(
  start = c(1,22, 56, 57, 59, 275, 277, 278, 284, 423),
  end = c(12, 22, 56, 58, 60, 276, 277, 279, 287, 440),
  name = c('caseid', 'nbrnaliv', 'babysex', 'birthwgt_lb',
           'birthwgt_oz', 'prglength', 'outcome', 'birthord', 'agepreg', 'finalwgt')
)

if (!exists('pregnancy') || FORCE_LOAD) {
  pregnancy <- readFWF("data/2002FemPreg.dat", pregnancy.fields)
}

# Create the respondants table
respondants.fields <- data.frame(
  start = c(1),
  end = c(12),
  name = c('caseid')
)

if (!exists('respondants') || FORCE_LOAD) {
  erespondants <- readFWF("data/2002FemResp.dat", respondants.fields)
}

info <- function() {
  cat ('Number of pregnancies', nrow(pregnancy), '\n')
  print (head(pregnancy))
  cat ('Number of respondants', nrow(respondants), '\n')
  print (head(respondants))
}


lb <- function() {
  library(crayon)
  cat(blue("\n=======================\n"))
}
# info()