# R_code_variability.r

# install.packages("RStoolbox")
library(raster)
library(RSToolbox)

setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# importo l'immagine Sentinel
sent <- brick("sentinel.png")

# NIR 1, RED 2, GREEN 3
# plotto in RGB con la sequenza di default (r=1, g=2, b=3)
plotRGB(sent, stretch="lin")
# equivale a scrivere plotRGB(sent, r=1, g=2, b=3, stretch="lin")
# plotto con r=2, g=1, b=3
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

# associo le componenti 1 e 2 a degli oggetti
nir <- sent$sentinel.1
red <- sent$sentinel.2

# calcolo l'indice di vegetazione e lo plotto
ndvi <- (nir-red) / (nir+red)
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

# calcolo della variabilità con la deviazione standard
# creo una finestra mobile di 3x3 pixel con dato centrale deviazione standard
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=clsd)

# calcolo della variabilità con la media
# creo una finestra mobile di 3x3 pixel con dato centrale media
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvimean3, col=clsd)

# uso una finestra di dimensioni 13x13 con dato centrale di dev. standard.
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd13, col=clsd)
# 5x5
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)

# prendo un sistema a multibande, ne calcolo la PCA e utilizzo solo la prima componente principale
sentpca <- rasterPCA(sent)
plot(sentpca$map)
summary(sentpca$model)
# la prima componente principale contiene il 67.37% dell'informazione originale




