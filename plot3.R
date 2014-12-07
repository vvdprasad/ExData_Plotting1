plot3.R <- function() {
#   This function creates the Plot 3 as specified in the Course Project 1 for
#   Exploratory Data Analysis
    
    # Read the CSV file. Instead of reading the entire data, read only the 
    # data for 02/01/2007 and 02/02/2007. 
    # Using a sed command to filter the required data from the data file.
    # If this code is to be run on Windows OS, then please install GNU Unix 
    # Utils (http://unxutils.sourceforge.net/UnxUpdates.zip) and update the 
    # path environment variable to include the Unix Utils.Restart R/RStudio 
    # after updating the environment variable.
    
    # It is assumed that the data file is available in the working directory
    
    requiredData<-read.csv(pipe('sed -n "/^[12]\\/2\\/2007/p" household_power_consumption.txt'), 
                           sep=";", header=F, na.strings="?")
    
    # Get the column headers from data file
    header<-read.csv(file="household_power_consumption.txt", 
                     nrows=1, header=F, sep=";")
    
    # Merge the Date and Time columns into a single column and convert 
    # that field to Date Time type
    requiredData<-cbind(strptime(apply(requiredData[, 1:2], 1, 
                                       function(x) paste(x, collapse=" ")),
                                 format="%d/%m/%Y %H:%M:%S"), 
                        requiredData[,3:9])
    
    # Set the column names for the data
    names(requiredData) <- c("Date_Time", t(header[,3:9]))
    
    # Generate the plot
    par(mfrow = c(1,1))
    plot(requiredData$Date_Time, 
         requiredData$Sub_metering_1, 
         type="n", 
         ylab="Energy sub metering", 
         xlab="")
    lines(requiredData$Date_Time, 
          requiredData$Sub_metering_1,
          type="l", 
          col="black")
    lines(requiredData$Date_Time, 
          requiredData$Sub_metering_2, 
          type="l", 
          col="red")
    lines(requiredData$Date_Time, 
          requiredData$Sub_metering_3, 
          type="l", 
          col="blue")
    legend("topright", 
           lty="solid", 
           col=c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    dev.copy(png, file="plot3.png", width=480, height=480)
    dev.off()
}