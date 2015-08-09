plot4 <- function(FILEDIR = getwd(), METHOD = "curl"){
    ## download file from source
    FILEDIR <- paste(FILEDIR,"exdata-data-household_household_power_consumption.zip", sep = "/")
    if(!file.exists("household_power_consumption.txt")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,FILEDIR,method = METHOD)
    }
    ## Load the data in to R
    DATA <- read.table(file = unzip(zipfile = FILEDIR), header = TRUE, sep = ";", 
                       colClasses = c("character","character",rep("numeric",7)),
                       na.strings = "?")
    
    ## subset only February 1 and February 2, 2007
    DATA <- subset(DATA, DATA$Date == "1/2/2007" | DATA$Date == "2/2/2007")
    x <- paste(DATA$Date,DATA$Time,sep = " ")
    x <- strptime(x, format = "%d/%m/%Y %H:%M:%S")
    
    ## create plots
    ## Export to png
    ExFILEDIR <- paste(getwd(),"plot4.png", sep ="/")
    
    png(filename = ExFILEDIR, width = 480, height = 480, units = "px")
    par(mfrow=c(2,2))
    with(DATA, {
        plot(x, DATA$Global_active_power, type = "l", xlab="", ylab = "Global Active Power")
        plot(x, DATA$Voltage, type = "l", xlab="datetime",ylab="Voltage")
        plot(x,DATA$Sub_metering_1,ylab="Energy sub metering", type="l",xlab="")
        lines(x,DATA$Sub_metering_2,type="l",col="red")
        lines(x,DATA$Sub_metering_3,type="l",col="blue")
        legend("topright",lty = "solid", col = c("black","red","blue"), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")
        plot(x, DATA$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
        
    })
    dev.off()
}