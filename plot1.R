library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


total_emissions <- NEI %>% group_by(year) %>% summarise_at(vars(4), funs(sum(., na.rm=TRUE)))



png(filename = "plot1.png", width = 480, height = 480)

plot(total_emissions,main = "Total Emissions in US")

dev.off()
