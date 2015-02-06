# Note: copy the file ""household_power_consumption.txt" to the working directory

# Get the path to the file. Assume that is in the working directory
working_directory <- getwd()
file <- "household_power_consumption.txt"  
path <- paste(working_directory, file, sep = "/") 

# Check if the file exists in the working directory
if (!file.exists(path)) {
  stop("The file is not available")
} else {
    
  # Read from local file
  population <- read.csv2(path, header = TRUE, sep = ";", na.strings = "?",
                          colClasses=c("character","character","character",                        
                                       "character","character","character",
                                       "character","character"))
  
  #Transform the character values to a Date format. 
  population$Date<- as.Date(population$Date, "%d/%m/%Y")
  
  # Getting the subset data frame where Date = 2007-02-01 or 2007-02-02
  sample <- subset(population, Date == "2007-02-01" | Date == "2007-02-02")
  rm(population)
  
  #Add a column with the DateTime Values 
  sample$Datetime <- strptime(
    x = paste(
      sample$Date, sample$Time), 
    format = "%Y-%m-%d %H:%M:%S")
  
  # Transform the character vector Global_active_power in a numeric one.
  # Now We can work with the function hist()
  sample$Global_active_power<- as.numeric(sample$Global_active_power)
  
  # Create plot and send to a file (no plot appears on screen)
  with(sample, hist(sample$Global_active_power,
                    main = "Global Active Power",
                    xlab = "Global Active Power(kilowatts)", 
                    ylab = "Frequency",
                    col = "Red"))
   
  # Copy my plot to a PNG file in the working directory
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  
  # Close the PNG file device
  dev.off()
}






