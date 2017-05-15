#plot 3, 
setwd("C:/Users/smashao001/Desktop/Data & analytics/Exploratory Data Analysis/Week 1")

if(!file.exists("exdata.zip")){download.file(url,exdata.zip)}
if(!file.exists("household_power_consumption.txt")) {unzip("exdata.zip")}

data <- as.data.frame(read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = FALSE))

library(dplyr)
library(readr)
library(lubridate)

data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]


data <- data %>%
        mutate(Global_active_power  = as.numeric(Global_active_power),
        Sub_metering_1 = parse_number(Sub_metering_1),
        Sub_metering_2 = parse_number(Sub_metering_2),
        Sub_metering_3 = parse_number(Sub_metering_3))%>%
        cbind(dateTime=strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))
        



png("plot3.png", width=480, height=480)
plot(data$dateTime, data$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(data$dateTime, data$Sub_metering_2, type="l", col="red")
lines(data$dateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "blue", "red"))
dev.off()