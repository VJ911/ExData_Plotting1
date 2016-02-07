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

setwd(defaultdir)
png(filename = "plot1.png",width = 480, height = 480)
  with(x,hist(Global_active_power,col="red",xlab ="Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()