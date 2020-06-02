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
    mutate(Date=dmy(Date)) %>%
    filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02"))
