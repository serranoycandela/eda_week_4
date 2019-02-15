library(dplyr)
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips == "24510")

vehicle_levels = c("Mobile - On-Road Diesel Heavy Duty Vehicles",     
                    "Mobile - On-Road Diesel Light Duty Vehicles",       
                    "Mobile - On-Road Gasoline Heavy Duty Vehicles",     
                    "Mobile - On-Road Gasoline Light Duty Vehicles")


vehicle_sccs <- subset(SCC, EI.Sector %in% vehicle_levels)$SCC


baltimore_vehicle <- subset(baltimore,SCC %in% vehicle_sccs)

vehicle_emissions <- baltimore_vehicle %>% group_by(year) %>% summarise_at(vars(4), funs(sum(., na.rm=TRUE)))

ggplot(vehicle_emissions, aes(x=year, y=Emissions)) +
  geom_line() +
  ggtitle("Total Vehicle Emissions in Baltimore") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("plot5.png")