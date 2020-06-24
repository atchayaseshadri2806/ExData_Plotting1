##GETTING DATA
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

##CLEANING DATA
## Format date column to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")
## Subset data set from Feb. 1, 2007 to Feb. 2, 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2")) 
## Remove incomplete observation
data <- data[complete.cases(data),]
## Combine Date and Time column
dateTime <- paste(data$Date, data$Time)
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
## Remove Date and Time column
data <- data[ ,!(names(data) %in% c("Date","Time"))]
## Add DateTime column
data <- cbind(dateTime, data)
## Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

##PLOTTING DATA
##Plot 1
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
##Saving to file:
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
