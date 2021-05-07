# R_code_land_cover.r

library(raster)
library(RStoolbox) # per la classificazione
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra)

setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# NIR 1, RED 2, GREEN 3

# carico il dataset, che in questo caso è un'immagine satellitare con tante bande, quindi uso la funzione brick
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
# creo un'immagine singola da tre bande (con coordinate spaziali)
ggRGB(defor1, r=1, g=2, b=3, stretch="Lin")

# stessa cosa per defor2
defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# confronto le due immagini RGB
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# creo un multiframe con due immagini ggRGB (sono necessari i pacchetti ggplot2 e gridExtra), utilizzando la funzione grid.arrange 
# prendo prima i due plot e li associo ad un nome
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

# classificazione non supervisionata, con 2 classi
d1c <- unsuperClass(defor1, nClasses=2)
# la classe della foresta amazzonica è di colore verde (2), la parte agricola di colore bianco (1)
# set.seed()
# plotto la mappa
plot(d1c$map)
# stessa cosa per defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
# la classe della foresta amazzonica è di colore bianco (1), la parte agricola di colore verde (2)
 # classificazione non supervisionata con 3 classi
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

# calcolo la frequenza dei pixel di una certa classe
freq(d1c$map)
#     value  count
# [1,]     1  34784
# [2,]     2 306508
 # faccio la somma dei pixel, corrispondente ai pixel totali
s1 <- 34784 + 306508 
s1
# faccio la proporzione (frequenza/totale)
prop1 <- freq(d1c$map)/s1
prop1
# prop foresta: 0.8980814
# prop agricoltura: 0.1019186

# stessa cosa per la seconda immagine, che prò ha un numero totale di pixel diverso
s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
# prop foresta: 0.5185396
# prop agricoltura: 0.4814604

# genero un dataframe
# prima colonna
cover <- c("Forest","Agriculture")
# seconda colonna
percent_1992 <- c(89.80, 10.19)
percent_2006 <- c(51.85, 48.14)
# le unisco in un dataframe
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

# creo un grafico di questo dataframe con ggplot2
# colore in base alle classi
# con l'argomento geom_bar creo delle barre
# dati che indico io, quindi "identity"
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
# metto i due grafici in una finestra unica
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1,p2, nrow=1)






