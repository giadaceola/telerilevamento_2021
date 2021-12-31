# R code complete -Telerilevamento Geo-Ecologico

# ----------------------------------------------
# ----------------------------------------------

# Summary:

# 1. Remote sensing first code
# 2. R code time series
# 3. R code Copernicus data
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover
# 10. R code variability
# 11. R code spectral signatures

# ----------------------------------------------
# ----------------------------------------------

# 1. Remote sensing first code

#Il mio primo codice in R per il telerilevamento!
#install.packages("raster")
#imposto la working directory per sistema windows
setwd("C:/lab/")

#richiamo la funzione che voglio usare, in questo caso dal pacchetto "raster" installato precedentemente
library(raster)

#importo un'intera immagine satellitare (tutto il pacchetto di bande) dentro R e la associo ad un oggetto
brick("p224r63_2011_masked.grd")
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#leggo i dati di tutti i raster che compongono l'immagine e li visualizzo con la funzione "plot"
p224r63_2011
plot(p224r63_2011)

#cambio la scala di colori: definisco (creando un vettore) una serie con 3 caratteri (in questo caso colori), i quali possono assumere fino a 100 valori
#associo la palette a un oggetto
#plotto le bande, specificando con "col=cl" che come scala di colori voglio quella che ho appena creato
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

#se volessi indicare come primo numero quello delle colonne allora devo scrivere par(mfcol....)

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

#visualizzo l'immagine tramite schema RGB in colori naturali (r=3, g=2, b=1), che è anche il comando di default per la funzione plotRGB
#l'argomento "stretch"serve per prendere i valori di riflettanza delle singole bande e tirarli al fine di evitare che ci sia uno schiacciamento verso una sola parte del colore
#quindi si riescono a mostrare tutti i colori intermedi anche in un ristretto intervallo di valori
#stretch di tipo lineare
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

# ----------------------------------------------
# ----------------------------------------------

# 2. R code time series

# Time series analysis
# Aumento di temperatura in Groenlandia
# Dati e codice di Emanuela Cosma

# install.packages("raster")
# install.packages("rasterVis")
# install.packages("rgdal")
# library(rgdal)
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

# ----------------------------------------------
# ----------------------------------------------

# 3. R code Copernicus data

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

# ----------------------------------------------
# ----------------------------------------------

# 4. R code knitr

# R_code_knitr.r
# uso la funzione knitr per creare un report, quindi pdf unico in cui inserisco più immagini e/o il codice R

#install.packages("knitr")

# imposto la working directory
setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# knitr prende un codice all'esterno di R e lo porta all'interno di R
# richiamo la funzione knitr
library(knitr)

# la funzione stitch prende il codice di riferimento utilizzando il pacchetto knitr e genera il file output, il quale viene salvato nella cartella da cui è stato preso il codice
stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

# ----------------------------------------------
# ----------------------------------------------

# 5. R code multivariate analysis

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
# nella parte alta della matrice sono indicati gli indici di correlazione (va da -1 a 1)
# se sono molto correlate l'indice ha una dimensione dei caratteri più grande
# se c'è grande correlazione, possiamo usare l'analisi multivariata per ridurre il numero di bande nel nostro sistema conservando la stessa informazione 

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
# utilizzo la funzione rasterPCA, che prende il pacchetto di dati e lo compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
# leggo le informazioni dell'oggetto
p224r63_2011res_pca
# guardo il sommario del modello, in cui vedo quanta varianza spiegano le varie bande (componenti)
# uso il $ per legare il modello all'oggetto
summary(p224r63_2011res_pca$model)
# plotto la mappa generata dalla funzione rasterPCA
plot(p224r63_2011res_pca$map)

# plotto in RGB le prime 3 componenti principali (che spiegano quasi il totale della varianza)
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

# ----------------------------------------------
# ----------------------------------------------

# 6. R code classification

# R_code_classification.r

library(raster)
library(RStoolbox)

# imposto la working directory
setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# carico l'immagine del Sole che voglio analizzare e lo associo ad un nome
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so

