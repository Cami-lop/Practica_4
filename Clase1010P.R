############Clase Practica 10/10###############
############# ARCHIVOS ACSI ##############
rm(list=ls())
getwd()

#leer el arcivo<-read.table(archivo), tenemos que ver si lee bien las separaciones entre los datos
#header: indica si el archivo tiene encabezado (header=TRUE) o no (header=FALSE). Por defecto toma el valor header=FALSE
#sep: caracter separador de columnas que por defecto es un espacio en blanco (sep=““). Otras opciones serían: sep=”,” si el separador es un coma, sep=“:” si el separador son dos puntos, etc.
#dec: caracter utilizado en el archivo para los números decimales. Por defecto se establece dec = “.”. Si los decimales vienen dados por “,” se utiliza dec = “,”

#read.table(archivo, header = FALSE, sep = "", dec = ".")

## seteo la ruta hacia el directorio nombrando primero la carpeta, luego el archivo
archivo<- "/home/clinux01/Escritorio/CamiLabo/Practica_4/Datos clase 12-20231010/boya.txt"
## Primero leo el archivo solo usando read.table sin especificar otro argumento
datos<- read.table(archivo,header = TRUE)  #devuelve un dataframe 
# Miro como se cargaron los datos
head(datos) # Con head cargo solo las primeras 6 filas
#anio no lo toma
tail(datos)  #1982-2015 datos mensuales 
dim(datos)

archivo_2<- "^"
# Abrimos el archivo sin especificar otro argumento
datos_2<- read.table(archivo_2, header = TRUE, sep=",")  #los datos estan separados por una coma 
head(datos_2) #imprimo por pantalla los datos
#Argumentos utiles
#col.names: vector que tenga el nombre de las columnas.
#na.strings: caracteres que deben tomarse como NA. Los espacios en blanco se consideran NA.
#skip: número entero que especifica el número de filas que NO quierenleerse. Entonces si no quiero leer las primeras tres columnas debo agregar el argumento skip=3
#nrows: número entero que especifica el número de filas quieren leerse del archivo

datos_2<- scan(archivo_2,what = list("numeric(0)","numeric","numeric"),sep = ",")  #devuelve una lista, decirle que tipo de archivo es  
head(datos_2)
datos_2[[2]] #elemento dos de la lista 
datos_2[[2]][1] #del elemento 2 de la lista quiero el contenido  de la posicion 1, que es el titulo ¨ 

#escritura
write.table( variable, file= "archivo.txt",otros_argumentos)
#ejemplo
tipo <- c("A", "B", "C")
longitud <- c(120.34, 99.45, 115.67)
## Con los vectores tipo longitud creo un data frame
datos_salida <- data.frame(tipo, longitud)

#primero seteo el directorio de salidas y el nombre del archivo con la funcion here
archivo_salida <- "/home/clinux01/Escritorio/CamiLabo/Practica_4/Datos clase 12-20231010/ejemplo_escritura_datos.txt"
#luego uso la funcion write.table especificando primero la
# variable datos_salida
# y luego el nombre de archivo con su ruta correspondiente
write.table(datos_salida, file = archivo_salida)
# si quiero especificar que los caracteres sean sin comillas uso el argumento
# quote=FALSE
# si ademas quiero eliminar los numeros de fila
#uso row.names=FALSE
write.table(datos_salida, archivo_salida, quote = F, row.names= F)

datos_salida

#Ejercicio en clase
archivo_datos_estaciones<- "/home/clinux01/Escritorio/CamiLabo/Practica_4/Datos clase 12-20231010/datos_estaciones.txt"
datos_estaciones<- read.table(archivo_datos_estaciones,header = TRUE)
dato_faltante<--999.0
posiciones_datosfal<-which(datos_estaciones==dato_faltante)
length(posiciones_datosfal) #cant de datos falantes
attach(datos_estaciones)
datos_estaciones_list<-as.list(datos_estaciones)



c<-1
while(c<8){
  datos_estaciones_list[[c]][datos_estaciones_list[[c]]==dato_faltante]<-NA
  c<-c+1
}
t_max<-c()
p_max<-c()
h_max<-c()
estacion<-c()
datos_max<-list()

t_max<-max(datos_estaciones_list[[3]], na.rm=TRUE)
p_max<-max(datos_estaciones_list[[4]], na.rm=TRUE)
h_max<-max(datos_estaciones_list[[5]], na.rm=TRUE)
datos_max<-list(t_max,p_max,h_max)
 
datos_estaciones_list[[8]][which(datos_estaciones_list[[3]]==t_max)]
datos_estaciones_list[[8]][which(datos_estaciones_list[[4]]==p_max)]
datos_estaciones_list[[8]][which(datos_estaciones_list[[5]]==h_max)]

#Falta el ejercicio 3
