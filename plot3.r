# Run the script at R Command Prompt > source("plot3.R)
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

##Filter and Store  only those rows which are for dates "2007-02-01" and "2007-02-02" using  subset function
mydata<- subset(dataset, Date >="2007-02-01" & Date <="2007-02-02")

## Here we are adding a new column "Datetime" in the dataframe .
## Combine the values of "Date" and "Time" columns and assign it to the column "Datetime".
mydata["Datetime"]<- NA
mydata<- transform(mydata, Datetime= as.POSIXct(Datetime))
mydata$Datetime <- strptime(paste(mydata$Date, mydata$Time), format="%Y-%m-%d %H:%M:%S")

## Open png graphic device
png(filename="plot3.png", width=480, height=480, units="px",type="windows")

## Creating three Line plots
with(mydata, {
  plot(Datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(Datetime, Sub_metering_2, col="red")
  lines(Datetime, Sub_metering_3, col="blue")
})
## Add Legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2, col=c("black","red","blue"))

## Close Graphic Device
dev.off()
