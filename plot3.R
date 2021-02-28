
library(ggplot2)
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
## claculating the total of emissions by year and type for balitmore fips
sum<-aggregate(balitmore$Emissions, by=list(Group=balitmore$type,balitmore$year), FUN=sum)
## renaming the column names
sum<-sum %>% 
  rename(
    year = Group.2,
    type = Group 
  )
sum

## creating the ggplot with years and types
p<-ggplot(sum, aes(year,x))+ 
  geom_point()+
  facet_grid(. ~ type)+
  theme_bw()+
  geom_point(aes(color=type),size=4)
p+labs(title = "Total Emission for Balitmore city for all the types and years")
p+labs(x = " Year")
p+labs(y="Emission")


## from the plot we can see that 
## Non-road:-Non-point type has a slight increase in 2005 and decreased in 2008
## Non-point:-Non-point type has decreased continously from 1999 to 2008
##On-road:- on-road type has decreased continously from 1999 to 2008
##Point:- point has been increased in 2002 and 2005 but decreased in 2008
  

  

  
