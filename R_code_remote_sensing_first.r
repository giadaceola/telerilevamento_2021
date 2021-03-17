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

