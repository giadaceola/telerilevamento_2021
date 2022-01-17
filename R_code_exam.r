# R_code_exam.r

library(raster)
library(ggplot2)
library(gridExtra)
library(RStoolbox)

setwd("C:/lab/danubio")

# creo le due liste di file contenenti le bande(con pattern "T35TPK_20180717T085601" e "T35TPK_20210731T085601")
primalist <- list.files(pattern="T35TPK_20180717T085601")
primalist
dopolist <- list.files(pattern="T35TPK_20210731T085601")
dopolist
# importo le bande delle due liste con un unico comando in cui si esegue la funzione raster su tutte le bande
primaimport <- lapply(primalist,raster)
primaimport
dopoimport <- lapply(dopolist,raster)
dopoimport
# unisco le bande in un'unica immagine
dan2018<-stack(primaimport)
dan2021<-stack(dopoimport)

# b1= blue
# b2= green
# b3= red
# b4= nir

# definisco le palette
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
clg <- colorRampPalette(c("dark green","green","light green")) (100)
clr <- colorRampPalette(c("dark red","red","pink")) (100)
clnir <- colorRampPalette(c("red","orange","yellow")) (100)

# plot delle 4 bande 2021 con le palette
par(mfrow=c(2,2))
plot(dan2021$T35TPK_20210731T085601_B02, col=clb, main="Banda blu")
plot(dan2021$T35TPK_20210731T085601_B03, col=clg, main="Banda verde")
plot(dan2021$T35TPK_20210731T085601_B04, col=clr, main="Banda rosso")
plot(dan2021$T35TPK_20210731T085601_B08, col=clnir, main="Banda nir")

# plot delle 4 bande 2018 con le palette
par(mfrow=c(2,2))
plot(dan2018$T35TPK_20180717T085601_B02, col=clb, main="Banda blu")
plot(dan2018$T35TPK_20180717T085601_B03, col=clg, main="Banda verde")
plot(dan2018$T35TPK_20180717T085601_B04, col=clr, main="Banda rosso")
plot(dan2018$T35TPK_20180717T085601_B08, col=clnir, main="Banda nir")

# plot dei due anni in colori naturali (3,2,1) e 4,2,1
#library(ggplot2)
#library(gridExtra)
#library(RStoolbox)
p321<-ggRGB(dan2021, 3,2,1, stretch="lin")
p421<-ggRGB(dan2021, 4,2,1, stretch="lin")
p318<-ggRGB(dan2018, 3,2,1, stretch="lin")
p418<-ggRGB(dan2018, 4,2,1, stretch="lin")
grid.arrange(p321, p421, p318, p418, nrow = 2)

# ricampiono l'immagine 2021 con fattore 50
dan2021r <- aggregate(dan2021, fact=50)
plot(dan2021r)

# confronto tra l'immagine originale e l'immagine ricampionata
par(mfrow=c(2,1))
plotRGB(dan2021, 4,2,1, stretch="lin")
plotRGB(dan2021r, 4,2,1, stretch="lin")


### Analisi delle componenti principali

# plotto le correlazioni tra tutte le bande
pairs(dan2021r, main="Correlazioni tra variabili")

#RStoolbox
# eseguo l'analisi delle componenti principali
dan2021r_pca<-rasterPCA(dan2021r)
dan2021r_pca
# richiamo il summary del modello (con $) per guardare le informazioni sulle componenti principali
summary(dan2021r_pca$model)
#Importance of components:
#                             Comp.1       Comp.2       Comp.3       Comp.4
#Standard deviation     1484.2245787 428.03193377 91.044972644 3.900148e+01
#Proportion of Variance    0.9194382   0.07646728  0.003459674 6.348711e-04
#Cumulative Proportion     0.9194382   0.99590545  0.999365129 1.000000e+00

# plotto solo la prima componente principale
plot(dan2021r_pca$map$PC1, main="PC1")


### Differenza NDVI

# NDVI 2021
# associo le bande agli oggetti nir e red, poi calcolo NDVI e lo plotto
nir21<-dan2021r$T35TPK_20210731T085601_B08
red21<-dan2021r$T35TPK_20210731T085601_B04
ndvi21 <- (nir21-red21) / (nir21+red21)
plot(ndvi21, main="NDVI 2021")

# NDVI 2018
dan2018r <- aggregate(dan2018, fact=50)
nir18<-dan2018r$T35TPK_20180717T085601_B08
red18<-dan2018r$T35TPK_20180717T085601_B04
ndvi18 <- (nir18-red18) / (nir18+red18)
plot(ndvi18, main="NDVI 2018")
dev.off()

# plotto ndvi 2018 e ndvi 2021 insieme
par(mfrow=c(1,2))
plot(ndvi18, main="NDVI 2018")
plot(ndvi21, main="NDVI 2021")
dev.off()

