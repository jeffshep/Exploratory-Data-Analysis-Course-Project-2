# Load ggplot2 library
library(ggplot2)

# Loading provided datasets
NEI <- readRDS("~/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/exdata_data_NEI_data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

# Generate the graph and save to desired location
png(filename='~/GitHub/Exploratory-Data-Analysis-Course-Project-2/plot5.png')

ggplot(data=MD.df, aes(x=factor(year), y=Emissions)) +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emissions")) +
        ggtitle("Emissions from motor vehicle sources in Baltimore City")
dev.off()