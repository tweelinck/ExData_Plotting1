#we use the lubridate year, day and month functions to subset the data
library(lubridate)

plot4 <- function(){
        #Loading data
        data <- read.table('household_power_consumption.txt', header=TRUE, sep=';')
        #Subset to relevant dates
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        data <- data[ (day(data$Date) == 1 | day(data$Date) == 2) & month(data$Date) == 2 & year(data$Date) == 2007,]
        #Combine date and time
        data$Date <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
        data <- data[,-2]
        #factor to numeric
        data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
        data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
        data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
        data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
        data$Voltage <- as.numeric(as.character(data$Voltage))
        data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
        #make plots
        png(filename = "Plot4.png",width = 480, height = 480)
        par(mfrow = c(2,2))
        #plot 1
        plot(x = data$Date, y= data$Global_active_power, xlab = "", ylab = 'Global Active Power (kilowatts)', type = 'l')
        #plot 2
        plot(x=data$Date, y=data$Voltage, xlab ="datetime", ylab= 'Voltage', type = 'l')
        #plot 3
        plot(x = data$Date, y= data$Sub_metering_1, xlab = "", ylab = 'Energy sub metering', type = 'l')
        points(data$Date, data$Sub_metering_2, col='red', type = 'l')
        points(data$Date, data$Sub_metering_3, col = 'blue', type ='l')
        legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = 'n')
        #plot 4
        plot(x = data$Date, y= data$Global_reactive_power, xlab = "datetime", type = 'l')
        #close graphics device
        dev.off()
}