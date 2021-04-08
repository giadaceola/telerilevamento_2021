# Time series analysis
# Aumento di temperatura in Groenlandia
# Dati e codice di Emanuela Cosma

# install.packages("raster")
library(raster)

# definisco la working directory per Windows
setwd("C:/lab/greenland")
# setwd("~/lab/greenland") # Linux
# setwd("/Users/name/Desktop/lab/greenland") # Mac

# importo i dataset di land surface temperature (funzione raster singola, quindi in questo caso importo i singoli dati, e non tutto il pacchetto di layer)
lst_2000 <- raster ("lst_2000.tif")
# plotto il dataset
plot(lst_2000)
# importo lst del 2005 e lo plotto
lst_2005 <- raster ("lst_2005.tif")
plot(lst_2005)
# importo lst del 2010 e del 2015 e le plotto
lst_2010 <- raster ("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster ("lst_2015.tif")
plot(lst_2015)
# plotto tutte e 4 le immagini insieme
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# importo i 4 dataset tutti insieme (applico la funzione raster a una lista di file, in questo caso quelli che si chiamano lst)
# creo inizialmente una lista di file che in comune hanno la scritta "lst", e la associo la lista ad un oggetto
rlist <- list.files(pattern="lst")
rlist
# applico la funzione raster a tutta la lista appena creata e la associo ad un nome
import <- lapply(rlist,raster)
import
# una volta importati tutti i singoli file, creiamo un file unico che li raggruppi e gli do un nome
TGr <- stack(import)
# plotto il file unico che ho creato (composto dai 4 lst)
plot(TGr)

# faccio un plot RGB (di valori di temperatura) in cui associo lst del 2000 alla componente red, lst del 2005 alla componente green, lst del 2010 alla componente blue
# la componente più visibile è quella a cui corrispondono valori di lst più alti nel tif associato a quella componente
plotRGB(TGr, 1, 2, 3, stretch="Lin")







