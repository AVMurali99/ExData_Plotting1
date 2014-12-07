plot2 <- function() {
  ## Reading just the first few rows and getting the column names
  Data4ColumnNames <- fread("C:/Users/ASHA/Desktop/Coursera/household_power_consumption.txt",
                            nrow = 5)
  ColumnNames <- names(Data4ColumnNames)
  
  ## Now reading in only the data that is needed by skipping until the string 
  ## "1/2/2007" is encountered in the file and then reading the next 2880 lines 
  ## from the file since there are those many minutes in 2 days.
  data <- fread("C:/Users/ASHA/Desktop/Coursera/household_power_consumption.txt",
                sep = ";", nrows = 2880, header = FALSE, na.strings = "?", 
                skip = "1/2/2007", colClasses = c("character", "character", 
                                                  rep("numeric",1,7)))
  setnames(data, names(data), ColumnNames)
  
  ## Adding a new column that has the combined string from Date and Time columns
  data[,CharDate_Time:= paste(Date,Time, sep=" ")] 
  
  ## Adding another column that has the above CharDate_Time string convereted 
  ## into the proper date and time format
  data[,Date_Time:= as.POSIXct(CharDate_Time, format = "%d/%m/%Y %H:%M:%S")]
  
  ## opening the png graphic device and then plotting Date_Time vs Global Active Power
  png(filename = "plot2.png")
  data[,plot(Date_Time, Global_active_power, type = "l", xlab = " ", 
             ylab = "Global Active Power (kilowatts)")]
  dev.off()
}
