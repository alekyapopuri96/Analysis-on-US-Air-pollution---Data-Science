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
## claculating the total of emissions by year
sum<-aggregate(air_data$Emissions, by=list(Group=air_data$year), FUN=sum)
sum
## dividing the total emission by 100 for better readability in the bar plot
sum$x<- sum$x/100

## plotting the bar plot for total emissions and year
bar<-barplot(sum$x ~ sum$Group, col = c("blue","green","pink","red"),xlab="year",ylab="sum of emissions(divided by 100)",main="Total Emissions for years 1999, 2002, 2005, 2008")
## added text to the barplot
text(x = bar, y = round(sum$x/10,4), label = round(sum$x/10,4), pos = 3, cex = 0.8, col = "black")
## we can see from the bar plot that there is a decerease in total emissions in every year from 1999 to 2008.

