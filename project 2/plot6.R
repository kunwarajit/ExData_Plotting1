# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#
## summarize data
library(sqldf)
eligibleSCC <- sqldf("select SCC,Short_Name from SCC where SCC_Level_Two like '%Highway Vehicles%'")
a <- sqldf("select year, fips, sum(emissions) emissions from NEI JOIN eligibleSCC where NEI.fips in( '24510','06037') and NEI.SCC = eligibleSCC.SCC group by year, fips")
#
## plot graphs
library(ggplot2)
p <- qplot(year,emissions,data=a,geom=c("smooth"),col=fips,method="lm",main="Baltimore Cit(24510) Vs Los Angeles County (06037)emissions",asp=3.5) + theme(axis.text.x = element_text(angle = 90))
print(p)