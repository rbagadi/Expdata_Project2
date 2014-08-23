## Q2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## read all rows for Baltimore City, Maryland, then select only Emissions and year columns
NEI.subset <- NEI[NEI$fips == "24510",]
NEI.subset <- NEI.subset[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
png('plot2.png', width=480, height=480)
plot(NEI.aggdata$year, NEI.aggdata$Emissions, ylab="Total PM2.5 Emission (tons)", xlab="Year", type="n", main = "Total PM2.5 Emissions in Baltimore City, Maryland")
lines(NEI.aggdata$year, NEI.aggdata$Emissions, type= "l")
dev.off()
