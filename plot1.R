# Coursera assignment Cours4 sem1
# plot household_power_consumption Global active power

# read files from from the dates 2007-02-01 and 2007-02-02


library("dplyr")
getwd()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "exdata_data_household_power_consumption.zip"
if(!file.exists("./exdata_data_Fhousehold_power_consumption.zip")) {
  download.file(fileUrl,
                destfile,
                mode="wb") # "wb" means "write binary," and is used for binary files
  
}
list.files()
if(!file.exists("./household_power_consumption.txt")) {
  unzip(zipfile = "exdata_data_Fhousehold_power_consumption.zip") # unpack the files into subdirectories 
}

# col names for 
coln <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# read household_power_consumption.txt
dataf1 <- read.table("household_power_consumption.txt", header = FALSE, sep = ';', skip=21997,nrows=2880)
colnames(dataf1) <- coln
dataf1 <- arrange(dataf1, Date, Time)
grep("\\?", dataf1)
which(is.na(dataf1))
head(dataf1, 10)
table(dataf1$Global_active_power)
range(dataf1$Global_active_power)

# draw plot1 & save it to png 480 x 480
dev.cur()
png(file="plot1.png", width=480, heigth=480)
gap <- dataf1$Global_active_power
hist(gap, col="red", main="Global active power", breaks = c(0,1,2,3,4,5,6,7,8,9,10), xlim=c(0.1,4), ylim=c(0,1200), xlab = "Global active power (kilowatts)") 
hist(gap, col="red", main="Global active power", breaks = 10, xlim=c(0.1,4), ylim=c(0,1200), xlab = "Global active power (kilowatts)") 
dev.off()