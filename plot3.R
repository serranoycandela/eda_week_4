library(dplyr)
library(ggplot2)
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer 
# this question.


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips == "24510")


emissions_by_type <- baltimore %>% group_by(year, type) %>% summarise_at(vars(4), funs(sum(., na.rm=TRUE)))

ggplot(emissions_by_type, aes(x=year, y=Emissions, color=type)) + geom_line() +
  ggtitle("Total Emissions in Baltimore") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("plot3.png")


