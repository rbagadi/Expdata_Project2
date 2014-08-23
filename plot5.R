## Q5: How have emissions from motor vehicle sources have changed from 1999-2008
## in Baltimore City?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
x = SCC[grepl("motor", SCC$Short.Name, ignore.case=TRUE),]

## Select data only for motor emissions and Baltimore city.
NEI.subset <- NEI[(NEI$SCC %in% x$SCC) & (NEI$fips == "24510"), ]

NEI.subset <- NEI.subset[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
NEI.aggdata <- NEI.aggdata[, c(1, 2)]
png('plot5.png', width=480, height=480)
plot(NEI.aggdata$year, NEI.aggdata$Emissions, ylab="Total PM2.5 Emission (tons)", xlab="Year", type="n", main = "Total PM2.5 Emissions from Motor Vehicle Sources in Baltimore City")
lines(NEI.aggdata$year, NEI.aggdata$Emissions, type= "l", col = "blue")
dev.off()
