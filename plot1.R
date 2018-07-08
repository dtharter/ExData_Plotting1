# Plot 1: Frequency of Global Active Power Histogram
# David Harter
#
# This script will create a histogram of the frequency of
# Global Active Power for February 1 and 2, 2007.


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

# Create histogram with specified attributes.
hist(as.numeric(as.character(hpc$Global_active_power)), 
     col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Send histogram to png file and close device.
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()