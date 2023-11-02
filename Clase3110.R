#######################Clase Teorica 31/10#######################
######################### graficos ##############################
rm(list=ls())
getwd()
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4/")
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
#R defined colors:
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
#axes: un valor logico indicando si ambos ejes deben ser dibujados. Usar parametro grafico “xaxt�? o “yaxt�? para eliminar uno de los ejes.
#frame.plot: logical, indicando si se debe trazar un recuadro al grafico. Default TRUE
#lty: un vector con tipos de lineas.
#lwd: un vector con anchos de lineas. Numeros positivos, default 1
x<- -10:10
plot(x, type="l", lty=2, lwd=4, col="deeppink")  #pruebo distintos tipos de lineas
#----------------------------------par---------------------------------------------
#bg: El color de fondo del área de graficado
#fg: El color del “foreground�? de los gráficos. Es el color que se usa por default en los ejes, cajas alrededor de los gráficos, etc.
#fig: Un vector numérico del tipo c(x1, x2, y1, y2) que da las coordenadas (NDC) de la figura en la región de display. Si se establecen estos valores se inicia un nuevo grafico, para agregar al grafico existente usar también new = TRUE.
#mai: Un vector numérico del tipo c(inferior, izquierdo, superior, derecho) que especifica el tamaño de los márgenes en pulgadas.
#mar: idem mai pero en lugar de pulgadas numero de líneas. Default c(5, 4, 4, 2) + 0.1.
#oma: Un vector del tipo c(inferior, izquierdo, superior, derecho) dando el tamaño de los márgenes externos en líneas de texto.
#omd: Un vector del tipo c(x1, x2, y1, y2) dando la región dentro de los márgenes exteriores en NDC (= normalized device coordinates), i.e., como una fracción (in [0, 1]) de la región.
#omi: Un vector del tipo c(inferior, izquierdo, superior, derecho) dando el tamaño de los márgenes externos en pulgadas.
#  ----------------------------LAYOUT----------------------------------------------
                   #distribucion de graficos en una hoja 
#Ejemplo
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
------------------------------------------------------------------------------
########################### Parte 2 graficos ###############################
#EJEMPLO 4 <-Crea un scatterplot con histogramas en los margenes
x <- pmin(3, pmax(-3, stats::rnorm(50)))
y <- pmin(3, pmax(-3, stats::rnorm(50)))
xhist <- hist(x, breaks = seq(-3,3,0.5), plot = FALSE)
yhist <- hist(y, breaks = seq(-3,3,0.5), plot = FALSE)
top <- max(c(xhist$counts, yhist$counts))
xrange <- c(-3, 3)
yrange <- c(-3, 3)
nf <- layout(matrix(c(2,0,1,3),2,2,byrow = TRUE), c(3,1) , c(1,3), TRUE)
#primer vector despues de TRUE mide el ancho de izq a derecha
#segundo mide el alto de los graficos
layout.show(nf)
#Grafico lo que dise�e antes
#tengo tres graficos diferentes distribuidos en una misma pagina
par(mar = c(3,3,1,1))
plot(x, y, xlim = xrange, ylim = yrange, xlab = "", ylab = "")
par(mar = c(0,3,1,1))
barplot(xhist$counts, axes = FALSE, ylim = c(0, top), space = 0)
par(mar = c(3,0,1,1))
barplot(yhist$counts, axes = FALSE, xlim = c(0, top), space = 0, horiz = TRUE)

                       #Otro ejemplo<- 4 graficos en una sola hoja 
x<-array(rnorm(100),c(100,4)) #creo los datos a graficar. Replico los 100 datos en 4 columnas
titulo<-c("Figura1","Figura 2","Figura 3","Figura 4") #Titulo de cada grafico individual
par(fig=c(0,1,0,1), # Region de la Figura dentro de la region display (x1,x2,y1,y2)
    omi=c(0.05,0.15,0,0.05), # margenes globales en pulgadas (inferior, izquierdo,superior, derecho)
mai=c(0.6,0.6,0.6,0.5)) # margenes del subplot en pulgadas (inf izq, superior, derecho)
layout(matrix(1:4, 2, 2, byrow= TRUE))
for(k in 1:4){
  plot(x[,k], type="l", col="darkblue", lwd=2,
       ylab="variable",xlab="tiempo",xlim=c(0,100),ylim=c(-3,3) )
  title(main=(titulo[k]), line=1, cex.main=1.2)
  abline(v=20,lty=2,col="grey"); abline(v=40,lty=2,col="grey");
  abline(v=60,lty=2,col="grey")
}
                          #CURVE
#Traza una curva correspondiente a la funci�n sobre el intervalo [desde, hasta].
#curve tambi�n puede graficar una expresi�n en la variable xname, default x.
curve(sin, -2*pi, 2*pi, xname = "t")
curve(tan, xname = "t", add = NA, main =
        "curve(tan) --> same x-scale as previous plot")
#add=NA me toma el mismo rango que tenia en el eje x del rafico anterior 
                             #BARPLOT
