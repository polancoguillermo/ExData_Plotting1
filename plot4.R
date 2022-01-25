#Plot 4 - line plot sub_metering and time

#load libraries and import data

library(dplyr)
library(data.table)
library(lubridate)

dat <- fread("household_power_consumption.txt") %>%
  as_tibble(dat)

dat$Date <- dmy(dat$Date) 

#select only the data of interest
dat_feb <- filter(dat, Date>="2007-02-01", Date<="2007-02-02")

#week day
dat_feb$datetime <- paste(dat_feb$Date, dat_feb$Time) %>%
  as_datetime(format = "%Y-%m-%d %H:%M:%S", tz = 'EST')

#make numeric
dat_feb$Global_active_power <- as.numeric(dat_feb$Global_active_power)
dat_feb$Global_reactive_power <- as.numeric(dat_feb$Global_reactive_power)
dat_feb$Voltage <- as.numeric(dat_feb$Voltage)
dat_feb$Sub_metering_1 <- as.numeric(dat_feb$Sub_metering_1)
dat_feb$Sub_metering_2 <- as.numeric(dat_feb$Sub_metering_2)
dat_feb$Sub_metering_3 <- as.numeric(dat_feb$Sub_metering_3)

#Set up grid for 4 charts
par(mfrow=c(2,2))


#time to plot it! 
plot1 <- plot(dat_feb$datetime, dat_feb$Global_active_power, 
              type= 'S',
              xlab = "",
              ylab = "Global Active Power (kilowatts)")

plot2 <- plot(dat_feb$datetime, dat_feb$Voltage, 
              type= 'S',
              xlab = "",
              ylab = "Voltage")

plot3 <- plot(dat_feb$datetime, dat_feb$Sub_metering_1, type = "S",
              xlab = "",
              ylab = "Energy sub metering")
        lines(dat_feb$datetime, dat_feb$Sub_metering_2, type="s", col = "red") 
        lines(dat_feb$datetime, dat_feb$Sub_metering_3, type="s", col = "blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"),
               lty = 1,
               cex = 0.8)

plot4 <- plot(dat_feb$datetime, dat_feb$Global_reactive_power, 
              type= 'S',
              xlab = "",
              ylab = "Global Reactive Power (kilowatts)")

