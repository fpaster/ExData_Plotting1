############################ read input data ############################

data <- read.csv(file = "household_power_consumption.txt", sep=";", header = T)

############################ data type conversions ############################
str(data)
dim(data)
# [1] 2075259      10
head(data)
tail(data)

#create a column for both date and time
data$DateTime <- paste(data$Date, data$Time)

# convert the date string into POSIXlt type
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
head(data)
tail(data)

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_intensity <- as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))


############################ subset data to entries from dates 2007-02-01 and 2007-02-02 ############################
start <- strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
end <- strptime("03/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S")

relevant <- (data$DateTime > start & data$DateTime < end)
relevant[is.na(relevant)] <- F

subset <- data[relevant,]

head(subset)
tail(subset)
dim(subset)
# [1] 2879   10

############################ plotting ############################
png("plot2.png", width = 480, height = 480)

Sys.setlocale("LC_TIME","C") #for english daynames
plot(subset$DateTime, subset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
