#Il mio primo codice in R per il telerilevamento!
#install.packages("raster")
#imposto la working directory per sistema windows
setwd("C:/lab/")

#richiamo la funzione che voglio usare, in questo caso dal pacchetto raster installato
library(raster)

#importo i dati raster dentro R e lo associo ad un nome
brick("p224r63_2011_masked.grd")
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#leggo i dati di questo raster e lo visualizzo
p224r63_2011
plot(p224r63_2011)

#cambio la scala di colori con 3 caratteri (colori), i quali possono assumere 100 valori
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(p224r63_2011, col=cl)

#ulteriore cambio della scala di colori
cln<-colorRampPalette(c("blue","green","red","yellow","pink")) (100)
plot(p224r63_2011, col=cln)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#ripulisco la finestra grafica
dev.off()

#lego la banda 1 all'immagine satellitare totale e la plotto con i colori predefinti di R
plot(p224r63_2011$B1_sre)
#plotto la banda 1 utilizzando la color ramp palette che ho precedentemente definito (cln)
cln<-colorRampPalette(c("blue","green","red","yellow","pink")) (100)
plot(p224r63_2011$B1_sre, col=cln)

dev.off()

#preparo una finestra grafica multiframe in cui i plot sono disposti in 1 riga, 2 colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#2 righe, 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plotto le prime quattro bande di Landsat in 4 righe, 1 colonna
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#2 righe, 2 colonne
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#plotto le quattro bande in disposizione 2x2, ognuna con la propria palette
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

#visualizzo i dati plottando in RGB (schema per visualizzare le immagini per cui assegno max 3 bande per volta alle componenti red, green e blue)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#visualizzo l'immagine tramite schema RGB in colori naturali
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#visualizzo l'immagine tramite schema RGB in falsi colori
#monto la banda 4 sulla componente red, la banda 3 sulla componente green, la banda 2 sulla componente blue
#la vegetazione apparirà rossa poiché riflette molto nel NIR (infrarosso vicino - banda 4)
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# r=3, g=4, b=2
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

# r=3, g=2, b=4
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#multiframe 2x2 con i precedenti 4 plot
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#salvo l'immagine in pdf
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

#plotto in RGB con uno stretch di tipo histogram, che evidenzia maggiormente le differenti componenti nell'immagine
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#confronto tra immagine a colori naturali, in falsi colori con stretch lineare e in falsi colori con stretch histogram
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#faccio un confronto multitemporale, quindi tra l'immagine del 2011 e l'immagine del 1988
#importo l'intera immagine satellitare (quindi tutte le bande) del 2011 e quella del 1988 (riferita sempre alla stessa area, definita dal path 224 e dalla row 63)
#le associo ad un nome
#setwd("C:/lab/")
#library(raster)
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988

#plotto le singole bande dell'immagine del 1988
plot(p224r63_1988)

#plotto in RGB con r (componente red) =3 (banda 3), g=2, b=1
#stretch lineare (per visualizzare tutta la gamma da 0 a 1 dei valori di riflettanza, anche nel caso di range di valori che non coprono tutti i valori da 0 a 1 di riflettanza)
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
# r=4, g=3, b=2
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#confronto le due immagini sempre con plot in RGB con r=4, g=3, b=2, 2 righe 1 colonna
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#confronto le due immagini (per vedere la variazione multitemporale), anche tra stretch lineare e stretch histogram
# multiframe 2x2
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
#creo un pdf della variazione multitemporale
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()


