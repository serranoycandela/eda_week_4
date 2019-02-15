library(dplyr)
library(ggplot2)
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coal_levels = c("Fuel Comb - Comm/Institutional - Coal", 
                "Fuel Comb - Electric Generation - Coal",
                "Fuel Comb - Industrial Boilers, ICEs - Coal")

the_coal_sccs <- subset(SCC, EI.Sector %in% coal_levels)$SCC

nei_coal <- subset(NEI, SCC %in% the_coal_sccs )

t_coal <- nei_coal %>% group_by(year) %>% summarise_at(vars(4), funs(sum(., na.rm=TRUE)))



ggplot(t_coal, aes(x=year, y=Emissions)) +
  geom_line() +
  ggtitle("Total combustion-related coal emissions in US") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("plot4.png")