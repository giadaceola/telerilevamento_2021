# R_code_variability.r

# install.packages("RStoolbox")

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra) # per mettere insieme tanti plot di ggplot
# install.packages("viridis")
library(viridis) # per colorare i plot di ggplot in modo automatico

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

# associo le bande 1 e 2 a degli oggetti
nir <- sent$sentinel.1
red <- sent$sentinel.2

# MISURE DI DIVERSITà

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

# uso una finestra mobile di dimensioni 13x13 con dato centrale di dev. standard.
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
# guardo le informazioni di sentpca
summary(sentpca$model)
# la prima componente principale contiene il 67.37% dell'informazione originale

# guardo come si chiamano le variabili
sentpca$map
# ci lego la prima variabile, ossia PC1, e lo associo ad un oggetto
pc1 <- sentpca$map$PC1
# uso la funzione focal per calcolare una moving window di 5x5 calcolando la sd
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)

# funzione source richiama un pezzo di codice che abbiamo già creato
source("source_test_lezione.r.txt")
# pc1 <- sentpca$map$PC1
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)

# utilizzo nuovamente la funzione source per richiamare un pezzo di codice esterno
source("source_ggplot.r.txt")
# pc1 <- sentpca$map$PC1
# plot(pc1)
# focal analysis
# pc1_devst <- focal(pc1, w=matrix(1/9,nrow=3,ncol=3), fun=sd)
# cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
# plot(pc1_devst, col=cl)
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

# ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis()

# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.
# p0 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis() +  ggtitle("viridis palette")

# p1 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="magma") +  ggtitle("magma palette")

# p2 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="plasma") +  ggtitle("plasma palette")

# p3 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="inferno") +  ggtitle("inferno palette")

# p4 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="civids") +  ggtitle("cividis palette")

# p5 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="mako") +  ggtitle("mako palette")

# p6 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="rocket") + ggtitle("rocket palette")

# p7 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="turbo") + ggtitle("turbo palette")

# grid.arrange(p0, p1, p2, p3, p4, p5, p6, p7, nrow = 2) # this needs griExtra


# questo metodo permette di riscontrare discontinuità, ad esempio qualsiasi variabilità geomorfologica, ecologica (per individuare gli ecotoni)
# le nuvole si vedono bene poichè presentano bassissima variabilità e quindi sono molto omogenee
# creo una finestra vuota con ggplot() e poi con + aggiungo le informazioni su geometria (estetiche incluse), palette, titolo
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")

p2 <- ggplot() +
geom_raster(pc1sd5, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") +
ggtitle("Standard deviation of PC1 by magma colour scale")

p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "turbo")  +
ggtitle("Standard deviation of PC1 by turbo colour scale")

# metto insieme i tre grafici in una riga
grid.arrange(p1,p2,p3, nrow=1)