# visualizzo in RGB i livelli importati
plotRGB(so, 1, 2, 3, stretch="lin")

# faccio una Classificazione Non Supervisionata (Unsupervised Classification), ossia le classi non sono ancora definite, ma vengono scelti i training set casualmente e direttamente dal software sulla base dei dati di riflettanza
# e associo la funzione ad un oggetto
soc <- unsuperClass(so, nClasses=3)

# plotto l'immagine classificata, in particolare la mappa
# devo quindi legare la mappa all'immagine classificata con il carattere $
plot(soc$map)

# faccio una Unsupervised Classification con 20 classi e visualizzo la mappa
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

# Download e immagine da:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
# importo l'immagine con la funzione brick
sun <- brick("sun.png")

# faccio una Unsupervised Classification con 3 classi
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

# Grand Canyon
# https://landsat.visibleearth.nasa.gov/view.php?id=80948

# importo l'immagine satellitare (le "" perché esco da R per andare a prenderla) e la associo a un oggetto
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
# plotto in RGB
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
# plotto in RGB ma con stretch di tipo histogram
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# faccio un modello di classificazione non supervisionata con 2 classi (discriminazione avviene sulla base della riflettanza)
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
# plotto la mappa in uscita legata al modello creato
plot(gcc2$map)
# unsupervised classification con 4 classi
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

# ----------------------------------------------
# ----------------------------------------------

7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

# ----------------------------------------------
# ----------------------------------------------

# 8. R code vegetation indices

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
# DVI=NIR-RED (per ogni pixel, differenza tra i valori dei pixel nella banda dell'infrarosso e i valori dei pixel nella banda del rosso)
# lego la banda all'immagine con il simbolo $
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
# NDVI permette di confrontare immagini che hanno risoluzione radiometrica (numero di bit) differente
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

# funzione "spectralIndeces" del pacchetto RStoolbox calcola una serie di indici spettrali
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
# con la libreria rasterVis, faccio un levelplot in cui sulle assi c'è un profilo indicante i valori medi per ogni riga/colonna
# dà un'idea dell'estensione della biomassa vegetale nel mondo
levelplot(copNDVI)

# ----------------------------------------------
# ----------------------------------------------

# 9. R code land cover

# R_code_land_cover.r

library(raster)
library(RStoolbox) # per la classificazione
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra)

setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# NIR 1, RED 2, GREEN 3

# carico il dataset, che in questo caso è un'immagine satellitare con tante bande, quindi uso la funzione brick
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
# creo un'immagine singola da tre bande (con coordinate spaziali)
ggRGB(defor1, r=1, g=2, b=3, stretch="Lin")

# stessa cosa per defor2
defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# confronto le due immagini RGB
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# creo un multiframe con due immagini ggRGB (sono necessari i pacchetti ggplot2 e gridExtra), utilizzando la funzione grid.arrange 
# prendo prima i due plot e li associo ad un nome
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

# classificazione non supervisionata, con 2 classi
d1c <- unsuperClass(defor1, nClasses=2)
# la classe della foresta amazzonica è di colore verde (2), la parte agricola di colore bianco (1)
# set.seed()
# plotto la mappa
plot(d1c$map)
# stessa cosa per defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
# la classe della foresta amazzonica è di colore bianco (1), la parte agricola di colore verde (2)
 # classificazione non supervisionata con 3 classi
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

# calcolo la frequenza dei pixel di una certa classe
freq(d1c$map)
#     value  count
# [1,]     1  34784
# [2,]     2 306508
 # faccio la somma dei pixel, corrispondente ai pixel totali
s1 <- 34784 + 306508 
s1
# faccio la proporzione (frequenza/totale)
prop1 <- freq(d1c$map)/s1
prop1
# prop foresta: 0.8980814
# prop agricoltura: 0.1019186

# stessa cosa per la seconda immagine, che prò ha un numero totale di pixel diverso
s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
# prop foresta: 0.5185396
# prop agricoltura: 0.4814604

# genero un dataframe
# prima colonna
cover <- c("Forest","Agriculture")
# seconda colonna
percent_1992 <- c(89.80, 10.19)
percent_2006 <- c(51.85, 48.14)
# le unisco in un dataframe
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

