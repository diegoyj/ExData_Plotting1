# Note: copy the file ""household_power_consumption.txt" to the working directory

# Get the path to the file. Assume that is in the working directory
working_directory <- getwd()
file <- "household_power_consumption.txt"  
path <- paste(working_directory, file, sep = "/") 

# Check if the file exists in the working directory
if (!file.exists(path)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url = url, destfile = "./data_household_power_consumption.zip", method = "curl")
  unzip(zipfile = "./data_household_power_consumption.zip")
  
}   
  # Read from local file
  population <- read.csv2(path, header = TRUE, sep = ";", na.strings = "?",
                          colClasses=c("character","character","character",                        
                                       "character","character","character",
                                       "character","character"))
                          
  
  #Transform the character values to a Date format. 
  population$Date<- as.Date(population$Date, "%d/%m/%Y")
  
  # Getting the subset data frame where Date = 2007-02-01 and 2007-02-02
  sample <- subset(population, Date == "2007-02-01" | Date == "2007-02-02")
  rm(population)
  
  #Add a column with the DateTime Values 
  sample$Datetime <- strptime(
    x = paste(
      sample$Date, sample$Time), 
    format = "%Y-%m-%d %H:%M:%S")
  
  # Open the png device and starts to plot in it.
  png(filename = "plot3.png", height = 480, width = 480, units = "px")
  
  # Create plot and send to a file (no plot appears on screen)
  with(sample,{
    plot(Datetime, Sub_metering_1, 
         ylab = "Global Active Power (Kilowatts)",
         ylim = c(0, 40),
         xlab = "",
         type = "l",
         col = "black",
    )
    lines(Datetime, Sub_metering_2, col = "red")
    lines(Datetime, Sub_metering_3, col = "blue")
  })
      
  legend("topright",
         col = c("black","red","blue"),
         lty = 1,
         legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
         )

  ## Close the PNG file device
  dev.off()