setwd("C:/Users/ShopDemo/Desktop/Data & analytics/Exploratory Data Analysis/Week 1")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("exdata.zip")){download.file(url,exdata.zip)}
if(!file.exists("household_power_consumption.txt")) {unzip("exdata.zip")}

library(dplyr)
library(readr)
library(lubridate)


data <- read.table("household_power_consumption.txt",  header = T, sep = ";")

data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

data <- data %>%
  mutate(Global_active_power = parse_number(Global_active_power), 
         Global_reactive_power = parse_number(Global_reactive_power),
         Voltage = parse_number(Voltage),
         Sub_metering_1 = parse_number(Sub_metering_1),
         Sub_metering_2 = parse_number(Sub_metering_2),
         Sub_metering_3 = parse_number(Sub_metering_3))%>%
  cbind(dateTime=strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

 png("plot4.png", width = 720, height = 720)
 par(mfrow = c(2,2))
 with(data,plot(dateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
 with(data,plot(dateTime, Voltage, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
 with(data,plot(dateTime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab=""))
 lines(data$dateTime, data$Sub_metering_2, type="l", col="red")
 lines(data$dateTime, data$Sub_metering_3, type="l", col="blue")
 legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "blue", "red"))
 with(data,plot(dateTime, Global_reactive_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()