# ejemplo13
# teorica 13
# Leer datos en formato ascii
#
# CASO 1: matriz numerica cuadrada
# Archivo a leer: Caudales01.txt
# Funcion scan
#
# CASO 2: tabla conteniendo columnas de numeros mas leyendas
# Archivo a leer: Caudales04.txt
# Funcion read.table usando skip
#
# CASO 3:tabla conteniendo columnas de numeros mas leyendas
# Archivo a leer: Caudales04.txt
# Funcion read.table
# Leer los datos de latitud, longitud, altitud y area. Conservarlos como un arreglo 
# numerico para eventualmente operar con ellos.
#

##########################################################

## CASO 1
# Limpio el espacio de trabajo
rm(list=ls())

# Lectura
getwd()
dir_datos="/home/clinux01/Escritorio/CamiLabo/Practica_4/Caudales01.txt"
a<-scan("Caudales01.txt")


## CASO 2

# Limpio el espacio de trabajo
rm(list=ls())
# Leo los datos (el 11 indica cuantas lineas salta antes 
# considerar "dato" los n?neros que encuentra
dir_datos="/home/clinux01/Escritorio/CamiLabo/Practica_4/Caudales04.txt"
datos2=read.table(dir_datos,nrows=24,skip=11)   #leyo 24 despues de 11
datos2
class(datos2)
  
             
# Limpio el espacio de trabajo para estudiar otro ejemplo
# en este caso cambio el ultimo flag (11 a 35)
rm(list=ls())
# Leo los datos (el 36 indica cuantas lineas salta antes de
# considerar "dato" los n?meros que encuentra
dir_datos="/home/clinux01/Escritorio/CamiLabo/Practica_4/Caudales04.txt"
datos2=read.table(dir_datos,nrows=3,skip=36)
datos2

# CASO 3

rm(list=ls()) 
dir_datos="/home/clinux01/Escritorio/CamiLabo/Practica_4/Caudales04.txt"
 #primera forma usando scan
datos1=scan(dir_datos,character(),nmax=28)
datos1
#creo una matriz solo con los datos que me interesan
latitud1=as.integer(c(datos1[7],datos1[8],datos1[9]))  #contiene la posicion 7,8 y 9 
longitud1=as.integer(c(datos1[14],datos1[15],datos1[16]))
altitud1=as.integer(c(datos1[21],NA,NA)) #lo lleno con NA porque las otras dos tiene tres 
area1=as.integer(c(datos1[28],NA,NA))
parametros1=rbind(latitud1,longitud1,altitud1,area1)

#segunda forma usando read.fwf
datos2=read.fwf(dir_datos,widths = list(c(15,-39,21,-30,9,-7,2,-1,2,-1,2),c(16,-2,10,-78,10,-5,2,-1,2,-1,2),c(17,-89,14,-6,3),c(25,-81,11,-9,3)),n=1)

#tercera forma usando read.table
datos3=read.table(dir_datos,nrows=4,fill=TRUE)

