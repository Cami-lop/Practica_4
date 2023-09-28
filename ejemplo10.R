#################################################
# ejemplo10.R
# Laboratorio de Procesamiento de Información Meteorológica
# 2º cuatrimestre 2021
################################################# 

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
###############################################################

#dos formas iguales de cargar los datos. En la primera en DATA guardo el "camino"

DATA <- "D:/00_Facultad/Docencia/Computacion_2020/clases_2020/"
datos=paste(DATA,"ninio3_19701999.RData",sep="")




# en esta forma escribo el "camino" en la misma sentencia

datos='D:/00_Facultad/Docencia/Computacion_2020/clases_2020/ninio3_19701999.Rdata'#compu oficina
load(datos);

ls.str()

plot(datos_ninio)     #grafica puntos, diagrama de dispersion
plot(datos_ninio,type="l")   #grafica una linea uniendo los puntos
plot(datos_ninio,type="l",col="green")   #grafica una linea verde
plot(datos_ninio,type="b",col="green")   #grafica una linea y puntos verde

#Reescribo el vector en una matriz donde cada columna es un mes y las filas los años

###COMO LO HAGO?????
# El vector esta ordenado un mes abajo del otro hasta terminar un año y luego comienza el siguiente


ninio_3=matrix(datos_ninio,ncol=30)
ninio_3=aperm(ninio_3)

ninio_3_mean=colMeans(ninio_3,na.rm=TRUE)
barplot(ninio_3_mean,col="red")

save(ninio_3_mean,file="D:/00_Facultad/Docencia/Computacion_2020/clases_2020/ninio3mensual_19701999.Rdata")
rm(list=ls())
load("D:/00_Facultad/Docencia/Computacion_2020/clases_2020/ninio3mensual_19701999.Rdata")
ls.str()
barplot(ninio_3_mean,col="green")


