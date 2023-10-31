#######################Clase Teorica 31/10#######################
######################### graficos ##############################
rm(list=ls())
getwd()
setwd("/home/clinux01/Escritorio/Cami_Labo/Practica_4/")
#Los gráficos son la mejor forma de simplificar lo complejo.
#Funciones:
#barplot<- Diagrama de barras
#łboxplot<- Diagrama de caja
#contour<- Gráfico de contorno
#hist<- Histograma
#pairs<- Pares de gráficos de dispersión por variables
#plot<- Rutina de dibujo general
#points y lines<- Se utilizan para agregar líneas o puntos a un plot.
---------------------------------------------------------------------
  #funcion mas basica <- plot
  
  #plot(x,y,...)  
  #x: la coordenada x de los puntos en el grafico. Alternativamente, una función o un objeto de R con un método de ploteo puede ser provisto
  #y: la coordenada y de puntos en el grafico, y es opcional en el caso que x sea una estructura adecuada
  plot(sin,-pi,2*pi)  #por dafualt usa puntitos
#type el tipo de plot que debe dibujarse. Posibilidades:
plot(cars,type"p")#"p" para puntos,
plot(cars,type"l")#"l" para lineas,
plot(cars,type"b")#"b" ambos (punto+linea),
plot(cars,type"c")#"c" grafica solo las lineas de la opcion "b",
plot(cars,type"o")#"o" ambos pero sobrepuestos,
plot(cars,type"h")#"h" del tipo ‘histograma’ (o ‘alta-densidad’) de lineas verticales,
plot(cars,type"s")#"s" tipo escalera,
plot(cars,type"S")#"S" otro tipo de pasos ver ‘Details’ de plot, (escalera inversa)
plot(cars,type"n")#"n" no graficar

#titulos
#plot(cars,type="o",main="Grafico de la variable",sub="cars",xlab="velocidad",ylab="distancia")
#main: El titulo del grafico
#sub: subtitulo del grafico
#xlab: titulo para el eje x
#ylab: titulo para el eje y
#asp: la razon y/x para el aspecto del grafico, see plot.window.

#Ejemplo
x<-(0:65)/10
y<-sin(x)
plot(x)
plot(x,y)
plot(x,y, main="Funcion seno", xlab = "numeros",ylab = "seno")

z<-cos(x)
plot(x,z,main="Funcion coseno", type="l")
plot(x, y, main="Seno", type="l")
plot(x, z, main="Coseno", lty=2, col="red", type="l") #el tipo de la linea es punteado
plot(x, z, main="Coseno", lty=3, col="blue", type="l", xlim=c(0, 2), ylab="cos(x)")
windows()
plot(x, y, main="Funciones seno y coseno", type="l")
lines(x, z, col="blue", lty=2) # col=4 es equivalente
text(x=c(3,1.8), y=c(0,1), labels=c("sin(x)", "cos(x)"),col=c("black", "blue"))  #Cambiar las posiciones del texto
#no hace gbraficos nueevos sino que escribe sobre el que ya esta// si cambia x e y digo donde poner el texto 
plot(x, y, main="Funciones seno y coseno", type="l")
lines(x, z, col=2, lty=2)
legend(locator(1),legend=c("sin(x)","cos(x)"),lty=c(1,2),col=c(1,2))

x <- 1:10; y <- sample(1:10)
plot(x, y); identify(x, y) #usar ESC para terminar
nombres <- paste("punto", x, ".", y, sep ="")
plot(x, y); identify(x, y, labels=nombres) #usar ESC para terminar y que aparezca el valor 

nombres <- paste("punto", x, ".", y, sep ="")
plot(x, y); identify(x, y, labels=nombres) #usar ESC para terminar
#col<- permite modificar colores
#Axes <- opciones para los ejes
#frame.plot<-  trazar un recuadro al grafico
#lty<- tipos de lineas.
#lwd<- anchos de lineas.
#par<-  establecer o preguntar parámetros gráficos
#legend<- agregar una leyenda al grafico
#layout<-  divide espacio a graficar en filas y columnas
#mtext<- titulo para eje derecho
#xlim, ylim <-cambia el rango de valores de los ejes

