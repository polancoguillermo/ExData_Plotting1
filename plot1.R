#Plot 1 - histogram showing the global power on the x and frequency on y

#load libraries and import data

library(dplyr)
library(data.table)
library(lubridate)

dat <- fread("household_power_consumption.txt") %>%
  as_tibble(dat)

dat$Date <- dmy(dat$Date) 

#select only the data of interest
dat_feb <- filter(dat, Date>="2007-02-01", Date<="2007-02-02")

#make active power numeric
dat_feb$Global_active_power <- as.numeric(dat_feb$Global_active_power)

plot1 <- hist(dat_feb$Global_active_power,
                main = "Global Active Power",
                xlab= "Global Active Power (kilowatts)",
                color = "orange")