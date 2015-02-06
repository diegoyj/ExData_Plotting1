# Note: copy the file ""household_power_consumption.txt" to the working directory

# Get the path to the file. Assume that is in the working directory
working_directory <- getwd()
file <- "household_power_consumption.txt"  
path <- paste(working_directory, file, sep = "/") 

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

# Create plot and send to a file (no plot appears on screen)
with(sample, plot(Datetime, Global_active_power, 
                  ylab = "Global Active Power (Kilowatts)",
                  xlab = "",
                  type = "l",
                  ))

# Copy my plot to a PNG file in the working directory
dev.copy(png, file = "plot2.png", width = 480, height = 480)

## Close the PNG file device
dev.off()
