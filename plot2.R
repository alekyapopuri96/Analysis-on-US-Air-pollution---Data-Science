## read the data
air_data <- readRDS("summarySCC_PM25.rds")
head(air_data)
## checking the dimensions
dim(air_data)
names(air_data)
## loaded the emissions intp pm25 and checking for null values
pm25<- air_data$Emissions
head(pm25)
mean(is.na(pm25))

## making the year as factor with levels-1999,2002,2005,2008
air_data$year <- factor(air_data$year, levels = c(1999,2002,2005,2008))
str(air_data)
#3 subsetting the balitmore, MD data  from the main data
balitmore<- filter(air_data, fips == "24510")
balitmore
table(balitmore$year)
## claculating the total of emissions by year for balitmore fips
sum<-aggregate(balitmore$Emissions, by=list(Group=balitmore$year), FUN=sum)
sum
## plotting the bar plot for total emissions and year in balitmore
bar<-barplot(sum$x ~ sum$Group, col = c("blue","green","pink","red"),xlab="year",ylab="sum of emissions(divided by 100)",main="Total Emissions in Balitmore for years 1999, 2002, 2005, 2008")
# added text to the barplot
text(x = bar, y = round(sum$x/10,4), label = round(sum$x/10,4), pos = 3, cex = 0.8, col = "black")
## from the plot we can see that the emissions have decreased in 2002 but again increased in 2005 with a decrease in 2008


