defaultdir <- getwd()

if (!file.exists("data")){
  dir.create("data")
}
setwd("./data")

if (!file.exists("household_power_consumption.txt")){
  fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,"temp.zip")
  unzip("temp.zip", "household_power_consumption.txt")
}
#memory required = no. of column * no. of rows * 8 bytes/numeric 
#The dataset has 2,075,259 rows and 9 columns
paste("Memory required is: ",2075259*9*8,"bytes")

my_data <- read.table("household_power_consumption.txt", header=TRUE,sep=";",comment.char = "",na.strings="?",
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" ))
x <- subset(my_data,my_data$Date=="1/2/2007"|my_data$Date=="2/2/2007")
x$datetime <- as.Date(x$Date, "%d/%m/%Y") 
x$datetime <- as.POSIXlt(paste(x$datetime,x$Time))

setwd(defaultdir)
png(filename = "plot4.png",width = 480, height = 480)
  par(mfcol=c(2,2))
  plot(x$datetime,x$Global_active_power,type="l",ylab ="Global Active Power",xlab="")
  with(x,plot(datetime,Sub_metering_1,type="l",xlab="",ylab ="Energy sub metering"))
  with(x,points(datetime,Sub_metering_2,type="l",col="red"))
  with(x,points(datetime,Sub_metering_3,type="l",col="blue"))
  legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c('black','red', 'blue'),bty = "n")
  with(x,plot(datetime,Voltage,type="l"))
  with(x,plot(datetime,Global_reactive_power,type="l"))
dev.off()