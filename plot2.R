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

# draw plot2 & save it to png 480 x 480
# date & time
mydate_str <- data.frame(paste(dataf1$Date, " ", dataf1$Time))
head(mydate_str,10)
colnames(mydate_str) <- "dats"
mydate_d <- data.frame(strptime(mydate_str[,"dats"],
                                format = "%d/%m/%Y %H:%M:%S"))
colnames(mydate_d) <- "dats"
head(mydate_d)
as.Date(mydate_d[2,"dats"])
ddat <- data.frame(as.POSIXct(mydate_d[,"dats"], format = "%Y/%m/%d %H:%M:%S"))
colnames(ddat) <- "dats"
head(ddat)

# plot2
dev.cur()
png(file="plot2.png", width=480, height=480)
gap <- dataf1$Global_active_power
plot(ddat, gap, ylim=c(0,5), type="o", pch=".", ylab = "Global active power (kilowatts)")
dev.off()