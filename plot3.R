library('dplyr')
library('ggplot2')
# Loading data
source('readData.R')

# Making plot
# Subsetting data for Baltimore
filteredData <- subset(data, data$fips ==  '24510')
df <- summarize(years, Emissions = sum(Emissions, na.rm = TRUE))
years <- group_by (filteredData, year, type)
png("plots/plot3.png")
g <- ggplot(data=df, aes(x=year, y=Emissions, group=type, colour=type), geom_line=aes(colour=GROUP), geom_smooth=aes(group=GROUP))
g <- g + geom_line()
g
dev.off()
