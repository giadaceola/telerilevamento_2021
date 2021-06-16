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







