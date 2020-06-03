## This script creates Plot 1 in the Exploratory Data Analysis Course

# download file if not already done so
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("exdata_data_household_power_consumption.zip")) 
    download.file(fileurl,
                  "exdata_data_household_power_consumption.zip")

# Check if file has been unzipped
if(!file.exists("household_power_consumption.txt")){
    unzip("exdata_data_household_power_consumption.zip")
}

# load libraries
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)

# read data as tibble
data <- tbl_df(read.table("household_power_consumption.txt",sep = ";",header = 1)) 

# filter by dates "2007-02-01" to "2007-02-02"
newdata <- data %>%
    mutate(DateTime=dmy_hms(paste(Date,Time))) %>% #combine data and time
    mutate(Date=dmy(Date)) %>%
    mutate(Global_active_power=as.numeric(Global_active_power),
           Sub_metering_1=as.numeric(Sub_metering_1),
           Sub_metering_2=as.numeric(Sub_metering_2),
           Sub_metering_3=as.numeric(Sub_metering_3)) %>%
    filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02") & !is.na(Sub_metering_1))

# create multiplot

par(mfrow=c(2,2)) #2 by 2

# Plot Global_active_power as a function of time
plot(newdata$DateTime,newdata$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

#Plot Voltage as a function of time
plot(newdata$DateTime,newdata$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

# Plot sub metering 1
plot(newdata$DateTime,newdata$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

# Add sub metering 2
lines(newdata$DateTime,newdata$Sub_metering_2,
      type = "l",
      col = "red")

# Add sub metering 3
lines(newdata$DateTime,newdata$Sub_metering_3,
      type = "l",
      col = "blue")

# Set the legend
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), 
       cex=0.9,lty=1:2, box.lty=0, inset=.1,
       bg='transparent')

# Plot Global Reactive Power as a function of time
plot(newdata$DateTime,newdata$Global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

#Export to PNG
dev.copy(png,'Plot4.png',width = 480, height = 480)
dev.off()

