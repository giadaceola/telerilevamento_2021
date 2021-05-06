# R_code_vegetation_indices.r

library(raster)
library(RStoolbox) # per calcolare gli indici di vegetazione
# install.packages("rasterdiv")
library(rasterdiv)  # per NDVI in tutto il mondo
# install.packages("rasterVis")
library(rasterVis)

setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# carico le immagini, quindi carico dei pacchetti di dati con la funzione "brick"
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1= NIR, b2= red, b3= green
# plotto in RGB le due immagini associando NIR alla componente red
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# calcolo l'indice di vegetazione DVI prima e dopo, e li associo ad un oggetto
# trovo prima il nome delle variabili (bande)
defor1
# DVI=NIR-RED (differenza tra i valori dei pixel nella banda dell'infrarosso e i valori dei pixel nella banda del rosso).
dvi1 <- defor1$defor1.1 - defor1$defor1.2
# visualizzo il DVI1
plot(dvi1)
# uso una palette differente
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")

# utilizzo la stessa procedura per il DVI2
defor2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")

# plotto i due DVI insieme
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# trovo la differenza di DVI tra tempo 1 e tempo 2, per vedere come è cambiato
difdvi <- dvi1 - dvi2
# plotto questa differenza con una nuova palette
# dove ho valori di differenza più elevate vedo il colore rosso
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

# calcolo l'NDVI, ossia il difference vegetation index, in cui il DVI è normalizzato con la somma di NIR e red
# NDVI permette di confrontare immagine che hanno risoluzione radiometrica (numero di bit) differenti
# NDVI ha sempre lo stesso range di valori (-1 < NDVI < 1), indipendentemente dalle immagini
# NDVI= (NIR - RED) / (NIR+RED)
# NDVI per il tempo 1
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
plot(ndvi1, col=cl)
#NDVI per il tempo 2
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2)/(defor2$defor2.1+defor2$defor2.2)
plot(ndvi2, col=cl)
# faccio la differenza tra i due ndvi
difndvi <- ndvi1 - ndvi2
plot(difndvi, col=cld)

# funzione "spectralIndeces" del pacchetto RStoolbox calcola una serie di indici di vegetazione
vi1 <- spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi1, col=cl)
vi2 <- spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)

# worldwide NDVI
# plotto il database copNDVI
plot(copNDVI)
# tolgo la parte dell'acqua con la funzione cbind
# con la funzione cbind e reclassify posso trasformare i pixel con i valori di 253, 254 e 255 (corrispondenti all'acqua) in non valori NA.
# lo sovrascrivo su copNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
# faccio un levelplot, in cui sulle assi c'è un profilo indicante i valori medi per ogni riga/colonna
levelplot(copNDVI)







