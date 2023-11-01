rm(list=ls())
getwd()
setwd("C:/Users/camil/OneDrive/Escritorio/Cami_Labo/Practica_4")   

############################### Ejercicio ##############################
library(metR)  
require(ncdf4)
library(lubridate)
library(ggplot2)
#Calcular el promedio de temperatura anual (promedio de los 12 meses del
#año) y graficar la serie resultante con lineas y puntos. Además agregar la
#linea de tendencia lineal.
#Quedemosnos unicamente con el punto mas cercano a la estacion OCBA
# (-34,-58)
archivo <- "C:/Users/camil/OneDrive/Escritorio/Cami_Labo/Practica_4/datos-20231031T140954Z-001/datos/air.mon.mean.nc" #donde esta el archivo
datos_OCBA<- ReadNetCDF(archivo, vars = "air",
                        subset = list(lat =-34,
                                    lon = 360-58))
class (datos_OCBA_periodo) #data.frame

# Me quedo con el periodo 1990-2010
datos_OCBA_periodo<- datos_OCBA[which(year(datos_OCBA$time) %in% 1990:2010),]
attach(datos_OCBA_periodo)
head(datos_OCBA_periodo)
tail(datos_OCBA_periodo)
#Ahora hago el promedio anual para cada año son 20 años deberia tener un dato por año 

anios<-1990:2010
promedio<-c()
datos_anio<-c()
for(anio in anios){
  datos_anio<-mean(datos_OCBA_periodo$air[which(year(datos_OCBA_periodo$time)==anio)], na.rm=T)
  promedio<-c(promedio,datos_anio)
}
promedio_df<-data.frame(anios,promedio)
colnames(promedio_df)<-c("Anio","Tempmediaanual")
attach(promedio_df)
#Grafico el promedio_df
grafico<-ggplot(data=promedio_df, mapping=aes(x=Anio, y=Tempmediaanual))
grafico<-grafico +geom_smooth(method = "lm", se = FALSE,aes(color = "deeppink"))
grafico<-grafico + scale_color_manual(values = c("deeppink"))
grafico<-grafico + geom_line(color= "pink") + geom_point(color="pink4")
