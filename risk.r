source('survey.r')
library(dplyr)

pregnancy$prglength # weeks

relativeRisk <- function(data) {
  # data : a subset of pregnancy
  early = data %>% subset(prglength <= 37)
  on.time = data %>% subset(prglength >= 38 & prglength <= 40)
  late = data %>% subset(prglength >= 41)
  
  cat ('Early ', nrow(early) / nrow(data), '\n')
  cat ('On Time ', nrow(on.time) / nrow(data), '\n')
  cat ('Late Births ', nrow(late) / nrow(data), '\n')
}

cat ('First babies\n')
relativeRisk(pregnancy %>% subset(birthord == 1)); lb()

cat ('Other babies\n')
relativeRisk(pregnancy %>% subset(birthord != 1)); lb()

cat ('Live births\n')
relativeRisk(pregnancy %>% subset(outcome == 1)); lb()

cat ('RELATIVE RISK FIRST / OTHER EARLY ', 
     nrow(pregnancy %>% subset(birthord == 1 & prglength <= 37))
        / nrow(pregnancy %>% subset(birthord != 1, prglength <= 37)), '\n')
cat ('RELATIVE RISK FIRST / OTHER ON TIME ', 
     nrow(pregnancy %>% subset(birthord == 1 & prglength >= 38 & prglength <= 40))
     / nrow(pregnancy %>% subset(birthord != 1 & prglength >= 38 & prglength <= 40)), '\n')
cat ('RELATIVE RISK FIRST / OTHER LATE ', 
     nrow(pregnancy %>% subset(birthord == 1 & prglength >= 41))
     / nrow(pregnancy %>% subset(birthord != 1 & prglength >= 41)), '\n')