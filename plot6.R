library(dplyr)
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#in Los Angeles County, California fips=="06037" 
#Which city has seen greater changes over time in motor vehicle emissions?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


la_baltimore <-  subset(NEI, fips == "24510" | fips == "06037")

vehicle_levels = c("Mobile - On-Road Diesel Heavy Duty Vehicles",     
                    "Mobile - On-Road Diesel Light Duty Vehicles",       
                    "Mobile - On-Road Gasoline Heavy Duty Vehicles",     
                    "Mobile - On-Road Gasoline Light Duty Vehicles")


vehicle_sccs <- subset(SCC, EI.Sector %in% vehicle_levels)$SCC


la_baltimore_vehicle <- subset(la_baltimore,SCC %in% vehicle_sccs)



la_baltimore_vehicle$city <- as.factor(la_baltimore_vehicle$fips)

levels(la_baltimore_vehicle$city) <- c("Los Angeles", "Baltimore") 
                                    
vehicle_emissions <- la_baltimore_vehicle %>% group_by(year,city) %>% summarise_at(vars(4), funs(sum(., na.rm=TRUE)))

ggplot(vehicle_emissions, aes(x=year, y=Emissions, color=city)) +
  geom_line() +
  scale_y_continuous(trans='log10')+
  ggtitle("Total Vehicle Emissions") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("plot6.png")