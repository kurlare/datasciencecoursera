
## Read text file, retain headers and adjust for separating value, NA's.
power_df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Create empty data.table, fill with all rows for relevant dates and remove NA's.  
power_usage <- data.table()
power_usage <- rbind(power_df[power_df$Date == "1/2/2007",], power_df[power_df$Date == "2/2/2007",])
power_usage <- na.omit(power_usage)


## Combine Date & Time variables into one column and change class.
power_usage$Date <- dmy(power_usage$Date)
power_usage <- unite(power_usage, col = "Date.Time", Date, Time, sep = "_")
power_usage$Date.Time <- ymd_hms(power_usage$Date.Time)
power_usage$Date.Time <- as.POSIXct(power_usage2$Date.Time)

## Create one graphic with four plots.
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0,0,0,0)) 
with(power_usage, {
    plot(power_usage$Date.Time,power_usage$Global_active_power, 
         type = "l", xlab = "", ylab = "Global Active Power")
    plot(power_usage$Date.Time, power_usage$Voltage, 
         type = "l", xlab = "datetime", ylab = "Voltage")
    plot(power_usage$Date.Time, power_usage$Sub_metering_1, type = "l", 
         col = "black", xlab = "", ylab = "Energy sub metering")
    lines(power_usage$Date.Time, power_usage$Sub_metering_2, type = "l", col = "red")
    lines(power_usage$Date.Time, power_usage$Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
    plot(power_usage$Date.Time, power_usage$Global_reactive_power, 
         type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    
})

## Create plot4.png file in working directory.
png(filename = "plot4.png")
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0,0,0,0)) 
with(power_usage, {
    plot(power_usage$Date.Time,power_usage$Global_active_power, 
         type = "l", xlab = "", ylab = "Global Active Power")
    plot(power_usage$Date.Time, power_usage$Voltage, 
         type = "l", xlab = "datetime", ylab = "Voltage")
    plot(power_usage$Date.Time, power_usage$Sub_metering_1, type = "l", 
         col = "black", xlab = "", ylab = "Energy sub metering")
    lines(power_usage$Date.Time, power_usage$Sub_metering_2, type = "l", col = "red")
    lines(power_usage$Date.Time, power_usage$Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
    plot(power_usage$Date.Time, power_usage$Global_reactive_power, 
         type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()