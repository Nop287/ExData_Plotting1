## Efficient way to read just the relevant data from the data set
require(sqldf)

plot1 <- function() {
  ## Select just two days from the data set
  data <- read.csv.sql("household_power_consumption.txt", 
                       "SELECT * FROM file WHERE Date = \"1/2/2007\" OR Date = \"2/2/2007\"",
                       sep = ";")

  ## convert Date and Time to da datatime object for plotting
  data$Time <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
  ## convert Date from string to an actual Date
  data$Date <- strptime(data$Date, format = "%d/%m/%Y")

  png("plot1.png")
  hist(data$Global_active_power, main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
       col = "red")
  dev.off()
}