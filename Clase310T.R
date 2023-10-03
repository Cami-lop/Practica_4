rm(list=ls())
getwd()
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4/")

#Clase teorica 3/10- ASCCI

file.create(Archivo,showWarnings = TRUE)  #crea archivos con el nombre dado si no existen y los trunca si ya existen
file.exists(Archivo)                      #devuelve un vector logico indicando si los archivos a los cuales se hace referencia en los argumentos existen
file.remove(Archivo)                      #ntenta borrar los archivos mencionados en los argumentos.
file.rename(Archivo,Nombre1)              #le cambio el nombre
file.append(Nombre1,UnVec)                #le pego otro archivo
file.copy(from, to, overwrite = recursive, recursive = FALSE,
          copy.mode = TRUE, copy.date = FALSE)  #similar a file.append pero con los argumentos en el orden natural para copiar. 
                                                #Copiar a un archivo existente se saltea salvo que overwrite = TRUE

vec<-scan("UnVec.txt")   #funcion principal de ascci,lo guarda como vector
print(vec) 
vec2<-scan("IntVec",integer())   #lo guardo,  los leo como entero

#si yo los separo con algo pero a la hora de leerlo no  identifico con sep como esta separado me salta error 
#skip= le dio un numero y se salta esa cantidad
#nlines= cantidad de lineas que quiero que me lea


########################GRABAR DATOS #######################################

#write(x, file = "data",
     #ncolumns = if(is.character(x)) 1 else 5,
     #append = FALSE, sep = " ")

#x: los datos que se quieren escribir en el archivo
#file: una cadena de caracteres indicando el nombre del archivo. Si no se especifica el nombre el archivo se llamara data y se genera en el directorio de trabajo
#ncolumns: numero de columnas en los cuales se escribirán los datos. Por DEFAULT son 5
#append: si es TRUE los datos se agregaran al archivo existente
#sep: caracter usado para separar columnas. Si sep = "\t" las columnas se separan con tabulación; default es " "

x<-matrix(1:10,ncol=5)
x
write(x)
getwd()
#no se guardaron igual , en le archivo se lleno por fila
write(t(x),sep="\t",append=T) #lo guarde como matrix
unlink("data") #se borra
write(t(x),"",sep="\t",)   #uso la  transpuesta de x para que los datos me aparezcan como los guarde


####################### OTRAS FUNCIONES PARA  ESCRIBIR #####################
#PAG 9 DE PP EXPLICA CADA PARTE
#write.matrix

require(MASS) #debo cargar la librería que contiene la función
l= matrix(rnorm(10000),ncol=10) #creo una matriz de 1000 x 10
write.matrix(l,file="matriz1000x10")
write.matrix(l,file="matriz1000x10b",blocksize=100) #ver si hay alguna diferencia, ver si se mantiene las formas de las columnas
# En la segunda tiene bloques y va cambiando



#write.table<-imprime el argumento x luego de convertirlo a un data frame sino lo es ni es una matriz a un archi
#creo un data frame,pag 10 explica cada parte
x <- data.frame(a = I("a \ quote"), b = pi)
write.table(x, file = "foo.txt", sep = ",", col.names = NA,
            qmethod = "double")
write.table(x, file = "foo2.txt", sep = "," )

#Ejemplo
a<-matrix(data=rnorm(100),ncol=10)
a
write.matrix(l,file="matriz_a.txt")  #mas prolijo pero no permite agregar al archivo
write.table(a,file="matriz_a",append=TRUE)  #si no le pongo append=TRUE me borra lo que tenia escrito
                                            #nombre columna y nuero de fila
#Ejempo 2
b<-matrix(data=c(1:95,NA,NA,NaN,NaN,Inf),ncol=10)
write(b,file="mimatrizb.txt",append=TRUE)
write.matrix(b,file="matrizb.txt")
write.table(b,file = "matrizb.txt",append = TRUE)   #CAMBIA NaN POR NA, los considera iguales



#otra forma de grabar datos
#ver def de sep pag 12
#Para escribir nuestro ejemplo anterior haríamos
write.csv(x, file = "foo.csv") #no pone nombre columnas
write.csv(x, file = "foo2.csv", row.names = FALSE) #abrir archivos y ver diferencias
write.csv2(x, file = "foo.csv2", row.names = FALSE) #y con este??

###############FUNCIONES PARA LEER#########################

read.table # Lee un archivo con formato de tabla y crea un data frame,donde los casos
           #corresponden a las lineas y las variables a los campos en el archivo.)
#header: un valor lógico indicando si el archivo contiene el nombre de las variables en la primer línea
#sep: el default es espacio en blanco
#dec: el caracter usado para el punto decimal.
#row.names un vector con los nombres de las filas: nombres, numero indicando la columna donde estan, o el nombre de la columna que los contiene. Si no se usa las filas son numeradas
#na.strings los caracteres que deben tomarse como NA. Los espacios en blanco se consideran NA / me con vierte un numero a NA

#read.csv(file, header = TRUE, sep = ",", quote = "\"",
          #dec = ".", fill = TRUE, comment.char = "", ...)
#read.csv2(file, header = TRUE, sep = ";", quote = "\"",
          #dec = ",", fill = TRUE, comment.char = "", ...)
#read.delim(file, header = TRUE, sep = "\t", quote = "\"",
            #dec = ".", fill = TRUE, comment.char = "", ...)
#read.delim2(file, header = TRUE, sep = "\t", quote = "\"",
            #dec = ",", fill = TRUE, comment.char = "", ...
#Soo cambia la separacion


#read.fwf <- Lee una tabla con datos de formato ancho fijo y lo convierte en un data.frame. Los records de mas de una linea son concatenados a una sola linea antes de ser procesados.
#widths: un vector entero que contiene los anchos de los campos (de una línea) o una lista de vectores enteros que contiene los anchos de varias líneas
  #Colocar un valor negativo indica la cantidad de columnas que se deben saltear, e.g., -5 saltear 5 columnas

#Ejemplo 3
ff <- tempfile()
cat(file = ff, "123456", "987654", sep = "\n")
read.fwf(ff, widths = c(1,2,3))  #widths= le dije qque me leyera por separado esos elementos
read.fwf(ff, widths = c(1,-2,3)) #widths=saltea dos en esa posicion
#unlink(ff)<- borro


#Ejemplo 4
cat(file = ff, "123", "987654", sep = "\n")
read.fwf(ff, widths = c(1,0, 2,3))

#Ejemplo 5
cat(file = ff, "123456", "987654", sep = "\n")
read.fwf(ff, widths = list(c(1,0, 2,3), c(2,2,2))) 
ff  #tiene nombre temp en la maquiena

#Ejemplo 6<-ejemplo 14

scan("test1.dat", sep = ",")  #espacio vacion usa NA

#VER PARTE DE EFICIENCIA

