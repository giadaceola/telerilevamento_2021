# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# carico l'immagine satellitare (un set multiplo di dati, quindi uso la funzione brick, altrimenti userei la funzione raster)
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# plotto l'immagine
plot(p224r63_2011)

# plotto i valori della banda del blu vs. banda del verde
# prima richiamo le informazioni dell'oggetto per vedere i nomi delle bande da inserire nella funzione
p224r63_2011
# plotto la banda 1 (B1_sre) che appartiene ($) al nostro set (p224r63_2011) contro la banda 2
# faccio i punti rossi (col="red")
# pch è il carattere dei punti
# cex è l'argomento per la grandezza dei caratteri
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

# uso la funzione pairs per plottare tutte le correlazioni (a due a due) possibili tra tutte le variabili (in questo caso sono le nostre bande) in un dataset
pairs(p224r63_2011)
# nella parte alta della matrice sono indicati gli indici di correlazione (va da -1 a 1, in cui 1 è correlazione perfetta)
# se sono molto correlate l'indice ha una dimensione dei caratteri più grande
# se c'è grande correlazione, possimo usare l'analisi multivariata per ridurre il numero di bande nel nostro sistema conservando la stessa informazione 

# Ricampionamento (resampling)
# poiché la PCA è piuttosto pesante, creo un'immagine alleggerita con la funzione aggregate
# con "aggregate" diminuisco la risoluzione di 10 volte linearmente (fact=10), quindi aggrego le celle
# lo associo ad un oggetto (suffisso res mi indica che è stato fatto un resampling)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res
# visualizzo il risultato, confrontandolo con l'originale, in RGB in cui la banda dell'infrarosso la associo alla componente red
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

# PCA - Principal Components Analysis
# utilizzo la funzione rasterPCA
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
# leggo le informazioni dell'oggetto
p224r63_2011res_pca
# guardo il sommario del modello, in cui vedo quanta varianza spiegano le varie bande (componenti)
summary(p224r63_2011res_pca$model)
# plotto la mappa generata dalla funzione rasterPCA
plot(p224r63_2011res_pca$map)

# plotto in RGB le prime 3 componenti principali (che spiegano quasi il totale della varianza)
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")



