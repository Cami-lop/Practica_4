#############################Clase Practica 2/11###################
# Data frame-funcio aggregate
getwd()
setwd("/home/clinux01/Escritorio/CamiLabo/Practica_4/")
aggregate(x, # Objeto de R
          by, # Lista de variables (elementos que forman los grupos)
          FUN, # Función a ser aplicada para crear el resumen estadístico
          ..., # Argumentos adicionales a ser pasados a FUN
          simplify = TRUE, # Simplificar el resultado lo máximo posible (TRUE) o no (FALSE)
          drop = TRUE) # Deshechar las combinaciones no usadas de grupos (TRUE) o no (FALSE).
#Usamos siguiente conjunto de datos de R
df <- chickwts
head(df)
group_mean <- aggregate(df$weight, list(df$feed), mean) #applicmelo sobre el peso pero en funcion de la comida que hay / hace la media de los pesos  por comidas 
group_mean <- aggregate(weight ~ feed, data = df, mean) # Equivalente
group_mean
class(group_mean)
                               #LENGHT
aggregate(chickwts$feed, by = list(chickwts$feed), FUN = length)  #calculo cuantos tengo en cada comida
#Vamos a crear una nueva variable categórica llamada cat_var.
set.seed(1)
cat_var <- sample(c("A", "B", "C"), nrow(df), replace = TRUE)
df_2 <- cbind(df, cat_var)
head(df_2)
#le puedo dar mas de una especificacion en by (me hace dos grupos)
#Aplico la funcion "sum" teniendo en cuenta la categoria del feed y de cat_var
aggregate(df_2$weight, by = list(df_2$feed, df_2$cat_var), FUN = sum) 
#le puedo aplicar la funcion que quiera <- por ejemplo una que yo hice
----------------------------------------------------------------------------------
############################GGPLOT PARTE 2#######################################
library(ggplot2)
library(lubridate)
getwd()
gualeguaychu <- read.csv("gualeguaychu.csv") #tien "," separando lso datos ???odria usar read.table pero aclararle que estan separados por comas 
head(gualeguaychu)
class(gualeguaychu)
#acorto los datos
gualeguaychu <- gualeguaychu[year(gualeguaychu$Fecha) >= 2010 &
                               year(gualeguaychu$Fecha) <= 2018,]
gualeguaychu_2018 <- gualeguaychu[year(gualeguaychu$Fecha) == 2018,]

p <- ggplot(data = gualeguaychu_2018, mapping = aes(x=Fecha, y=pre))  #queda feo 
p<- p + geom_col()
#corrijo el grafico, como puse moths suma los repetidos 
p <- ggplot(data = gualeguaychu_2018, mapping = aes(x= month(Fecha), y=pre))
p<- p + geom_col()
p <- p + labs(title = "Precipitación mensual acumulada 2018",
              subtitle = "Estación: Gualeguaychu",
              x = "Mes",
              y = "Precipitación (mm)")
p <- p + scale_x_continuous(breaks = c(1:12)) 
#cambia el eje x poniendo los meses porque antes habia numeros raros que no eran representativos de la variable 
#grafica lo que tiene como no tiene diciembre no grafica eos datos 
                         #OTRO EJEMPLO DE BARRAS
#Ahora supongamos que queremos ver la información de varios años.
#Usemos los datos del periodo 2010-2018 y calculemos la suma de la
#precipitación para cada mes de ese periodo. Usamos aggregate
#PARA PODER USAR EL AGGREGATE, AGREGAMOS COLUMNAS 
#aggregate no le pone nombres a la columna 
gualeguaychu$year <- year(gualeguaychu$Fecha)
gualeguaychu$month <- month(gualeguaychu$Fecha)
suma_PP_mensual <- aggregate(x=gualeguaychu$pre,by=list(gualeguaychu$year,gualeguaychu$month),FUN="sum")
#Cambio los nombres de las columnas
colnames(suma_PP_mensual) <- c("Year", "Month", "Precip")
head(suma_PP_mensual)
tail(suma_PP_mensual)
#Grafico
suma_PP_mensual$Fecha<- paste(suma_PP_mensual$Year,suma_PP_mensual$Month,sep="-")
#OTRA OPCCION<-suma_PP_mensual$Fecha2<- seq.Date(from = as.Date("2010-01-01"),to=as.Date("2018-10-01"),by="month")
p<- ggplot(suma_PP_mensual, aes(x=Fecha, y=Precip)) +
  geom_col(aes(fill = factor(Year)), position = "dodge") + #QUE LAS PINTE EN FUNCIOON DEL FACTOR AÑO
  labs(title = "Precipitación mensual en Gualeguaychu",
       x = "Mes",
       y = "Precipitación [mm]",
       fill = "Year")
#puede ser confuso, entonces hago un panel por año
#uso facet_wrap()
p<-ggplot(suma_PP_mensual, aes(Month, Precip)) +
  geom_col() +
  facet_wrap(~Year, ncol =4) +
  labs(title = "Precipitación mensual en Gualeguaychu",
       x = "Mes",
       y = "Precipitación [mm]") + scale_x_continuous(breaks =seq(1,12,1))
                              #HISTOGRAMA
#Vamos a construir un histograma con todos los datos de precipitación del periodo 2010-2018.
p<-ggplot(gualeguaychu, mapping = aes(x=pre))+
  geom_histogram()
#como hay mucho valor con cero, "los saco"
#armo un df solo con los datos son mayores a cero
precip_gualeguaychu<- gualeguaychu[gualeguaychu$pre>0, ]
p <-ggplot(data = precip_gualeguaychu ,aes(pre))
p <- p + geom_histogram(breaks= seq(0,200,10))
#le agregue color, y titulos en los ejes y el principal
p <- p + geom_histogram(breaks= seq(0,200,10), fill= "blue", col= "black")
p <- p + labs(title = "Histograma de precipitación diaria en Gualeguaychu",
              subtitle = "Periodo 2000-2010",
              x = "Precipitación (mm)",
              y = "Frecuencia")
#fill <-relleno col <- el borde
                           #BOXPLOT
box <-ggplot(data = precip_gualeguaychu ,aes(y= pre))
box <- box + geom_boxplot()

#Podemos retocar algunos argumentos para que el boxplot quede más lindo
box <- box + geom_boxplot(outlier.colour = "black", outlier.size = 1, notch = TRUE,fill = "#E69F00")
box <- box + labs(title = "Boxplot de precipitación diaria en Gualeguaychu",
                  subtitle = "Periodo 2000-2010",
                  y = "Precipitación (mm)")
box <- box + stat_boxplot(geom = "errorbar") +xlim(c(-2, 2))
