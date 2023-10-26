###############Clase Practica 12/10##################
#abrir archivos de excel en R
rm(list=ls())
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4/")
path = getwd( )
#cargo libreria
require(readxl)
# sintanxis<-excel_sheets(xls = nombre_archivo_xlsx, sheet = numero_o_nombre_de_hoja_a_abrir, ...)
library(readxl)  #si esta instalada esto no debe dar error 
archivo_ejemplo = "datos.xls"
cantidad_hojas <- length(excel_sheets(archivo_ejemplo)) #veo la cantidad de hojas del archivo

print(paste("El archivo tiene ", cantidad_hojas, " hojas"))

nombre_hojas <- excel_sheets(archivo_ejemplo) #veo los nombres de las hojas del archivo
print(paste("Estas hojas se llaman:",nombre_hojas))
print(nombre_hojas)

abro_archivo_ejemplo <- read_excel(archivo_ejemplo, sheet = 3) #por numero de hoja
abro_archivo_ejemplo <- read_excel(archivo_ejemplo, sheet = "serie") #otra opcion, por nombre de hoja

head(abro_archivo_ejemplo) #veo las primeras 6 filas
class(abro_archivo_ejemplo) #veo que tipo de objeto es

cantidad_hojas <- length(excel_sheets(archivo_ejemplo))
#abro_archivo_ejemplo_lis<-as.list(abro_archivo_ejemplo)  lo puedo forzar a ser otras cosas
#Ejercicio en clase
#abrir el archivo
archivo = "Historicos_Estacion_3316.xlsx"
nombre_hojas <- excel_sheets(archivo)
cantidad_hojas <- length(excel_sheets(archivo))
abro_archivo <- read_excel(archivo, sheet = 1)
head(abro_archivo)
library(lubridate)
attach(abro_archivo)
tiempos <- dmy_hm(abro_archivo$'Fecha y Hora') #paso columna de fechas a 
anios <- year(tiempos) #extraigo los anios
meses <- month(tiempos) #extraigo los meses
dias <- day(tiempos)
mi_data_frame_alturas <- data.frame("Anio" = anios, 
                                    "Mes" = meses, 
                                    "Dia" = dias,
                                    "Alturas" = abro_archivo$'Altura [m]')
head(mi_data_frame_alturas)
attach(mi_data_frame_alturas)
#Calcular el promedio de la altura del río de enero para cada año entre 1980 y 2021
posiciones_enero<-which(mi_data_frame_alturas$Mes==1)
for(variable  in names(mi_data_frame_alturas)){
  if(variable==Anio){
  enero<-mi_data_frame_alturas[,4][mi_data_frame_alturas[,2]==1]
  anios<-mi_data_frame_alturas[,1][mi_data_frame_alturas[,2]==1]
  df_enero<-data.frame(enero,anios)
  
  enero_anio<-df_enero[,1][df_enero[,2]==1980]
  }
}

#Otra forma
datos_enero<-c()
x<-seq(1980,2021,by=1)
enero<-mi_data_frame_alturas[,4][mi_data_frame_alturas[,2]==1]
anios<-mi_data_frame_alturas[,1][mi_data_frame_alturas[,2]==1]
df_enero<-data.frame(enero,anios)
for(anio in x){
  enero_anio<-df_enero$enero[df_enero$anios==anio]
  prom_enero<-mean(enero_anio, na.rm=TRUE)
  datos_enero<-c(prom_enero,datos_enero)
}  

#Estimar cual es el minimo de la media de altura de río de enero y a que año corresponde
#Terminar
