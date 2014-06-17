# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#
## summarize data
library(sqldf)
eligibleSCC <- sqldf("select SCC,Short_Name from SCC where SCC_Level_Two like '%Highway Vehicles%'")
a <- sqldf("select year, sum(emissions) emissions from NEI JOIN eligibleSCC where fips = 24510 and NEI.SCC = eligibleSCC.SCC group by year")
#
## plot graphs
library(ggplot2)
p <- qplot(year,emissions,data=a,geom=c("smooth"),method="lm",main="Baltimore City emissions")
print(p)