# differenza tra ndvi 2021 e ndvi 2018
difndvi <- ndvi21 - ndvi18
# definisco la palette e plotto la differenza di ndvi con questa palette
cld <- colorRampPalette(c('red','white','green'))(100)
plot(difndvi, col=cld, main="Differenza tra NDVI del 2021 e NDVI del 2018")
dev.off()


### Classificazione non supervisionata
#RStoolbox
dan2021rc3 <- unsuperClass(dan2021r, nClasses=3)
plot(dan2021rc3$map, main="Classificazione non supervisionata 2021 con 3 classi")
dev.off()

dan2018rc4 <- unsuperClass(dan2018r, nClasses=4)
plot(dan2018rc4$map, main="Classificazione non supervisionata 2018 con 4 classi")
dev.off()

# Calcolo della frequenza dei pixel delle varie classi
freq(dan2021rc3$map)
#     value count
#[1,]     1 13755
#[2,]     2 11628
#[3,]     3 23017
# sommo tutti i pixel di tutte le classi
sum21<-13755+11628+23017
sum21
# divido la frequenza di ciascuna classe per la somma per trovare le proporzioni
prop21 <- freq(dan2021rc3$map)/sum21
prop21
#            value     count
#[1,] 2.066116e-05 0.2841942
#[2,] 4.132231e-05 0.2402479
#[3,] 6.198347e-05 0.4755579

# faccio la stessa cosa per la classificazione del 2018
freq(dan2018rc4$map)
#     value count
#[1,]     1   376
#[2,]     2 12631
#[3,]     3 12322
#[4,]     4 23071
sum18<-376+12631+12322+23071
sum18
prop18 <- freq(dan2018rc4$map)/sum18
prop18
#            value       count
#[1,] 2.066116e-05 0.007768595
#[2,] 4.132231e-05 0.260971074
#[3,] 6.198347e-05 0.254586777
#[4,] 8.264463e-05 0.476673554

# costruisco un dataframe
cover <- c("Suolo","Vegetazione","Mare","Nuvole")
percent21<- c(28.4,24,47.6,0)
percent18<- c(26.1,25.5,47.7,0.7)
percentages <- data.frame(cover,percent21,percent18)

# associo i grafici a un oggetto e li plotto uno accanto all'altro
c21<-ggplot(percentages, aes(x=cover, y=percent21, color=cover)) + geom_bar(stat="identity", fill="white")+ ggtitle("% copertura 2021")
c18<-ggplot(percentages, aes(x=cover, y=percent18, color=cover)) + geom_bar(stat="identity", fill="white")+ ggtitle("% copertura 2018")
grid.arrange(c21, c18, nrow = 1)


### Firme spettrali
#raster
# uso la funzione click per ottenere i valori di riflettanza dei pixel su cui clicco
plotRGB(dan2021, 3,2,1, stretch="lin")
click(dan2021, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

plotRGB(dan2018, 3,2,1, stretch="lin")
click(dan2018, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

# costruisco i vettori con le riflettanze
band<-c(1,2,3,4)
pixel1_2021<-c(994, 1374, 1896, 2474)
pixel2_2021<-c(245, 485, 284, 3802)
pixel3_2021<-c(969, 1360, 1994, 2820)
pixel4_2021<-c(531, 773, 1042, 2060)
pixel1_2018<-c(1454, 1540, 2024, 2803)
pixel2_2018<-c(849, 739, 450, 3525)
pixel3_2018<-c(973, 942, 615, 3198)
pixel4_2018<-c(888, 700, 512, 615)

# costruisco il dataframe
fs<-data.frame(band, pixel1_2021, pixel1_2018, pixel2_2021, pixel2_2018, pixel3_2021, pixel3_2018, pixel4_2021, pixel4_2018)
fs

# plotto le firme spettrali definendo una scala colore manuale
ggplot(fs, aes(x=band))+
geom_line(aes(y=pixel1_2021, colour="pixel1_2021")) +
geom_line(aes(y=pixel1_2018, colour="pixel1_2018"))+
geom_line(aes(y=pixel2_2021, colour="pixel2_2021")) +
geom_line(aes(y=pixel2_2018, colour="pixel2_2018")) +
geom_line(aes(y=pixel3_2021, colour="pixel3_2021")) +
geom_line(aes(y=pixel3_2018, colour="pixel3_2018"))+
geom_line(aes(y=pixel4_2021, colour="pixel4_2021")) +
geom_line(aes(y=pixel4_2018, colour="pixel4_2018"))+
scale_colour_manual("", breaks = c("pixel1_2021","pixel1_2018","pixel2_2021","pixel2_2018","pixel3_2021","pixel3_2018","pixel4_2021","pixel4_2018"),values = c("orange","yellow","dark green","green","red","magenta","black","grey")) +
labs(x="band",y="reflectance", title="Firme spettrali")



