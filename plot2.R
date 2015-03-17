library('dplyr')
# Loading data
source('readData.R')

# Making plot
# Subsetting data for Baltimore
filteredData <- subset(data, data$fips ==  '24510')
years <- group_by (filteredData, year)
df <- summarize(years, Emissions = sum(Emissions, na.rm = TRUE))
plot(as.character(df$year), as.numeric(df$Emissions), main = 'PM25 emission per year, Baltimore', xlab = 'Year',
	ylab = 'Emissions, tons', col='blue')
lines(as.character(df$year), as.numeric(df$Emissions))
dev.copy(png,filename="plots/plot2.png", bg="white");
dev.off()
