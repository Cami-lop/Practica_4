# # Laboratorio de Procesamiento de Informaci???n Meteorol???gica/Oceanografica
# 2??? cuatrimestre 2022           # Clase NCDF 2             
##################################################################

getwd()
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4/")
require(ncdf4)
require(lubridate)

OUTPUTS<- ("/home/clinux01/Escritorio/CamiLabo/Practica_4/")

lon <- seq(270,320,5)
lats<-seq(-10,-50,-5)

length(lon)
length(lats)

Months<-as.numeric(seq(as.Date("1979/1/1"), by= "month", length.out= 432))
#as.date lo codifica en fecha, arranca en 1979 en enero va cada un mes y tienen un largo de 432
Months
#as.date tiene "ciertos" errores( siempre esta en dias a pesar de que pongo meses),hay que poner donde inicializa son la funcion ymd_hms 
#creo las dimensiones para luego crear mi variable
#correcion script cande o profe
dimX<- ncdim_def( "long", "degrees", lon)
dimY<- ncdim_def ( "lat", "degrees", lats )
dimT<- ncdim_def( "Time", "days", Months, unlim=TRUE )

#variable generada solo la cascara ( no tengo valores aun )
var1d <- ncvar_def("mslp", units= "hPa", longname= "mean sea level pressure",
                   dim= list(dimX,dimY,dimT), missval= -999, prec="double",verbose=TRUE )
#nc_create es para crear, nombre y la lista de las variables que creamos antes
#1-defini dimensiones
#2-defini variables 
#3-define la "caja (nc)" para guardar los datos/valores
nc<- nc_create(paste(OUTPUTS,"mslp_hPa.nc",sep=""), list(var1d) ) #por deafult es falso 
#lat*lon*tiempo=42768 / tengo 432 mapas de 11*9
MSLP<-runif(42768) #valores que van dentro de la "caja"

#ncvar_put para guardar los valores donde quierp
ncvar_put(nc,var1d,MSLP) #nombre del archivo/ variables /datos que voy a guardar

nc_close(nc) #cierro el archivo  para que se genere
## ABRIR lo que guardamos ##

rm(list=ls())
require(ncdf4)
require(lubridate)
nc<-nc_open("home/clinux01/Escritorio/CamiLabo/Practica_4/mslp_hPa.nc") #hay que poner el nombre del archivo que creamos y guardamos 
nc
class(nc)

presion<-ncvar_get(nc,varid="mslp") 

Longitud<-ncvar_get(nc,varid="long")
Latitud<-ncvar_get(nc,varid="lat")
Time<-ncvar_get(nc,varid="Time")

class(presion)
class(Longitud)
class(Latitud)

class(Time)

head(Time) #primeros 6 valores de Time por pantalla pero no me gusta como esta, esta mal generado porque falta informacion 

fecha<-ymd_hms ("1970-1-1 00:00:00") + days(Time) 

head(fecha)
tail(fecha)


presion[2,2,3]
