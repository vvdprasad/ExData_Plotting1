plot1.R <- function() {
#   This function creates the Plot 1 as specified in the Course Project 1 for
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
    
    # Histogram for Global Active Power
    par(mfrow = c(1,1))
    hist(requiredData$Global_active_power, col="red", 
         main="Global Active Power", 
         xlab="Global Active Power (kilowatts)")
    
    # Copy the Histogram to PNG file in working directory
    dev.copy(png, file="plot1.png", width=480, height=480)
    dev.off()
}