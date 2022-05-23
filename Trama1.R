# Usamos el paquete data.table
library("data.table")

setwd("D://Data//datosElec")

#Lee los datos del archivo y luego los subconjunta para las fechas especificadas
podt <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")
#Evita que el histograma se imprima en notación científica
podt[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Cambiar la columna de fecha por el tipo de fecha deseado 
podt[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#Fechas de filtrado para 2007-02-01 y 2007-02-02
podt <- podt[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Abrimos para imprimir el trama 1
png("trama1.png", width=480, height=480)

## Trama 1
hist(podt[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()