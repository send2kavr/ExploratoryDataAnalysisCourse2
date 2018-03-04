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

## Compare emissions from motor vehicle sources in Baltimore City with emissions from 
## motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
## has seen greater changes over time in motor vehicle emissions?

subsetBaltimore <- subset(NEISCC, (fips == "24510" | fips == "06037") & type == "ON-ROAD" )

totalbyYearBaltimoreYearFips <- aggregate(Emissions ~ year + fips, subsetBaltimore, sum)
totalbyYearBaltimoreYearFips$fips[totalbyYearBaltimoreYearFips == "24510"] <- "Baltimore"
totalbyYearBaltimoreYearFips$fips[totalbyYearBaltimoreYearFips == "06037"] <- "Los Angeles"

png('plot6.png', width=640, height = 480)

g <- ggplot(totalbyYearBaltimoreYearFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, vs Los Angeles, CA 1999-2008')
print(g)
dev.off()

