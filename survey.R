library(dplyr)

readFWF <- function(filename, fields) {
  fields <- mutate(fields, gap = start - lag(end, default = 1), cur = end - start + 1)
  fields$gap = -fields$gap
  widths <- as.vector(rbind(fields$gap, fields$cur))
  print (widths)
  widths <- widths[widths != 0]
  df <- read.fwf(filename, widths = widths)
  colnames(df) = fields$name
  
  # TODO cast into type
  return (df)
}

# Create the respondants table
pregnancy.fields <- data.frame(
  start <- c(1,22, 56, 57, 59, 275, 277, 278, 284, 423),
  end <- c(12, 22, 56, 58, 60, 276, 277, 279, 287, 440),
  name <- c('caseid', 'nbrnaliv', 'babysex', 'birthwgt_lb', 
           'birthwgt_oz', 'prglength', 'outcome', 'birthord', 'agepreg', 'finalwgt'),
  classes <- c('int', 'int', 'int', 'int', 'int', 'int', 'int', 'int', 'int', 'float')
)
pregnancy <- readFWF("data/2002FemPreg.dat", pregnancy.fields)

respondants.fields <- data.frame(
  start <- c(1),
  end <- c(12),
  name <- c('caseid'),
  type <- c('int')
)
respondants = readFWF("data/2002FemResp.dat", respondants.fields)

cat ('Number of pregnancies', nrow(pregnancy), '\n')
print (head(pregnancy))

cat ('Number of respondants', nrow(respondants), '\n')
print (head(respondants))