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







