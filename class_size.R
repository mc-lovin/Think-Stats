class.data <- data.frame (
  classsize = c(7, 12, 17, 22, 27, 32, 37, 42, 47),
  freq = c(8, 8, 14, 4, 6, 12, 8, 3, 2))

# Average class size 
average <- sum(class.data$classsize * class.data$freq) /
  sum(class.data$freq)
cat ('Actual Average class size', average, '\n')

# Average from a student prespective
# basis 7 * 8 students report that class size is 7
average <- sum(class.data$classsize * class.data$freq  * class.data$classsize) / sum(class.data$classsize * class.data$freq)
cat ('Average class size From Student Prespective', average, '\n')
