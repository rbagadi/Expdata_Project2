## Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI.subset <- NEI[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
png('plot1.png', width=480, height=480)
plot(NEI.aggdata$year, NEI.aggdata$Emissions, ylab="Total PM2.5 Emission (tons)", xlab="Year", type="n", main = "Total PM2.5 Emissions in the United States")
lines(NEI.aggdata$year, NEI.aggdata$Emissions, type= "l")
dev.off()