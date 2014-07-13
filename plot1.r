# Run the script at R Command Prompt > source("plot1.R")
# This script downloads the zipped file "household_power_consumption.zip" if it is not present in the current working directory and
# extract/unzip the zipped file to "household_power_consumption.txt". If the file "household_power_consumption.zip" is present
# in the current working directory, it just extract/unzip the zipped file to "household_power_consumption.txt".
# It reads the text file in a data frame and ultimately creates plot in a PNG file.

if(!file.exists("household_power_consumption.zip")) {
  # Download and unzip if zipped file not present in the current working directory
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url, "household_power_consumption.zip", mode ='wb') 
  unzip("household_power_consumption.zip", exdir = ".")
  
} else { 
  # Only unzip, if zipped file present in the current working directory
  unzip("household_power_consumption.zip", exdir = ".")
}


## Reads the text file and store it in data frame
dataset<-read.table("household_power_consumption.txt", header= T, sep=';', na.string ="?")

## convert the Date column in the given format using as.Date()
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

##Filter and Store  only those rows which are for dates  "2007-02-01" or "2007-02-02" using  subset function
mydata<- subset(dataset, Date >="2007-02-01" & Date <="2007-02-02")


##Plot histogram - Global_active_power
hist(mydata$Global_active_power, main="Global Active Power", xlab="Global Active Power(kilowatts)", col="red")

## copy to png file
dev.copy(png, file="plot1.png", width=480, height=480, units="px")

# Close graphic device 
dev.off()
