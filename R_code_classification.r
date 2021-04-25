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








