library(dplyr)
source('hepler.R')

FORCE_LOAD = F;

# Create the pregnancy table
pregnancy.fields <- data.frame(
  start = c(1,22, 56, 57, 59, 275, 277, 278, 284, 423),
  end = c(12, 22, 56, 58, 60, 276, 277, 279, 287, 440),
  name = c('caseid', 'nbrnaliv', 'babysex', 'birthwgt_lb',
           'birthwgt_oz', 'prglength', 'outcome', 'birthord', 'agepreg', 'finalwgt')
)

pregnancy <- readFWFFromCache("data/2002FemPreg.dat", pregnancy.fields, 'pregnancy')

# Create the respondants table
respondants.fields <- data.frame(
  start = c(1),
  end = c(12),
  name = c('caseid')
)

respondants <- readFWFFromCache("data/2002FemResp.dat", respondants.fields, 'respondants')

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