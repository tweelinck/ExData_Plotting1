#we use the lubridate year, day and month functions to subset the data
library(lubridate)

plot3 <- function(){
        #Loading data
        data <- read.table('household_power_consumption.txt', header=TRUE, sep=';')
        #Subset to relevant dates
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        data <- data[ (day(data$Date) == 1 | day(data$Date) == 2) & month(data$Date) == 2 & year(data$Date) == 2007,]
        #Combine date and time
        data$Date <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
        data <- data[,-2]
        #Create plot
        data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
        data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
        data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
        png(filename = "Plot3.png",width = 480, height = 480)
        plot(x = data$Date, y= data$Sub_metering_1, xlab = "", ylab = 'Energy sub metering', type = 'l')
        points(data$Date, data$Sub_metering_2, col='red', type = 'l')
        points(data$Date, data$Sub_metering_3, col = 'blue', type ='l')
        legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
        dev.off()
}
