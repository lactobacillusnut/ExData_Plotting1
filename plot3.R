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
       col=c("black","red", "blue"), lty=1:2)

#Export to PNG
dev.copy(png,'Plot3.png',width = 480, height = 480)
dev.off()
