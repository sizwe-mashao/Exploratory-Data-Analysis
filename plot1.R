setwd("C:/Users/ShopDemo/Desktop/Data & analytics/Exploratory Data Analysis/Week 1")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("exdata.zip")){download.file(url,exdata.zip)}
if(!file.exists("household_power_consumption.txt")) {unzip("exdata.zip")}

data <- as.data.frame(read.table("household_power_consumption.txt", header = T, sep = ";"))

library(dplyr)
library(readr)

data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
data <- mutate(data, Global_active_power = parse_number(Global_active_power))
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power,col = "red", xlab = "Global Active Power (kilowatts)",  main = "Global Active Power")
dev.off()
