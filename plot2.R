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

png("plot2.png", width=480, height=480)
with(powerData, plot(Time, Global_active_power, 
                     type = "l",
                     xlab = "",
                     ylab = "Global Active Power (kilowatts)"))
dev.off()