library('dplyr')
library('ggplot2')
# Loading data
# Initialization section
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
combustion <-  sources[grep('Combustion', sources$SCC.Level.One, ignore.case = TRUE), ]
combCoal <- sources[grep('Coal', combustion$SCC.Level.Three, ignore.case = TRUE), ]
fullData <- merge(data, combCoal, by = 'SCC') 

years <- group_by (fullData, year)
df <- summarize(years, Emissions = sum(Emissions, na.rm = TRUE))
plot(as.character(df$year), as.numeric(df$Emissions),
	main = 'Total PM25 emissions per year\n from coal-related sources, US',
	ylab = 'Emissions, tons',
	xlab = 'Year',
	col='blue')

lines(as.character(df$year), as.numeric(df$Emissions))
dev.copy(png,filename="plots/plot4.png", bg="white");
dev.off()
