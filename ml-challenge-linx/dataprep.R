setwd('/Volumes/Toshiba/Github/data-science/ml-challenge-linx/')

library(ff)

# Dados
train <- read.csv.ffdf(file='input/data.csv', sep=',', header=TRUE, VERBOSE=TRUE, first.rows=10000, next.rows=50000, colClasses=NA)
