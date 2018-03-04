dir()
setwd("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4")

## Loading Data SummarySCC.RDS

if(!exists("NEI"))
  NEI <- readRDS("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4/summarySCC_PM25.rds")

if(!exists("SCC"))
  SCC <- readRDS("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4/Source_Classification_Code.rds")

library(ggplot2)

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
## Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 
## plotting system to make a plot answer this question.

names(SCC)
names(NEI)

subsetBaltimore <- subset(NEI, fips == "24510")

totalbyYearBaltimoreType <- aggregate(Emissions ~ year + type, subsetBaltimore, sum)

png('plot3.png', width=640, height = 480)

g <- ggplot(totalbyYearBaltimoreType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(g)
dev.off()

