############# Clase Practica 3/10  archivo binario ############
#archivo binario: archivo que contiene información de cualquier tipo codificada en bytes con el propósito de almacenar y procesar datos en computadoras.

#Lectura: readBin(archivo, clase, longitud, formato_maquina,tamaño)
#Escrtitura: writeBin(variable, archivo, tamaño, longitud,formato_maquina)
#el ctl tienne la informacion de como esta organizados los datos del archivo data.r4 en este caso


getwd()
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4")
#Pag 5 carac sobre archivos binarios
#Trabajamos con data.ctl
#primero lo abro con un edior de texto y el archivo me muestra la informacion
nlat <- 181 #cantidad total de la dimension y (o latitudes)
nlon <- 360 #cantidad total de la dimension x (o longitudes)
ntiempos<- 348 #cantidad total de la dimension time (tiempos)
nnivel<- 1 #cantidad total de la dimension z (o niveles)
nvar <- 1 #Cantidad total de variables
dato_faltante<- -999
## N que va a ser longitud del vectorque voy a leer del binario
N<- nlat*nlon*ntiempos*nnivel*nvar  #produc entre todas mis dimensiones

## antes defino la ruta donde esta el archivo
archivo <-"/home/clinux01/Escritorio/CamiLabo/Practica_4/datos-20231003T140526Z-001/datos/data.r4"
# ahora si abro los datos
datos<- readBin(archivo, "numeric", n = N, endian = "big",
                size = 4)
length(datos)
datos[which(datos== dato_faltante)] <- NA
# Armo el array teniendo en cuenta que la primer dimension
# tiene que ser la de las longitudes
# Luego las latitudes y luego el tiempo
datos_array<- array(data = datos, dim = c(nlon, nlat, ntiempos)) #siempre empiezo de lo + chiquito
dim(datos_array)

#creo el vector latitudes
latitudes <- seq(-90,90,1)
#chequeo que tenga como longitud 181
length(latitudes)
#creo el vector latitudes
longitudes <- seq(0,359,1)
#chequeo que tenga como longitud 181
length(longitudes)
datos_array
#Ejemplo pag 13
#Argentina. Las latitudes de Argentina: -55°S a -20° S
#Longitudes : -75°O a -50°O (o tambien 285° a 310°)
prom_temp<-apply(datos_array,c(1,2), mean)
lat_inicio<-which(latitudes==-55)
lat_final<-which(latitudes==-20) 
lat_arg<- which(latitudes %in% -55:-20)
long_inicio<-which(longitudes==285)
long_final<-which(longitudes==310)
long_arg<-which(longitudes %in% 285:310)
datos_arg<-datos_array[long_inicio:long_final,lat_inicio:lat_final,]  #me faltaba el tiempo

#ej pag 14
argentina<-array(datos_arg,dim=c(26,36,12,29))
dim(argentina)
prom_anual_arg<- apply(argentina,c(1,2,4),mean)


#ejercicio pag 15
rm(list=ls())
## antes defino la ruta donde esta el archivo
archivo <-"/home/clinux01/Escritorio/CamiLabo/Practica_4/datos-20231003T140526Z-001/datos/SepIC_nmme_tmpsfc_anom_stdanom.dat"
nlat <- 181 #cantidad total de la dimension y (o latitudes)
nlon <- 360 #cantidad total de la dimension x (o longitudes)
ntiempos<- 6 #cantidad total de la dimension time (tiempos)
nnivel<- 1 #cantidad total de la dimension z (o niveles)
nvar <- 4 #Cantidad total de variables
dato_faltante<- -9.999E+20
## N que va a ser longitud del vectorque voy a leer del binario
N<- nlat*nlon*ntiempos*nnivel*nvar  #produc entre todas mis dimensiones
# ahora si abro los datos
datos<- readBin(archivo, "numeric", n = N, endian = "big",
                size = 4)

#SELEC LA VARIABLE ANOMALIA PARA DICIEMBRE 2020
datos[which(datos== dato_faltante)] <- NA
datos_array<- array(data = datos, dim = c(nlon, nlat, ntiempos,nvar))
dim (datos_array)
tiempo<-seq(1,6,by=1)
variables<-seq(1,4,by=1)
T_diciembre<-which(tiempo==3)
anomalia<-which(variables==3)
diciembre<-datos_array[long_arg,lat_arg,T_diciembre,anomalia]
