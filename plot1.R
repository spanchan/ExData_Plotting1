library(dplyr)
library(datasets)

## Read data file from web and unzip
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/household_power_consumption.zip",method="curl")
unzip("./data/household_power_consumption.zip")

## Read csv with sep ; into hpcData and treat ? as NA
hpcData <- read.csv2("~/household_power_consumption.txt", 
                     na.strings = "?")

## Subset only data for Feb 1 and Feb 2 of 2007
## Use this data for any further exploration based on the project requirement
shpcData <- hpcData %>% filter(Date == "1/2/2007" | Date == "2/2/2007")


## Create a new POSIXct DateTime variable by combining Date and Time
shpcData$DateTime <- as.POSIXct(paste(shpcData$Date,
                                       shpcData$Time), 
                                 format="%d/%m/%Y %H:%M:%S")

## Convert classes for all other variables to numeric 
shpcData$Global_active_power <- as.numeric(
     as.character(shpcData$Global_active_power))
shpcData$Global_reactive_power <- as.numeric(
    as.character(shpcData$Global_reactive_power))
shpcData$Voltage <- as.numeric(
    as.character(shpcData$Voltage))
shpcData$Global_intensity <- as.numeric(
    as.character(shpcData$Global_intensity))
shpcData$Sub_metering_1 <- as.numeric(
      as.character(shpcData$Sub_metering_1))
shpcData$Sub_metering_2 <- as.numeric(
     as.character(shpcData$Sub_metering_2))
shpcData$Sub_metering_3 <- as.numeric(
     as.character(shpcData$Sub_metering_3))

## Create Plot 1 and write to a png file plot1.png

png(file="plot1.png",width=480, height=480)
hist(shpcData$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()

