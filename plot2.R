#plot 2, 
setwd("C:/Users/smashao001/Desktop/Data & analytics/Exploratory Data Analysis/Week 1")

if(!file.exists("exdata.zip")){download.file(url,exdata.zip)}
if(!file.exists("household_power_consumption.txt")) {unzip("exdata.zip")}

data <- as.data.frame(read.table("household_power_consumption.txt", header = T, sep = ";"))

library(dplyr)
library(readr)
library(lubridate)

data <- data[data$Date %in% c("1/2/2007 ", "2/2/2007") ,]

data <- data %>%
  select(Date,Time, Global_active_power) %>%
  mutate(Global_active_power = parse_number(Global_active_power))%>%
  cbind(dateTime=strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

png("plot2.png", width=480, height=480)
with(data,plot(dateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()