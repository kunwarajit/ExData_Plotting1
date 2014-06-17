# load data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
#
## Get records with PM25 pollutant only
NEI <- NEI[NEI$Pollutant == "PM25-PRI",]
#NEI <- NEI[,names(NEI) %in% c("year","Emissions")]
# summarize data
library(sqldf)
a <- sqldf("select year,type,sum(Emissions) as emissions from NEI where fips = 24510 group by year,type")
#
## plot graphs
library(ggplot2)
qplot(year,emissions,data=a,color=type,geom=c("smooth"),method="lm",facets=.~type)