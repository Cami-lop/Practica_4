#################################################
# ejemplo12.R
# Laboratorio de Procesamiento de Informaci?n Meteorol?gica
# 2? cuatrimestre 2019
################################################# 

#Cargar datos en formato binario!
#1) Leer el archivo de temperaturas de superficie del mar
#                  SST_19821999.T42.grd
#escrito en formato binario de acceso directo, proveniente de 
#una architectura big endian.!
#El header!
#             SST_19821999.T42.ctl
#en el directorio DATA, nos da ulterior informanci?n: 
#el archivo contine datos medios mensuales del Hadley Centre 
#(periodo 1982-1999), en una grilla Gausseana T42, con 
# valores indefinidos expresados por el entero negativo -32768.0
 
# 2) Corroborar su lectura del archivo ploteando la matriz de datos
  
# Limpio el espacio de trabajo
rm(list=ls())
getwd()
datos="/home/clinux01/Descargas/CamiLabo/Practica_4/SST_19821999.T42.grd"

# Hago el open del file a leer
fid=file(datos,'rb') #permiso para poder leer
fid

# Defino variables, saco esta info del documento al que entramos antes
nx=128; #longitudes , numero de pixeles para una grilla de tipo T42
ny=64; #lat
itt=216; #12 meses * 18 anios (1982 a 1999)
undef=-32768.0;


# inicializo la matriz donde voy a poner los datos
sst=matrix(0,nrow=nx*ny,nco=itt)  #matriz llena de cero, filas de 128*64, columnas = cada mes
sst
for (it in 1:itt){
it
sst[,it]=readBin(fid,numeric(),size=4,nx*ny,endian="swap")
}
#it se meueve en los 216
#en la columna it en cada fila quiero que lea cada punto de reticula
#el primes mes lo almacena en la primer columna en nx*ny y asi, suucesivamente
close(fid)

class(sst)
dim(sst) #filas 8192(puntos de reticula) / columna 216 (tiempo)

# lo pienso como serie temporal (evolucion de un punto en el tiempo)
sst_punto= sst[5580,] #fijo una fila
plot(1:216,sst_punto,'l',col='red') #grafico de la fila que guarde, serie tempo de un punto de reticula en especifco 


# lo pienso como campos espaciales (comportamiento en todos los puntos en un tiempo)

# Enmascaro los valores indefinidos (que son los continentes)
sst[sst==undef]=NA; #son todos NA los datos faltantes, va al comienzo

# Expreso como arreglo tridimensional
sst2=array(sst,dim=c(nx,ny,itt))   #cambio las dimensiones para sacrme de encima las 8192 filas
#tengo campos ahora que reacomede las dimensiones
ls.str()
sst2
# Verifico la lectura ploteando la matriz en el tiempo 1
contour(sst2[,,1]) #los valores donde no hay nada son los dtos de los continentes y yo quiero temp en sup oceanica
#mantengo fija lon y lat en el tiempo 1
# y en otros tiempos ... 216 y 50 
contour(sst2[,,216])
contour(sst2[,,50])

#calculo la media de todos los valores

media<-apply(sst2,c(1,2),mean) #desaparecen los tiempos
contour(media)

anio<-itt/12 #18 años
#cambio dimesiones
meses<-array(sst2,dim=c(nx,ny,12,anio))   #guardo doce por año, el corte del 216 es doce para diferenciar cada año
dim(meses) #long/lat/meses/año

mediamensual<-apply(meses,c(1,2,3),mean)
dim(mediamensual) #campos de prom mensual

#graficos 12 campos
for(mes in 1:12){
  contour(mediamensual[,,mes])
title(main=paste0("mes",mes))
}

plot(mediamensual[52,35,],type="l") #para un punto de reticula especifico

media_anual<-apply(meses,c(1,2,4),mean)
dim(media_anual)

#graf valores medios anuales 

plot(media_anual[52,35,],type="l",col="blue")
