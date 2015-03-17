library('dplyr')
# Loading data
source('readData.R')

# Making plot
filteredData <- subset(data, data$year %in% c('1999', '2002', '2005', '2008'))
years <- group_by (filteredData, year)
df <- summarize(years, Emissions = sum(Emissions, na.rm = TRUE))
plot(as.character(df$year), as.numeric(df$Emissions),  main = 'Total PM25 emissions per year, US', ylab = 'Emissions, tons',
	xlab = 'Year', col='blue')
lines(as.character(df$year), as.numeric(df$Emissions))
dev.copy(png,filename="plots/plot1.png", bg="transparent");
dev.off()
