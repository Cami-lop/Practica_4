
#Laboratorio de Procesamiento de Informaci�n Meteorol�gica

# 2� cuatrimestre 2023
###################################################

# Clase_Informaci�n R y binario Alumnos
###################################################

#Para asignar un archivo de datos a un data.frame se utiliza la función read.table()

#La función save() nos permite guardar los objetos que queramos. 
#Load() nos permite leer datos de un archivo que contiene los objetos de R previamente guardados con save().

getwd()
setwd("/home/clinux01/Descargas/CamiLabo/")

x <- stats::runif(20)  ##otra forma de llamar a la función, indicando el paquete al que pertenece

y <- list(a = 1, b = TRUE, c = "oops")

save(x, y, file = "xy.RData")  ##Guardamos los dos objetos en el archivo xy.RData
                               #Buscar el archivo y hacer doble click para abrirlo
save.image()         #Guarda los objetos del WORKSPACE en mi directorio de trabajo, ver el archivo y abrirlo
unlink("xy.RData")	 #Borra el archivo xy.RData
unlink(".RData") 		 #Borra el archivo donde guarde el WORKSPACE


###################
load("xy.RData")    ##es equivalente a load("xy.RData", .GlobalEnv)

##################
rm(x,y)
attach("xy.RData") #lo llamo para que reconozca los elementos que quiero llamar como el dataframe
                   #what=el archivo
                   #name, nombre del archivo
                   #warn.conflicts = immprime si hay condlictos
x  #puede llama a cada elemento pq lo llame
y

detach("file:xy.RData")

##########################
try(data(package="rpart"))     #muerta archivo de datos que estan en esa libreria que ya esta en R

data(USArrests, "VADeaths")    #cargo los conjuntos de datos, aparecen como promesa

ds <- c("USArrests", "VADeaths")  #se los asigne a un vector 
ds #aca solo me da los nombres de los elementos del vector
data(list = ds)   #ahora estoy cargando los datos               
# solo con atach no sirve por eso, hago este procedimiento, de llamarlo (promesa de abrirlo), guardalo en un vector (llamo los datos) y luego lo "transformo en un lista
USAccDeaths
VADeaths
##############################################################################
#ejercicio que hacen SOLOS

# genero una matriz de 20 valores aleatorios que tenga 5 columnas
mimatriz1<-matrix(runif(20),5,5)
# Crear una segunda matriz de 20 n�meros ordenados por fila en 5 columnas
mimatriz2<-matrix(1:20,5,5,byrow=TRUE)
# Guardar los datos usando la funci�n save en el archivo matriz20.Rdata
save(mimatriz1,mimatriz2,file ="matriz20.RData")
# Borrar el ambiente de trabajo y volver a cargar la informaci�n guardada en 
rm(mimatriz1,mimatriz2)
# matriz20.RData utilizando dos m�todos diferentes
#Metodo 1 
load("matriz20.RData")
#borro y hago metodo 2
#Metodo 2
attach("matriz20.RData")
#puede desatachar
##############################################################################
# Leer la serie del tiempo de El Niño3: ninio3_19701999.Rdata 
# 
# Corroborar la lectura del archivo ploteando la serie
# plot(variable)
#
# Calcular la serie de las medias mensuales (generar una serie de 12 tiempos) 
# Verificar su forma ploteandola 
#
# Grabar la nueva serie en formato R, bajo el nombre: ninio312_19701999.Rdata 
#
# Liberar la memoria y corroborar el correcto guardado de la serie re-leyendola y ploteandola nuevamente

#dos formas iguales de cargar los datos. En la primera en DATA guardo el "camino"

DATA <-"/home/clinux01/Descargas/CamiLabo/Practica_4/"  #donde esta la info
datos=paste(DATA,"ninio3_19701999.RData",sep="")        #llamo la informacion 

datos="/home/clinux01/Descargas/CamiLabo/Practica_4/ninio3_19701999.Rdata"  #otra forma de leer la serie 
load(datos);  #carga los datos

ls.str()

plot(datos_ninio)     #grafica puntos, diagrama de dispersion, 
#datos_ninio<-nombre que tiene la variable que esta guardada dentro del archivo 
plot(datos_ninio,type="l")   #grafica una linea uniendo los puntos
plot(datos_ninio,type="l",col="green")   #grafica una linea verde
plot(datos_ninio,type="b",col="green")   #grafica una linea y puntos verde

#Reescribo el vector en una matriz donde cada columna es un mes y las filas los a?os
# El vector esta ordenado un mes abajo del otro hasta terminar un año y luego comienza el siguiente


ninio_3=matrix(datos_ninio,ncol=12,byrow=TRUE)  #LLENO POR FILA
ninio_3=aperm(ninio_3)  #esta funcion es para permutar

ninio_3_mean=colMeans(ninio_3,na.rm=TRUE)  #hago el promedio por columnas y le digo que si hay algun dato faltante que lo remueva
barplot(ninio_3_mean,col="red")

save(ninio_3_mean,file="/home/clinux01/Descargas/CamiLabo/Practica_4/ninio3mensual.RData")
rm(list=ls())
load("/home/clinux01/Descargas/CamiLabo/Practica_4/ninio3mensual.RData")
ls.str()

barplot(ninio_3_mean,col="green")

### BINARIO

#####################
rm(list=ls())
zz <- file("testbin")    #creo un archivo donde guardo los datos,genere un archivo con ese nombre "testbin" asignado en zz
zz                       #pido info sobre el archivo      	

##########################
#permisos ver slide del pp para mas ejemplos
zz <- file("testbin", "wb")	#esta abierto pero no lo puede leer, le pido que me permita escribir 
zz

#####################
#genero el espacio
#escribo
writeBin(1:10, zz)          #(que escribo,en donde)

close(zz)                   #lo cierro

zz <- file("testbin", "rb") #quiero leerlo (rb) en binario

readBin(zz, integer(), 4)   #quiero leer x cantidad de datos  , se que son entros por que lo puse en la linea 133

readBin(zz, integer(), 6)    

######################################
zz1 <- file("testbin", "wb")	#dejame escribi	        
writeBin(pi, zz1, endian = "little")   	#escribo, lo que quiero y donde
close(zz1) #lo cierro                         		 

zz1 <- file("testbin", "rb") #le pido permiso para leer
readBin(zz1, numeric(), 1, endian = "little") #lo leo
#endian = algo relacionado con el almacenamiento 
########################################

zz2 <- file("testbin", "wb")
writeBin(pi^2, zz2, size = 4, endian = "swap")
close(zz2)                         		    

zz2 <- file("testbin", "rb")            
readBin(zz2, numeric(), size = 4, endian = "swap")

#Ejemplo 11 de uso de readBin writeBin

#1 Escribo y leo los contenidos de un archivo:
getwd()
#creo una matriz en el workspace!
a=rnorm(5)

#Creo el archivo
fid = file('rnorm5.bin', 'wb') #Creo el archivo para poder escribir y pido permiso ppara escribir
fid    
writeBin(a, fid)  #lo que quiero escribir y donde
close(fid)        # si no cierro no se genera 

#leo el archivo
fid = file('rnorm5.bin',"rb")
m5 = readBin(fid, numeric(),10)  #guardo en una variable, los numeros que tengo en a, el 10 le dice ue lee los primeros 10 elementos
close(fid)
m5

##############################
ff = file('r5normal.bin','wt')
ff
writeBin(a,ff)  #el permiso tiene que ser en binario para escribir en binario sino, salta error