windows() #Crea una ventana nueva
points(x, y, ...) #Dibuja una nube de puntos
lines(x, y, ...) #Dibuja una línea que une todos los puntos
ablines() #Dibuja una línea recta dada la interc. y pendiente
polygons(x, y, ...) # Dibuja un polígono cerrado
text(x, y, labels, ...) # Escribe texto en unas coordenadas

demo("colors")
R defined colors:
  ?rainbow # la que usa por default 
pie(rep(1, 15), col = rainbow(15)) # si agrando el espacio si entran 15 colores en vez de 12
pie(rep(1, 12), col = heat.colors(12))
pie(rep(1, 12), col = terrain.colors(12))
pie(rep(1, 12), col = topo.colors(12))
pie(rep(1, 12), col = cm.colors(12))

colors()[grep("red",colors())] #me muestra las tonalidades de rojo 

#------------------------------------------------------------------------------------------------------------------
# Gustavo Naumann # UBA-CONICET, Buenos Aires, 24.08.2015
# Purpose: Introduction to different definitions of colours and colour palettes in R 
### Vector con colores 

X<-1:5 
colors <- c("honeydew","dodgerblue","firebrick","forestgreen","gold")

par(fig=c(0,1,0,1), # Figure region in the device display region (x1,x2,y1,y2)
    omi=c(0.05,0.15,0,0.05), # global margins in inches (bottom, left, top, right)
    mai=c(0.6,0.6,0.6,0.5)) # subplot margins in inches (bottom, left, top, right)

barplot(X, col= colors)
legend("center", colors  , text.col = "black", horiz = FALSE,
       col=colors, cex=0.8, lty=1, y.intersp = 1, lwd = 3 )
#leyenda arriba y  a la derecha 
############################ Paletas de colores Mapas #################################
require(ncdf4)
require(fields)
require(mapdata)

nc<-nc_open(paste("/home/clinux01/Escritorio/Cami_Labo/Practica_4/netcdf_SLP_SA_1979_2014.nc",sep=""))
lon<-ncvar_get(nc,"longitude") 
lats<-ncvar_get(nc,"latitude")
time<-ncvar_get(nc,"time")
MSLP<-ncvar_get(nc,"msl") ## MSLP * 100 esta en pascales <-#cambio unidades 

#puedso graficar de un tiempo a la vez
P <- MSLP[,,1]/100 
mn<-min(P); mx<-max(P)
brk <- seq(mn,mx,length.out = 13)
levs<-brk

RGB<-matrix(c(0,  0.167,	1,    #defino la paleta de colores 
              0.1,	0.4,	1,
              0.2,	0.6,	1,
              0.4,	0.8,	1,
              0.6,	0.933,	1,
              0.8,	1,	1,
              1,	1,	0.8,
              1,	0.933,	0.6,
              1,	0.8,	0.4,
              1,	0.6,	0.2,
              1,	0.4,	0.1,
              1,	0.167,	0), nrow=12, byrow=TRUE)

cols<-rgb(RGB[,1],RGB[,2],RGB[,3]) #convierte color a rgb ( rgb va de 0 a 1) / son codigos de colores 

image.plot(lon-360,rev(lats[1:55]),P[,55:1], breaks=brk, lab.breaks=names(brk), col=cols)
contour(lon-360,rev(lats[1:55]),P[,55:1], add=TRUE, col=c("gray12","gray50","gray89"), levels = c(1010,1012,1016))
map(database="worldHires", add=TRUE, col="black", interior=TRUE)

########################################################################################
############################## Generar una escala de grises  ##########################

for (i in 1:12){
  k <- 6*i
  cols[i] <- paste("gray",k,sep ="")
}

