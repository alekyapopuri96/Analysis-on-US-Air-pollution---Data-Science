
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
balitmore<- filter(air_data, fips == "24510" & type == "ON-ROAD")
balitmore
table(balitmore$year)
## claculating the total of emissions by year and type for balitmore 
sum<-aggregate(balitmore$Emissions, by=list(Group=balitmore$year), FUN=sum)
## renaming the column names
sum<-sum %>% 
  rename(
    Emission = x,
    year = Group 
  )
sum

## creating the ggplot with years and emission
p<-ggplot(sum, aes(year,Emission))+ 
  geom_bar(stat="identity",colour = "red",fill= "orange")+
  
  theme_bw()+
  geom_text(aes(label=Emission, vjust=0))
  
p+labs(title = "Total Emission for Balitmore city for Motor Vehicle and all years")
p+labs(x = " Year")
p+labs(y="Emission")






