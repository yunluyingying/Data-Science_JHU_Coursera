setwd("~/Documents/Self-learning/DS/Data Science-JHU/4-Plot data/project 2")
unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI1<-tapply(NEI$Emissions,NEI$year,sum)
barplot(NEI1,xlab = "Year",ylab="Total PM2.5 Emissions (Tons)", main="Total PM2.5 Emissions in the US", ylim=c(0,8e+06))
dev.copy(png,"plot1.png",width=480, height=480)
dev.off()
#Yes, it was decreasing. 