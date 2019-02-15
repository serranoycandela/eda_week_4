library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

nei.baltimore <- subset(NEI, fips == "24510")


total_emissions <- nei.baltimore %>% group_by(year) %>% summarise_at(vars(4), funs(sum(., na.rm=TRUE)))


png(filename = "plot2.png", width = 480, height = 480)

plot(total_emissions,main = "Total Emissions in Baltimore")

dev.off()