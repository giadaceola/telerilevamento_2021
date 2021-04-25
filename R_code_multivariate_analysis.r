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


