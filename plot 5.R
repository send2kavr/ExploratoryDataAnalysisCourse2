dir()
setwd("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4")

## Loading Data SummarySCC.RDS

if(!exists("NEI"))
  NEI <- readRDS("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4/summarySCC_PM25.rds")

if(!exists("SCC"))
  SCC <- readRDS("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4/Source_Classification_Code.rds")

## Merge the two data sets to find out the Coal as Short.Name

if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

## Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999-2008?

## find out the subset of coal specific data

subsetBaltimore <- subset(NEISCC, fips == "24510")

totalbyYearBaltimoreType <- aggregate(Emissions ~ year + type, subsetBaltimore, sum)

png('plot4.png', width=640, height = 480)

g <- ggplot(totalbyYearBaltimoreType, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()