require(grDevices) # librer�a para colores
tN <- table(Ni <- stats::rpois(100, lambda = 5))
#genera datos al azar usando la funcion de poisson media 5
r <- barplot(tN, col = rainbow(20))
#- type = "h" plotting *is* 'bar'plot
lines(r, tN, type = "h", col = "red", lwd = 2)
#lines siempre superpone sobre graficos preexistente, le agregue la linea vertical de color rojo y ancho dos 
barplot(tN, space = 1.5, axisnames = FALSE,
        sub = "barplot(..., space= 1.5, axisnames = FALSE)") #lo unico que difiere es qu no tiene colores y que la distancia entre ellos es de 1.5
#hay mas ejemlos en el pp de Moira 
                         #GRAFICOS DE DOS EJES
x<-array(rnorm(100),c(100,4))
par(fig=c(0,1,0,1), # Region de la figura en el display device (x1,x2,y1,y2)
    omi=c(0.05,0.9,0,0.3)) # margenes globales en pulgadas (abajo, izq, sup, derecha)
plot(x[,1], type="l", col="darkblue", lwd=3, ylab="variable 1",xlab="Tiempo", xlim=c(0,100), ylim #eje de una variable 
     =c(-3,3) )
title(main=("Grafico en dos ejes"), font=2, line=1, cex.main=1.2) #titulo principal 
par(new=TRUE) #para graficar sobre la figura anterior/ nueva dimension para graficar sobre el mismo que ya existe  
barplot(x[,3]*x[,1], col="pink",lwd=2, yaxt="n", ylab="",xaxt="n", xlab="",cex.axis=1.0 )
axis(4, cex.axis=1.0) ## Valores en el eje izquierdo
mtext("variable 2", side=4, line=2, col="pink", cex=1.0) ## Texto para el eje derecho (la otra variable ) 
                           #BOXPLOT
#tambi�n es posible dibujar boxplots para matrices, uno por cada columna (variable) de la matriz.
x<-array(rnorm(100),c(100,5))
boxplot(x)
                          #COUNTOUR(funcion basica para graf de isolineas)
