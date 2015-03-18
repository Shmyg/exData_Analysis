library('dplyr')

# Loading data
Sys.setlocale('LC_ALL', 'en_US.UTF8')
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
zipfile <- 'exdata-data-NEI_data.zip'
dataFile <- 'summarySCC_PM25.rds'
sourceFile <- 'Source_Classification_Code.rds'

# Reaging and parsing the file
# Checking if the file has already been downloaded
if (!file.exists(zipfile)) {
 # Not yet
 download.file (url, zipfile, method = 'curl')
 unzip(zipfile)
} else {
 # Dirty job was already done
 message( 'The file has already been downloaded, skipping')
}

data <- readRDS(dataFile)
data <- transform(data, year = factor(year))
sources <- readRDS(sourceFile)

# Making plot
filteredData <- subset(data, data$year %in% c('1999', '2002', '2005', '2008'))
years <- group_by (filteredData, year)
df <- summarize(years, Emissions = sum(Emissions, na.rm = TRUE))
plot(as.character(df$year), as.numeric(df$Emissions),  main = 'Total PM25 emissions per year, US', ylab = 'Emissions, tons',
	xlab = 'Year', col='blue')
lines(as.character(df$year), as.numeric(df$Emissions))
dev.copy(png,filename="plots/plot1.png", bg="white");
dev.off()
