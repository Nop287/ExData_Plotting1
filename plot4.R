## Efficient way to read just the relevant data from the data set
require(sqldf)

plot4 <- function() {
  ## Select just two days from the data set
  data <- read.csv.sql("household_power_consumption.txt", 
                       "SELECT * FROM file WHERE Date = \"1/2/2007\" OR Date = \"2/2/2007\"",
                       sep = ";")

  ## convert Date and Time to da datatime object for plotting
  data$Time <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
  ## convert Date from string to an actual Date
  data$Date <- strptime(data$Date, format = "%d/%m/%Y")

  png("plot4.png")
  
  par(mfrow = c(2, 2))
  plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  plot(data$Time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(data$Time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(data$Time, data$Sub_metering_2, col = "red")
  lines(data$Time, data$Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(data$Time, data$Global_reactive_power, type = "l", xlab = "", ylab = "Global_reactive_power")
  dev.off()
}