library("data.table")

setwd("D://Data//data//ExData_Plotting1")

#Lee los datos del archivo y luego los subconjunta para las fechas especificadas
podt <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

#Evita que el histograma se imprima en notación científica
podt[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Hacer que una fecha POSIXct pueda ser filtrada y graficada por la hora del día
podt[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Fechas de filtrado para 2007-02-01 y 2007-02-02
podt <- podt[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#Abrimos para imprimir el trama 4
png("trama4.png", width=480, height=480)

par(mfrow=c(2,2))

# trama 1
plot(podt[, dateTime], podt[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# trama 2
plot(podt[, dateTime],podt[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# trama  3
plot(podt[, dateTime], podt[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(podt[, dateTime], podt[, Sub_metering_2], col="red")
lines(podt[, dateTime], podt[, Sub_metering_3], col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# trama 4
plot(podt[, dateTime], podt[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()