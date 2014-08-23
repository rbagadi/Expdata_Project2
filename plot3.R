## Q3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
## variable, which of these four sources have seen decreases in emissions from 1999???2008 
## for Baltimore City? Which have seen increases in emissions from 1999???2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

library("ggplot2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI.subset <- NEI[NEI$fips == "24510",]
NEI.subset <- NEI.subset[, c(4, 5, 6)]
NEI.subset.POINT <- NEI.subset[NEI.subset$type == "POINT",]
NEI.subset.POINT <- NEI.subset.POINT[, c(1, 3)]
NEI.subset.NONPOINT <- NEI.subset[NEI.subset$type == "NONPOINT",]
NEI.subset.NONPOINT <- NEI.subset.NONPOINT[, c(1, 3)]
NEI.subset.ONROAD <- NEI.subset[NEI.subset$type == "ON-ROAD",]
NEI.subset.ONROAD <- NEI.subset.ONROAD[, c(1, 3)]
NEI.subset.NONROAD <- NEI.subset[NEI.subset$type == "NON-ROAD",]
NEI.subset.NONROAD <- NEI.subset.NONROAD[, c(1, 3)]
NEI.aggdata.POINT <-aggregate(NEI.subset.POINT, by=list(year = NEI.subset.POINT$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.POINT <- NEI.aggdata.POINT[, c(1, 2)]
NEI.aggdata.NONPOINT <-aggregate(NEI.subset.NONPOINT, by=list(year = NEI.subset.NONPOINT$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.NONPOINT <- NEI.aggdata.NONPOINT[, c(1, 2)]
NEI.aggdata.ONROAD <-aggregate(NEI.subset.ONROAD, by=list(year = NEI.subset.ONROAD$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.ONROAD <- NEI.aggdata.ONROAD[, c(1, 2)]
NEI.aggdata.NONROAD <-aggregate(NEI.subset.NONROAD, by=list(year = NEI.subset.NONROAD$year), FUN=sum, na.rm=TRUE)
NEI.aggdata.NONROAD <- NEI.aggdata.NONROAD[, c(1, 2)]

png('plot3.png', width=480, height=480)
ggplot() + 
  geom_line(data = NEI.aggdata.POINT, aes(x = year, y = Emissions, color = "Point")) +
  geom_line(data = NEI.aggdata.NONPOINT, aes(x = year, y = Emissions, color = "Nonpoint"))  +
  geom_line(data = NEI.aggdata.ONROAD, aes(x = year, y = Emissions, color = "Onroad"))  +
  geom_line(data = NEI.aggdata.NONROAD, aes(x = year, y = Emissions, color = "Nonroad"))  +
  xlab('year') +
  ylab('Emissions (in Tons)') +
  labs(color="Legend")
dev.off()
