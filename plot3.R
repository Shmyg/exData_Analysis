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
# Subsetting data for Baltimore
filteredData <- subset(data, data$fips ==  '24510')
years <- group_by (filteredData, year, type)
df <- summarize(years, Emissions = sum(Emissions, na.rm = TRUE))
g <- ggplot(data=df, aes(x=year, y=Emissions, group=type, colour=type), geom_line=aes(colour=GROUP), geom_smooth=aes(group=GROUP))
g <- g + geom_line()
g <- g + ggtitle('Emissions per year and type, Baltimore')
g
ggsave('plots/plot3.png')
