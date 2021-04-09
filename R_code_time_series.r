# Time series analysis
# Aumento di temperatura in Groenlandia
# Dati e codice di Emanuela Cosma

# install.packages("raster")
# install.packages("rasterVis")
library(raster)
library(rasterVis)

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
# applico la funzione raster a tutta la lista di file appena creata, e associo ad un oggetto
import <- lapply(rlist,raster)
import
# una volta importati tutti i singoli file, creo un file unico che li raggruppi e lo associo ad un oggetto
TGr <- stack(import)
TGr
# plotto il file unico che ho creato (composto dai 4 lst)
plot(TGr)

# faccio un plot RGB (di valori di temperatura) in cui associo lst del 2000 alla componente red, lst del 2005 alla componente green, lst del 2010 alla componente blue
# la componente più visibile è quella a cui corrispondono valori di lst più alti nel tif associato a quella componente
plotRGB(TGr, 1, 2, 3, stretch="Lin")

# creo un grafico con le 4 immagini lst del file unico TGr
levelplot(TGr)
# creo un grafico solamente dello strato lst del 2000, per vedere come varia la temperatura nell'area
# nella parte alta e in quella a destra del grafico osservo i valori medi di lst per ogni singola colonna e per ogni singola riga
# dove ci sono i ghiacci si nota che la curva del grafico della lst diminuisce
levelplot(TGr$lst_2000)

# definisco una palette di colori
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
# plotto TGr con la nuova palette
levelplot(TGr, col.regions=cl)

# plotto TGr definendo con un nome gli attributi (singoli blocchi) e il titolo ("main")
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# uso i dati "melt"
# creo una lista file dei file che hanno in comune la scritta "melt", e la associo ad un oggetto
meltlist <- list.files(pattern="melt")
meltlist
# applico la funzione raster a tutta la lista di file appena creata, e associo ad un oggetto
melt_import <- lapply(meltlist,raster)
melt_import
# una volta importati tutti i singoli file, creo un file unico che li raggruppi e lo associo ad un oggetto
melt <- stack(melt_import)
melt
# plotto melt
levelplot(melt)

# applico l'algebra alle matrici di numeri (corrispondenti alle immagini), così ottengo la differenza nei valori dei pixel tra un anno e un altro
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
# definisco una palette
clb <- colorRampPalette(c("blue","white","red"))(100)
# faccio un plot della differenza (associata all'oggetto melt_amount)
# i valori più alti riflettono un maggiore scioglimento (perché il ghiaccio non riflette, quindi se ci sono dei valori di riflettanza significa che non c'è ghiaccio)
plot(melt_amount, col=clb)
# faccio un levelplot della differenza (associata all'oggetto melt_amount)
# picchi più alti nella curva riflettono maggior scioglimento
levelplot(melt_amount, col.regions=clb)


        
        
  







