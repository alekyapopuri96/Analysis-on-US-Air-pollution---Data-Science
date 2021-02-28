library(ggplot2)
## read the data
air_data <- readRDS("summarySCC_PM25.rds")
source_data<-readRDS("Source_classification_Code.rds")

merge<- merge(air_data,source_data,by.air_data=SCC)

merge_sub<-grepl("*[Cc][Oo][Aa][Ll]*", source_data$EI.Sector)
subset_coal<-merge[merge_sub,]


## loaded the emissions intp pm25 and checking for null values
pm25<- subset_coal$Emissions
head(pm25)
mean(is.na(pm25))

## making the year as factor with levels-1999,2002,2005,2008
subset_coal$year <- factor(subset_coal$year, levels = c(1999,2002,2005,2008))
str(subset_coal)

## claculating the total of emissions by year 
sum<-aggregate(subset_coal$Emissions, by=list(Group=subset_coal$year), FUN=sum)
## renaming the column names
sum<-sum %>% 
  rename(
    year = Group,
    Emission = x 
  )
sum$Emission<-sum$Emission/100
p<-ggplot(sum, aes(year,Emission))+ 
  geom_bar(stat="identity")+
  
  theme_bw()
  
p+labs(title = "Total Emission for Coal Combustion  for all the years")
p+labs(x = " Year")
p+labs(y="Emission for all the Coal Combustion")

