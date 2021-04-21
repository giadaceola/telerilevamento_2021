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

# faccio una Classificazione Non Supervisionata (Unsupervised Classification), ossia le classi non sono ancora definite, ma vengono scelti i training set direttamente dal software sulla base dei dati di riflettanza
# e associo la funzione ad un oggetto
soc <- unsuperClass(so, nClasses=3)

# plotto l'immagine classificata, in particolare la mappa
# devo quindi legare la mappa all'immagine classificata con il carattere $
plot(soc$map)

# faccio una Unsupervised Classification con 20 classi e visualizzo la mappa
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)
# alternativamente posso usare la funzione set.seed
set.seed(20)

# Download e immagine da:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
# importo l'immagine con la funzione brick
sun <- brick("sun.png")

# faccio una Unsupervised Classification con 3 classi
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)


