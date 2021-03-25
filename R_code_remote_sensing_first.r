#Il mio primo codice in R per il telerilevamento!
#install.packages("raster")

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


