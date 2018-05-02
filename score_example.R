source('relay.R')

PercentileRank <- function(scores, score) {
  return (length(scores[scores <= score]) * 100 / length(scores))
}

scores <- c(55, 66, 77, 88, 99)
print (PercentileRank(scores, 88))

speeds <- fetchData()
# Calculating scores via hp in R
print (quantile(speeds, seq(0.1,1,0.1)))