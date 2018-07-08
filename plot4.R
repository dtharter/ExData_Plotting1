# Plot 4: Quadruple plot of several variables
# David Harter
#
# This script will create 4 separate line plots showing four
# different variables as a function of time for February 
# 1 and 2, 2007.


# Check to see if directory exists, create it if it doesn't.
# Set working directory.
if(!dir.exists("./Documents/Coursera/Project4w1")){
  dir.create("./Documents/Coursera/Project4w1")
}
setwd("./Documents/Coursera/Project4w1")

# Download zip file from website and unzip.
fileURL <- "https://d396qusza40orc.cloudfront.net/
sexdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "electric.zip")
unzip("electric.zip")

# Read unzipped text file into R table and create subset by date.
hpc <- read.table("household_power_consumption.txt", 
                  header = TRUE, sep = ";")
hpc <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")

# Convert Date and Time characters into Date and POSIXlt format.
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, format = "%H:%M:%S")

# Assign dates to times so they show up as days of the week.
hpc[1:1440, "Time"] <- format(hpc[1:1440, "Time"],
                              "2007-02-01 %H:%M:%S")
hpc[1441:2880, "Time"] <- format(hpc[1441:2880, "Time"], 
                                 "2007-02-02 %H:%M:%S")

par(mfcol = c(2, 2))

# Plot 1st graph (from plot2.R) for global active power
# in upper left-hand corner
plot(hpc$Time,as.numeric(as.character(hpc$Global_active_power)),
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Plot 2nd graph (from plot3.R) in lower left-hand corner
plot(hpc$Time,as.numeric(as.character(hpc$Sub_metering_1)),
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
with(hpc, lines(Time, as.numeric(as.character(Sub_metering_2)), 
                col = "red"))
with(hpc, lines(Time, as.numeric(as.character(Sub_metering_3)), 
                col = "blue"))
legend("topright",
       lty = 1,
       box.lty = 0,
       cex = 0.5,
       legend = names(hpc)[7:9],
       col = c("black", "red", "blue"))

# Plot 3rd graph for voltage using same template as 1st.
plot(hpc$Time,as.numeric(as.character(hpc$Voltage)),
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Plot 4th graph for global reactive power using same template
# as 1st and 3rd.
plot(hpc$Time,as.numeric(as.character(hpc$Global_reactive_power)),
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# Export plot to png file.
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()