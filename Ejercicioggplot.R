rm(list=ls())
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4/datos-20231031T140954Z-001/datos/air.mon.mean.nc")   
############################### Ejercicio ##############################
library(metR)  #en la compu de la facu no me dejo
require(ncdf4)
#Calcular el promedio de temperatura anual (promedio de los 12 meses del
#año) y graficar la serie resultante con lineas y puntos. Además agregar la
#linea de tendencia lineal.
archivo<-"/home/clinux01/Escritorio/CamiLabo/Practica_4/datos-20231031T140954Z-001/datos/air.mon.mean.nc"
nc<-nc_open(archivo)
nc

temp_aire<- ncvar_get(nc, "air")
latitudes<- ncvar_get(nc, "lat") #prestar atencion en como esta escrito en el archivo 
longitudes<- ncvar_get(nc, "lon")
tiempos<- ncvar_get(nc, "time")
head(tiempos) #veo los primeros datos de tiempo para ver com ol estan "configurados"// o son  muy representativos de la fecha
#ver unidades de tiempo<- en este caso es horas
tiempos_legibles<- as.Date(tiempos/24,origin="1800-01-01") #como está en horas lo divido por 24
head(tiempos_legibles) 
tail (tiempos_legibles) #miro los ultimos

