library('dplyr')
library('ggplot2')
# Loading data
source('readData.R')

# Making plot
# Subsetting data for Baltimore
filteredData <- subset(data, data$fips ==  '24510')
combustion <-  sources[grep('Combustion', sources$SCC.Level.One, ignore.case = TRUE), ]
combCoal <- sources[grep('Coal', combustion$SCC.Level.Three, ignore.case = TRUE), ]
full_data <- merge(filteredData, combCoal, by = 'SCC') 

df <- summarize(years, Emissions = sum(Emissions, na.rm = TRUE))
years <- group_by (df, year)
plot(as.character(df$year), as.numeric(df$Emissions),
	main = 'Total PM25 emissions per year from coal-related sources, US',
	ylab = 'Emissions, tons',
	xlab = 'Year',
	col='blue')

lines(as.character(df$year), as.numeric(df$Emissions))
dev.copy(png,filename="plots/plot4.png", bg="transparent");
dev.off()
