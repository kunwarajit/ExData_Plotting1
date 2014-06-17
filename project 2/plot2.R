# load data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
#
## Get records with PM25 pollutant only
NEI <- NEI[NEI$Pollutant == "PM25-PRI",]
#NEI <- NEI[,names(NEI) %in% c("year","Emissions")]
# summarize data
a <- sqldf("select year,sum(Emissions) as emissions from NEI where fips = 24510 group by year")
#
## plot graphs
plot(a$year,a$emissions)
abline(lm(a$emissions ~ a$year))