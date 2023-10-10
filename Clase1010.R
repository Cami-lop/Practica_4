
##################################################################
# # Laboratorio de Procesamiento de Informaci�n Meteorol�gica
# 2° cuatrimestre 2023
##################################################################
getwd()
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4/")
# cuando no me deja cargar una libreria poner:
options(repos ='http://cran.rstudio.com') 

#################################################################
#no escribimmos en excel, solo leemos
#require(gdata) tengo que instalar gdata
#read.xls <- para leer

#            read.xls(xls, sheet=1, verbose=FALSE, pattern, na.strings =c("NA","#DIV/0!"),...,
#              method=c("csv","tsv","tab"), perl="perl")

#ls: el path al lugar donde se encuentra el archivo
#sheet: el nombre o numero de la hoja de excel ha ser leída
#verbose: valor lógico indicando si se imprimen detalles durante el procesamiento.
#pattern: si se especifica, saltea todas las líneas antes de encontrar lo que le  pide que lee
#perl: nombre del ejecutable en perl que se utilizará
#method: formato intermedio a usar “csv” o “tab”
#na.strings: especifi dato faltante yh lo reemplaza x NA (igual que en read.table)
# blank.lines.skip: valor lógico indicando si las líneas en blanco en el archivo original deben ser ignoradas.
#... Argumentos adicionales de read.table. Se usan los valores defaults de read.csv()
#celdas vacias NA
 
#no tego el paquete en realidad y no corre
require(gdata)
xlsfile <- file.path(path.package('gdata'),'xls','iris.xls')
xlsfile #les muestra el path donde se encuentra el archivo
iris <- read.xls(xlsfile) # lee con los parametros por default y convierte en csv
iris1 <- read.xls(xlsfile,method="csv") # especifico que sea en formato csv
iris2 <- read.xls(xlsfile,method="tab") # especifico que sea en formato tab
head(iris) # miro las primeras lineas

#3 metodo distintos 
require(readxl)
readxl::read_xls()
iris <- read_xls(xlsfile) # lee con los parametros por default y convierte en csv
iris1 <- read.xls(xlsfile,method="csv") # especifico que sea en formato csv
iris2 <- read.xls(xlsfile,method="tab")  
#son tooos datafram

#ccargar datos
exampleFile <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xls')  #mismo archivo guardado en otro formato
exampleFile2007 <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xlsx') #mismo archivo que el de arriba

## ver los numeros y nombres de las hojas:
sheetCount(exampleFile)

if( 'XLSX' %in% xlsFormats() ) ## ver si soporta el formato XLSX.
  sheetCount(exampleFile2007)
## ver los nombres de las hojas en el archivo
sheetNames(exampleFile)
if( 'XLSX' %in% xlsFormats() ) ## if XLSX is supported..
  sheetNames(exampleFile2007) #nom bre de las solapas

data <- read.xls(exampleFile) ## default lee la primer hoja
data1 <- read.xls(exampleFile, sheet=2) ## leo la segunda hoja por numero
data1_2 <- read.xls(exampleFile, sheet="Sheet Second",v=TRUE) ## leo la segunda por nombre, v=true me muesra si hay problemas al abrirlo 

## cargo la cuarta hoja, salteo las primeras dos lineas que no son datos...
if( 'XLSX' %in% xlsFormats() ) ## if XLSX is supported..
  data3 <- read.xls(exampleFile2007, sheet="Sheet with initial text", skip=2)

## EJEMPLO

meteo<-file.path('datos.xls')
sheetCount(meteo)  #3 hojas
sheetCount("datos.xls") 

sheetNames("datos.xls")  #los olmbres de cada hoja 
#dos formas de hacer lo mismo
meteo_0<-read.xls(meteo,sheet=2)
meteo_1<-read.xls("datos.xls",sheet = 2)

head(meteo_1)
class(meteo_1)
correlacion<-cor(meteo_1[,1],meteo_1[,2]) #corr entre col 1 y col 2
#veo correlacion 
plot(meteo_1[,1],type="l",col='red',ylim = c(0,30))
lines(meteo_1[,2],type="l",col='blue')  #lines en graficos que ya existen 
#relacion inversa por eso el signo

#con read.xls <-skip para que salteé los nombres y al ser data frame se los pongo con  colnames
meteo_2<-read.xls(meteo,sheet = 3 , skip=1, col.names=c("Año","Mes","Tmax","Tmin","PP"))  #hoja 3=serie
head(meteo_2)  #primeras lineas
class(meteo_2)
plot(meteo_2[,3], type="l")  #graf columna 3, tipe=l es un a linea 
plot(meteo_2[1:12,5],type="h")

medias<-apply(meteo_2[,3:5],2,mean)  #media de cada columna por eso el dos 
tail(meteo_2)  #1976 al 2006 , no son datos diarios , son mensuales
medias_onda<-matrix(0,nrow=12,ncol=3)   #media para cada mes

for (i in 1:12){
  a=which(meteo_2[,2]==i)
  medias_onda[i,1:3]<-apply(meteo_2[a,3:5],2,mean)
}
#valores max en  enero y min en febrero
plot(medias_onda[,1],type="l",col='red',ylim = c(0,30)) #ylim porque sino no me deja superponer 
lines(medias_onda[,2],type="l",col='blue')  #lines grafica  en graficos que ya existen 