# creo un grafico di questo dataframe con ggplot2
# colore in base alle classi
# con l'argomento geom_bar creo delle barre
# dati che indico io, quindi "identity"
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
# metto i due grafici in una finestra unica
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1,p2, nrow=1)

# ----------------------------------------------
# ----------------------------------------------

# 10. R code variability

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

# p4 <- ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="cividis") +  ggtitle("cividis palette")

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

# ----------------------------------------------
# ----------------------------------------------

# 11. R code spectral signatures

# R_code_spectral_signatures.r

library(raster)
library(rgdal)
library(ggplot2)

setwd("C:/lab/") # windows
# setwd("~/lab/") # linux
# setwd("/Users/utente/lab") #mac

# carico tutte le bande
defor2 <- brick("defor2.jpg")

# defro2.1, defor2.2, defor2.3
# NIR, red, green

# plotto in RGB
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# oppure
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

# creo una firma spettrale
# uso la funzione "click" con l'immagine aperta
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# creo valore identificativo per ogni punto con id=T, informazione spaziale con xy=T
# cliccando sul pixel cell=T

# clicco sull'immagine e R mi restituisce le informazioni riguardanti quel pixel, segnando con un pallino giallo numerato sulla mappa

# risultati:
# foresta integra
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 142.5 241.5 169355      201       17       29

# acqua
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 411.5 100.5 270721       66       73      127

# creo un dataframe
# inizialmente devo creare uno storage
# definisco le colonne del dataset
band <- c(1, 2, 3)
forest <- c(201, 17, 29)
water <- c(66, 73, 127)

# metto insieme le colonne per fare il dataframe
spectrals <- data.frame(band, forest, water)
spectrals

# plotto le firme spettrali
ggplot(spectrals, aes(x=band)) +
  geom_line(aes(y=forest), color="green") +
  geom_line(aes(y=water), color="blue") +
  labs(x="band", y="reflectance")
  
# con "labs" si modificano i nomi degli assi  

### analisi multitemporale
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

# firme spettrali di defor1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 70.5 339.5 98603      200        2       17
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 57.5 339.5 98590      201        3       18
#     x     y   cell defor1.1 defor1.2 defor1.3
# 1 34.5 335.5 101423      200       24       34
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 43.5 342.5 96434      198        5       24
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 72.5 375.5 72901      218       19       38

# firme spettrali di defor2
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 106.5 337.5 100487      186      189      162
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 90.5 341.5 97603      199      156      147
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 77.5 340.5 98307      168      155      146
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 107.5 353.5 89016      180      137      130
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 64.5 353.5 88973      171      172      158

# creo il dataset
band <- c(1,2,3)
time1 <- c(200,2, 17)
time1p2 <- c(201,3,18)
time2 <- c(186, 189, 162)
time2p2 <- c(199,156,147)
spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

# plotto le firme
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red", linetype="dotted") +
 geom_line(aes(y=time1p2), color="red", linetype="dotted") +
 geom_line(aes(y=time2), color="gray", linetype="dotted") +
 geom_line(aes(y=time2p2), color="gray", linetype="dotted") +
 labs(x="band",y="reflectance")

# immagine da Earth Observatory
eo <- brick("june_puzzler.jpg")
plotRGB(eo, 1, 2, 3, stretch="hist")
click(eo, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#     x     y  cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 1 91.5 380.5 71372            214            179              1
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 1 253.5 200.5 201134             49            102             10
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 1 502.5 129.5 252503             35             26             19

band <- c(1,2,3)
stratum1 <- c(214, 179, 1)
stratum2 <- c(49, 102, 10)
stratum3 <- c(35, 26, 19)

spectralsg <- data.frame(band, stratum1, stratum2, stratum3)

ggplot(spectralsg, aes(x=band)) +
 geom_line(aes(y=stratum1), color="yellow") +
 geom_line(aes(y=stratum2), color="green") +
 geom_line(aes(y=stratum3), color="blue") +
 labs(x="band",y="reflectance")















