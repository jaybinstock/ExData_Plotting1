setwd("C:\\Users\\jay\\Documents\\R")

sampleData = read.table("./Exploratory Data Analysis/Project 1/household_power_consumption.txt", header = T, sep = ";", nrows = 5) # read sample rows for format
powerData.raw = read.table("./Exploratory Data Analysis/Project 1/household_power_consumption.txt", header = T, sep = ";", colClasses = rep("factor", ncol(sampleData)))
powerData = powerData.raw # keep original object untouched
powerData$Date = as.Date(powerData$Date, format = "%d/%m/%Y") #format dates as dates

powerData = powerData[powerData$Date == "2007-02-01" | powerData$Date == "2007-02-02", ] #subset dates
powerData$Time = strptime(paste(powerData$Date,powerData$Time), format="%Y-%m-%d %H:%M:%S") #format Time as Date/Time

for(i in 3:9){
     powerData[ , i] = as.numeric(as.character(powerData[ , i])) # change formats to numeric
}

#create plot routine
png("plot4.png", width=480, height=480) #create png
par(mfrow = c(2,2)) #set to print 2x2 plots per page

#first plot
with(powerData, plot(Time, Global_active_power, 
                     type = "l",
                     xlab = "",
                     ylab = "Global Active Power"))

#second plot
with(powerData, plot(Time, Voltage, 
                     type = "l",
                     xlab = "datetime",
                     ylab = "Voltage"))

#third plot
with(powerData, plot(Time, Sub_metering_1, 
                     type = "l",
                     xlab = "",
                     ylab = "Energy sub metering"))
with(powerData, lines(Time, Sub_metering_2, type = "l", col = "red"))
with(powerData, lines(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", bty ="n", legend = colnames(powerData)[7:9],
       lty = c( 1,1,1),             
       col = c("black", "red", "blue"))

#fourth plot
with(powerData, plot(Time, Global_reactive_power, 
                     type = "l",
                     xlab = "datetime"))


dev.off()