setwd("/Users/qdotnguyen/beGreat/r/coursera/dataproducts/")

nba.df <- read.csv("nba_stats.csv", header = TRUE)

nba1.lm <- lm(Salary_M ~ Inches + Age + MPG + PPG + FGAPG + RPG + APG, data=nba.df)