# R_code_copernicus.r
# visualizzo i dati Copernicus

# install.packages("ncdf4")
# richiamo i pacchetti che utilizzo
library(raster)
library(ncdf4)

# imposto la working directory
setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# associo il mio dataset (è un singolo strato, quindi utilizzo la funzione raster) a un oggetto
albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
albedo

# avendo un singolo strato, posso associare la scala di colori da visualizzare
cl <- colorRampPalette(c('blue','green','red','yellow'))(100)
# plotto la variabile in questione con la palette creata
plot(albedo, col=cl)

# Resampling - ricampionamento (questo tipo è detto bilineare)
# ricampiono il dataset, quindi diminuisco la risoluzione in modo da ottenere pixel più grandi (alleggerisco l'immagine)
# utilizzo la funzione 'aggregate' per aggregare i pixel
# prendo un pixel più grande e il suo valore lo ottengo dalla media dei valori dei pixel più piccoli all'interno, ossia quelli che sto aggregando
# il fattore per il resample è il fattore di quanto diminuisco il numero di pixel 
# esempio, fact=100 vuol dire che diminuisco linearmente di 100 volte, ossia ogni 100x100 pixel ho 1 pixel (diminuisco di 10000 volte il dato originale)
albedores <- aggregate(albedo, fact=100)
albedores
# plotto il dataset ricampionato
plot(albedores, col=cl)



