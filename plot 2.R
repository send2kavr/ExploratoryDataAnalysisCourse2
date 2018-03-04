dir()
setwd("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4")

## Loading Data SummarySCC.RDS

if(!exists("NEI"))
  NEI <- readRDS("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4/summarySCC_PM25.rds")

if(!exists("SCC"))
  SCC <- readRDS("E:/R Programming/R Coursera/Exploratory Data Analysis/Week 4/Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

names(SCC)
names(NEI)

subsetBaltimore <- subset(NEI, fips == "24510")

totalbyYearBaltimore <- aggregate(Emissions ~ year, subsetBaltimore, sum)

png('plot2.png')
barplot(height=totalbyYearBaltimore$Emissions, names.arg=totalbyYearBaltimore$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years in Baltimore'))
dev.off()
