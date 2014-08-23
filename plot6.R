## Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
x = SCC[grepl("motor", SCC$Short.Name, ignore.case=TRUE),]

## Select data only for motor emissions and Baltimore city (fips == "24510")
NEI.subset <- NEI[(NEI$SCC %in% x$SCC) & (NEI$fips == "24510"), ]
NEI.subset <- NEI.subset[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.Baltimore <- NEI.aggdata[, c(1, 2)]

## Select data only for motor emissions and Los Angeles County, California (fips == "06037")
NEI.subset <- NEI[(NEI$SCC %in% x$SCC) & (NEI$fips == "06037"), ]
NEI.subset <- NEI.subset[, c(4, 6)]
NEI.aggdata <-aggregate(NEI.subset, by=list(year = NEI.subset$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.LosAngles <- NEI.aggdata[, c(1, 2)]

png('plot6.png', width=480, height=480)
ggplot() + 
  geom_line(data = NEI.aggdata.Baltimore, aes(x = year, y = Emissions, color = "Baltimore City")) +
  geom_line(data = NEI.aggdata.LosAngles, aes(x = year, y = Emissions, color = "Los Angeles County"))  +
  xlab('year') +
  ylab('Emissions (in Tons)') +
  labs(color="Legend")
dev.off()