#EJEMPLO 1
x <- -6:16
op <- par(mfrow = c(2, 2),mai=c(0.4,0.4,0.4,0.4))
contour(outer(x, x), method = "edge", vfont = c("sans serif", "plain")) #outer producto entre x y x//primer grafico primeras tres lineas 
z <- outer(x, sqrt(abs(x)), FUN = "/")
image(x, x, z) #grafico en colores/image grafica en colores 
contour(x, x, z, col = "pink", add = TRUE, method = "edge", vfont = c("sans serif", "plain"))
contour(x, x, z, ylim = c(1, 6), method = "simple", labcex = 1, xlab = quote(x[1]), ylab = quote(x[2])) #tercer grafico, limito la variable y 
contour(x, x, z, ylim = c(-6, 6), nlev = 20, lty = 2, method = "simple", main = "20 levels; \"simple\"
labelling method",cex.main=0.8)
#EJEMPLO 2 <-Correrlo linea por linea
rx <- range(x <- 10*1:nrow(volcano))
ry <- range(y <- 10*1:ncol(volcano))
ry <- ry + c(-1, 1) * (diff(rx) - diff(ry))/2
tcol <- terrain.colors(12)
opar <- par(pty = "s", bg = "lightcyan")
par(opar);
plot(x = 0, y = 0, type = "n", xlim = rx, ylim = ry, xlab = "", ylab = "")
u <- par("usr")
rect(u[1], u[3], u[2], u[4], col = tcol[8], border = "red")
contour(x, y, volcano, col = tcol[2], lty = "solid", add = TRUE, vfont = c("sans serif", "plain"))
title("A Topographic Map of Maunga Whau", font = 4)
abline(h = 200*0:4, v = 200*0:4, col = "lightgray", lty = 2, lwd = 0.1)
                         #FILLED.COUNTOUR
x <- 10*1:nrow(volcano)
y <- 10*1:ncol(volcano)
filled.contour(x, y, volcano, color = terrain.colors,
               plot.title = title(main = "The Topography of Maunga Whau",
                                  xlab = "Meters North",ylab = "Meters West"),
               plot.axes = { axis(1, seq(100, 800, by = 100))
                 axis(2, seq(100, 600, by = 100)) },
               key.title = title(main = "Height\n(meters)"), #TITULO A LA LEYENDA 
               key.axes = axis(4, seq(90, 190, by = 10))) #DEFINO LA LEYENDA 
mtext(paste("filled.contour(.) from", R.version.string),
      side = 1, line = 4, adj = 1, cex = .66)
#ASP=1 HACE QUE EL EJE X SEA IGUAL AL EJE Y ESTA EN EL OTRO EJEMPLO
#EJEMPLO 15 IMPORTANTE MUESTRA COMO SUPERPONER GRAFICOS DE DIST TIPOS 
                       #MESH<-PLOTEO DE SUPERFICIE EN 3D
require(plot3D)
X=matrix(seq(-8,8,by=0.5),ncol=33,nrow=33)
Y=matrix(seq(-8,8,by=0.5),ncol=33,nrow=33,byrow=T)
#Otra forma de generar los dos renglones anteriores es usando la funcion mesh
MM<-mesh(seq(-8,8,by=0.5),seq(-8,8,by=0.5))
class(MM)
X<-MM$x ; Y<-MM$y

R = sqrt(X^2 + Y^2) + .Machine$double.eps
#La matriz R contiene la distancia desde el centro de  la matriz, 
#que es el origen. Sumar eps impide la divisi???n por cero 
#(en la etapa siguiente) que genera valores Inf en los datos.
Z = sin(R)/R

surf3D(X,Y,Z,facets=F)
surf3D(X,Y,Z,facets=NA)
surf3D(X,Y,Z,facets=F,border = "black",colkey=F)
surf3D(X,Y,Z)
surf3D(X,Y,Z,phi=40,theta = 20)
surf3D(X,Y,Z,phi=40,theta = 60)
surf3D(X,Y,Z,colkey=F)
surf3D(X,Y,Z,colvar=Y,colkey=F,ltheta=20,bty="b2",phi=0)
surf3D(X,Y,Z,colvar=X,colkey=F,bty="b")
surf3D(X,Y,Z,colvar=X,colkey=F,box=F,shade=0.5)
surf3D(X,Y,Z,colvar=X,colkey=F,box=F,border = "black", xlim = range(X)*0.8, 
       ylim = range(Y)*0.8, zlim = range(Z)*0.8)
surf3D(X,Y,Z,colvar=X,colkey=F,box=F,border = "black", xlim = range(X)*0.8, 
       ylim = range(Y)*0.8, zlim = range(Z)*1.2)
surf3D(X,Y,Z,box=FALSE,theta=60,col = "lightblue", shade = 0.9)
for (angle in seq(0, 360, by = 10)) plotdev(theta = angle)
#Con la flecha en plots ir hacia atras para ver los graficos 
#generados con el for
                     #GUARDAR GRAFICOS DE R EN DIST FORMATOS
#si los guardo no aparecen, primero lo corro para verlo en la pantalla y despues lo guardo en algun formato
jpeg("Grafico.jpg") #toma todas las opciones default(puedo modificarlas)- lo guardo en jpg
x<-1:36
y<-sqrt(x)
plot(x,y,type="l",xlab="x",ylab="y", main="Parabola y=x^2", col="red")
dev.off() #se guardo en mi carperta
                    #EJEMPLO DE CREAR Y GUARADR GRAFICOS
#### Generar los gr�ficos de Ejemplos de Rect�ngulos en RStudio
example(rect)
# Generar los gr�ficos de Ejemplos de Rect�ngulos como JPEG
jpeg(file = "myplot.jpeg")
example(rect)
dev.off()
# Repetir lo anterior pero cambiando el nombre del archivo como se ve abajo
jpeg(file = "myplot%02d.jpeg") #me lo guarda en dos archivos distintos 
example(rect)
dev.off()
                         #POINTS<-agrega puntos sobre un grafico (puntos o simbolos)
#EJEMPLO 2: PCH dentro de la funcion plot / PCH <- simbolos// ver en pp cada numero de 19:25
op <- par(bg = "light green")
x <- seq(0, 2*pi, len = 51)
plot(x, sin(x), type = "o", pch = 24, bg="cyan",col = "blue", cex = .8)
par(op) #mas ejemplo script del campus
                        #IMAGE.PLOT
#puedo especificar qe colores quiero y sino tomo los de dafualt de R 
require(fields) #necesito esta libreria 
x<- 1:10
y<- 1:15
z<- outer( x,y,"+")
image.plot(x,y,z) #creo la imagen
#o bien creando una lista y poniendo etiquetas
obj<- list( x=x,y=y,z=z)
image.plot(obj, legend.lab="Sverdrups")
#identifico algunos puntos sobre la imagen
points( 5:12, 5:12, pch="X", cex=3) 
                           #EJEMPLO 4
#Grafica datos de precipitacion de un modelo climatico regional en una grilla irregular
data( RCMexample) #cargo los datos
image.plot( RCMexample$x, RCMexample$y, RCMexample$z[,,1])
#agrego el mapa
world( add=TRUE, lwd=2, col="grey")
#hago zoom en una region
ind<- 50:75 #lo usa en las tres coordenadas/ le saco el mapa y puso grillas
image.plot( RCMexample$x[ind,ind], RCMexample$y[ind,ind], RCMexample$z[ind,ind,1],
            border="grey50", lwd=2) #marco los bordes de las grillas en griS
#x<-lat/y<-lon/z<-variable pp de muchos tiempos pero elijo uno
                          #ARROW.PLOT(  paquete fields/ lo uso para el viento)
#EJEMPLO 17- DESCARGAR TODO Y CORRERLO 
  #Tengo que saber cual es la conveccion qu eusa para definir el angulo del viento <- en este caso usamos true.angle=FALSE
  #arrowfun: funcion para las flechas. Default es standard R arrows. Sugieren p.arrows en sfsmisc traza flechas mas bonitas.
  #le puedo decir cada cuento quiero que las grafique ( a las flechas)

#EJEMPLO 18<- GGPLOT 

#lINK DEL FINAL MUESTRA CODIGOS CON DISTINTOS GRAFICOS 