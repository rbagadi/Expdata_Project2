## Q4: Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999???2008?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
x <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
NEI.subset <- NEI[NEI$SCC %in% x$SCC, ]
NEI.subset <- NEI.subset[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
NEI.aggdata <- NEI.aggdata[, c(1, 2)]
png('plot4.png', width=480, height=480)
plot(NEI.aggdata$year, NEI.aggdata$Emissions, ylab="Total PM2.5 Emission (tons)", xlab="Year", type="n", main = "Total PM2.5 Emissions from Coal Combustion-related Sources")
lines(NEI.aggdata$year, NEI.aggdata$Emissions, type= "l", col = 'red')
dev.off()