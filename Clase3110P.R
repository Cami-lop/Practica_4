getwd()
require(ncdf4)
library(ncdf4) #cargo libreria ncdf4
archivo <- ("/home/clinux01/Escritorio/Cami_Labo/Practica_4/datos-20231031T140954Z-001/datos/air.mon.mean.nc") #donde esta el archivo
nc<- nc_open (archivo) #abro el archivo netCDF
nc
# Si queremos extraer la variable Monthly Mean Air Temp:
temp_aire<- ncvar_get(nc, "air")
#Miro de que clase y las dimensiones de los datos
class(temp_aire) # es un array
dim(temp_aire) # 144(lon), 73(lat), 884(time)

#Si queremos extraer la variable Monthly Mean Air Temp:
latitudes<- ncvar_get(nc, "lat") #prestar atencion en como esta escrito en el archivo 
longitudes<- ncvar_get(nc, "lon")
tiempos<- ncvar_get(nc, "time")
head(tiempos) #veo los primeros datos de tiempo para ver com ol estan "configurados"// o son  muy representativos de la fecha
#ver unidades de tiempo<- en este caso es horas
tiempos_legibles<- as.Date(tiempos/24,origin="1800-01-01") #como está en horas lo divido por 24
head(tiempos_legibles) 
tail (tiempos_legibles) #miro l.os ultimos

#Ahora lo hago con lubridate 
library(lubridate)
#miramos los primeros meses
head(months(tiempos_legibles))

#Con esta función podemos seleccionar de nuestro array los datos que son del mes de marzo:
datos_temp_marzo <- temp_aire[, , months(tiempos_legibles) == "marzo"]
dim(datos_temp_marzo) #tengo las 144 lon, 73 lat y 74 tiempos que corresponden a los datos de marzo
# una forma de hacer subset de mis datos 

library(udunits2)
require(udunits2)
library(metR)
require(metR)

GlanceNetCDF(archivo) #Vemos lad dimensiones del archivo con la función GlanceNetCDF

datos <- ReadNetCDF(archivo, vars = "air") #abro los datos
head(datos) #miro las primeras filas
dim(datos)  #calculo las dimensiones

datos_region<- ReadNetCDF(archivo, vars = "air",
                          subset = list(lat = c(-65, -20),
                                            lon = c(280, 310)))  #especifico los dats que quiero leer 
#Ejercicio en clase
library(lubridate)
archivo <- ("C:/Users/camil/OneDrive/Escritorio/Cami_Labo/Practica_4/datos-20231031T140954Z-001/datos/datos_u850.nc") #donde esta el archivo
nc<-nc_open(archivo) #abro el archivo netCDF
nc

#Me quedo con las variables
comp_u_850<- ncvar_get(nc, "ua850") #extraer la variable
latitudes<- ncvar_get(nc, "lat")
longitudes<- ncvar_get(nc, "lon")
tiempos<- ncvar_get(nc, "time")
tiempos_legibles<- as.Date(tiempos,origin="1949-12-01 00:00:00")
#va del 2005 al 2010
head(tiempos_legibles) #miro los primeros tiempos
tail (tiempos_legibles) #miro los ultimos tiempos

#selecciono donde esta la cuenca del plata  (38.75S-23.75S; 64.25O-51.25O)
long_cuenca<-which(longitudes %in% -64.25:-52.25 )
lat_cuenca<-which(latitudes %in% -38.75:-23.75)

anios<-2005:2010
datas<-array(data=NA,dim=c(13,16,6))
i<-1
for(anio in anios){
  viento<-comp_u_850[long_cuenca,lat_cuenca,which(year(tiempos_legibles)==anio)]
  promedio<-apply(viento,c(1,2), mean)
  datas[,,i]<-(promedio)
    i<-i+1
}
prom_anual<-apply(datas,c(3),mean)
promedio_df<-data.frame(prom_anual)