image.plot(lon-360,rev(lats[1:55]),P[,55:1], breaks=brk, lab.breaks=names(brk), col=cols) #revlats <- las da vuelta y P tambien sio hace el maa al reves 
contour(lon-360,rev(lats[1:55]),P[,55:1], add=TRUE, col=c("gray12","gray50","gray89"), levels = c(1010,1012,1016))
map(database="worldHires", add=TRUE, col="black", interior=TRUE)

################################# Generar una escala de cian RGB  #############################################

rgbs <- cbind(12, seq(32,255, length=12), seq(32,255, length=12)) / 255
cols <- rgb(rgbs[,1], rgbs[,2], rgbs[,3]) 

image.plot(lon-360,rev(lats[1:55]),P[,55:1], breaks=brk, lab.breaks=names(brk), col=cols)
contour(lon-360,rev(lats[1:55]),P[,55:1], add=TRUE, col=c("gray12","gray50","gray89"), levels = c(1010,1012,1016))
map(database="worldHires", add=TRUE, col="black", interior=TRUE)

################################# Parametros graficos ######################################
#axes: un valor logico indicando si ambos ejes deben ser dibujados. Usar parametro grafico “xaxt” o “yaxt” para eliminar uno de los ejes.
#frame.plot: logical, indicando si se debe trazar un recuadro al grafico. Default TRUE
#lty: un vector con tipos de lineas.
#lwd: un vector con anchos de lineas. Numeros positivos, default 1
x<- -10:10
plot(x, type="l", lty=2, lwd=4, col="deeppink")  #pruebo distintos tipos de lineas
#----------------------------------par---------------------------------------------
#bg: El color de fondo del área de graficado
#fg: El color del “foreground” de los gráficos. Es el color que se usa por default en los ejes, cajas alrededor de los gráficos, etc.
#fig: Un vector numérico del tipo c(x1, x2, y1, y2) que da las coordenadas (NDC) de la figura en la región de display. Si se establecen estos valores se inicia un nuevo grafico, para agregar al grafico existente usar también new = TRUE.
#mai: Un vector numérico del tipo c(inferior, izquierdo, superior, derecho) que especifica el tamaño de los márgenes en pulgadas.
#mar: idem mai pero en lugar de pulgadas numero de líneas. Default c(5, 4, 4, 2) + 0.1.
#oma: Un vector del tipo c(inferior, izquierdo, superior, derecho) dando el tamaño de los márgenes externos en líneas de texto.
#omd: Un vector del tipo c(x1, x2, y1, y2) dando la región dentro de los márgenes exteriores en NDC (= normalized device coordinates), i.e., como una fracción (in [0, 1]) de la región.
#omi: Un vector del tipo c(inferior, izquierdo, superior, derecho) dando el tamaño de los márgenes externos en pulgadas.

#  ----------------------------layout----------------------------------------------
  #distribucion de graficos en una hoja 
  
#ejemplo
layout(matrix(c(1,1,0,2), 2, 2, byrow = TRUE)) #donde dice 0 no va a ir ningun grafico
layout.show(2)
x<-array(rnorm(100),c(100,4)) #datos a graficar.
titulo<-c("Figura1","Figura 2","Figura 3","Figura 4")
#Titulo de cada grafico individual
for(k in 1:4){
 plot(x[,k], type="l", col="darkblue", lwd=2,
         ylab="variable",xlab="tiempo",xlim=c(0,100),ylim =c(-3,3) )
   title(main=(titulo[k]), line=1, cex.main=1.2)
   }
#Son 4 graficos, lo va a hacer en 2 paginas

#EJEMPLO 2
nf <- layout(matrix(c(1,1,0,2), 2, 2, byrow = TRUE),
             respect = TRUE) #igual a la anterior salvo respect,
#relaciones entre altos y anchos
layout.show(nf)

#EJEMPLO 3
## crea una sola figura de 5cm x 5cm
nf <- layout(matrix(1), widths = lcm(5), heights =
               lcm(5)) #le especifico el alto y el ancho de la figura
#alto y ancho es de 5 cm
layout.show(nf)  

