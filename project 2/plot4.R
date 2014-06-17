# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#
## summarize data
library(sqldf)
eligibleSCC <- sqldf("select SCC,Short_Name from SCC where Short_Name like '%Coal%' and SCC_Level_One like '%combustion%'")
a <- sqldf("select year, sum(emissions) emissions from NEI JOIN eligibleSCC where NEI.SCC = eligibleSCC.SCC group by year")
#
## plot graphs
library(ggplot2)
p <- qplot(year,emissions,data=a,geom=c("smooth"),method="lm")
print(p)