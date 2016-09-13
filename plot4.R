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

y1<-data1$Sub_metering_1
y2<-data1$Sub_metering_2
y3<-data1$Sub_metering_3

#generate png
png("plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

plot(x,data1$Global_active_power,type = "n",xlab="",ylab = "Global Active Power")
lines(x,data1$Global_active_power,type = "l",col="black")

plot(x,data1$Voltage,type = "n",xlab="datetime",ylab="Voltage")
lines(x,data1$Voltage,type="l",col="black")

plot(x,y1,type = "n",ylim = range(c(y1,y2,y3)),xlab="",ylab = "Energy sub metering")
lines(x,y1,type = "l",col="black")
par(new = TRUE)
plot(x,y2,ylim = range(c(y1,y2,y3)),axes = F, type = "n",xlab="",ylab="")
lines(x,y2,type="l",col="red")
par(new = TRUE)
plot(x,y3,ylim = range(c(y1,y2,y3)),axes = F, type = "n",xlab="",ylab="")
lines(x,y3,type="l",col="blue")
legend("topright",lty = c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")

plot(x,data1$Global_reactive_power,type = "n",xlab="datetime",ylab="Global_reactive_power")
lines(x,data1$Global_reactive_power,type="l",col="black")
dev.off()