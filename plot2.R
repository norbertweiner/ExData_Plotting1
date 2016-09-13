#author:Zhang Zhang
#Coursera HW Project 3

library(zipfR)
library(data.table)
library(lubridate)
library(dplyr)

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#check whetehr the file exist, if not, download and unzip
if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")){
  download.file(fileUrl,"exdata%2Fdata%2Fhousehold_power_consumption.zip")
  unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

#read table into data.frame and convert Date Time from Character to Date
file<-"household_power_consumption.txt"
data<-read.table(file,header = TRUE,sep = ";",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = "?")
data$Date <- dmy(data$Date)
data1<-data[data$Date %in% c(ymd("2007-02-01"),ymd("2007-02-02")),]

#paste to get date-time
x<-paste(data1$Date,data1$Time)
x<-ymd_hms(x)

y<-data1$Global_active_power

#generate png
png("plot2.png", width = 480, height = 480, units = "px")
plot(x,y,type = "n",xlab="",ylab = "Global Active Power (kilowatts)")
lines(x,y,type="l")
dev.off()