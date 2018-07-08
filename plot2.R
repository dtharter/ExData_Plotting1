# Plot 2: Global Active Power Over Time Line Plot
# David Harter
#
# This script will create a line plot of Global Active Power
# as a function of time for February 1 and 2, 2007.


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

# Plot with specified attributes.
plot(hpc$Time,as.numeric(as.character(hpc$Global_active_power)),
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Export plot to png file.
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()