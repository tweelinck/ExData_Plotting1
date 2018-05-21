#we use the lubridate year, day and month functions to subset the data
library(lubridate)

plot2 <- function(){
        #Loading data
        data <- read.table('household_power_consumption.txt', header=TRUE, sep=';')
        #Subset to relevant dates
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        data <- data[ (day(data$Date) == 1 | day(data$Date) == 2) & month(data$Date) == 2 & year(data$Date) == 2007,]
        #Combine date and time
        data$Date <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
        data <- data[,-2]
        #Create plot
        data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
        png(filename = "Plot2.png",width = 480, height = 480)
        plot(x = data$Date, y= data$Global_active_power, xlab = "", ylab = 'Global Active Power (kilowatts)', type = 'l')
        dev.off()
}
