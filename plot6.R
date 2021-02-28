
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
## subsetting the balitmore, MD data  from the main data
balitmore<- filter(air_data, fips == "24510" & type == "ON-ROAD")
balitmore
## subsetting the California, MD data  from the main data
Losangeles<- filter(air_data, fips == "06037" & type == "ON-ROAD")
Losangeles
table(Losangeles$year)

## claculating the total of emissions by year and type for balitmore 
sum_balitmore<-aggregate(balitmore$Emissions, by=list(Group=balitmore$year), FUN=sum)
sum_Losangeles<-aggregate(Losangeles$Emissions, by=list(Group=Losangeles$year), FUN=sum)
## renaming the column names

sum_balitmore$county <- "baltimore,MD"
sum_Losangeles$county <- "Losangeles,CA"


sum_balitmore<-sum_balitmore %>% 
  rename(
    Emission = x,
    year = Group 
  )
sum_Losangeles<-sum_Losangeles%>% 
  rename(
    Emission = x,
    year = Group 
  )

balti_los<- rbind(sum_balitmore,sum_Losangeles)


## creating the ggplot with years and emission
p<-ggplot(balti_los, aes(year,Emission))+ 
  geom_bar(stat="identity",aes(fill = county))+
  facet_grid(county~ .,scales="free")+
  
  theme_bw()+
  geom_text(aes(label=Emission, vjust=0))
  

p+labs(title = "Total Emission for Balitmore city for Motor Vehicle vs Los Angeles")
p+labs(x = " Year")
p+labs(y="Emission")






