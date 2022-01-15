# R_code_exam.r

library(raster)
library(ggplot2)
library(gridExtra)
library(RStoolbox)
library(viridis)

setwd("C:/lab/danubio")

primalist <- list.files(pattern="T35TPK_20180717T085601")
primalist
dopolist <- list.files(pattern="T35TPK_20210731T085601")
dopolist
primaimport <- lapply(primalist,raster)
primaimport
dopoimport <- lapply(dopolist,raster)
dopoimport
dan2018<-stack(primaimport)
dan2021<-stack(dopoimport)

# b1= blue
# b2= green
# b3= red
# b4= nir

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
clg <- colorRampPalette(c("dark green","green","light green")) (100)
clr <- colorRampPalette(c("dark red","red","pink")) (100)
clnir <- colorRampPalette(c("red","orange","yellow")) (100)

par(mfrow=c(2,2))
plot(dan2021$T35TPK_20210731T085601_B02, col=clb, main="Banda blu")
plot(dan2021$T35TPK_20210731T085601_B03, col=clg, main="Banda verde")
plot(dan2021$T35TPK_20210731T085601_B04, col=clr, main="Banda rosso")
plot(dan2021$T35TPK_20210731T085601_B08, col=clnir, main="Banda nir")

par(mfrow=c(2,2))
plot(dan2018$T35TPK_20180717T085601_B02, col=clb, main="Banda blu")
plot(dan2018$T35TPK_20180717T085601_B03, col=clg, main="Banda verde")
plot(dan2018$T35TPK_20180717T085601_B04, col=clr, main="Banda rosso")
plot(dan2018$T35TPK_20180717T085601_B08, col=clnir, main="Banda nir")

#library(ggplot2)
#library(gridExtra)
#library(RStoolbox)
p321<-ggRGB(dan2021, 3,2,1, stretch="lin")
p421<-ggRGB(dan2021, 4,2,1, stretch="lin")
p318<-ggRGB(dan2018, 3,2,1, stretch="lin")
p418<-ggRGB(dan2018, 4,2,1, stretch="lin")
grid.arrange(p321, p421, p318, p418, nrow = 2)

#par(mfrow=c(2,2))
#plotRGB(dan2018, 3,2,1, stretch="lin", axes=TRUE, main= "2018 RGB:3,2,1")
#plotRGB(dan2021, 3,2,1, stretch="lin", axes=TRUE, main= "2021 RGB:3,2,1")
#plotRGB(dan2018, 4,2,1, stretch="lin", axes=TRUE, main= "2018 RGB:4,2,1")
#plotRGB(dan2021, 4,2,1, stretch="lin", axes=TRUE, main= "2021 RGB:4,2,1")

dan2021r <- aggregate(dan2021, fact=50)
plot(dan2021r)

par(mfrow=c(2,1))
plotRGB(dan2021, 4,2,1, stretch="lin")
plotRGB(dan2021r, 4,2,1, stretch="lin")

pairs(dan2021r, main="Correlazioni tra variabili")

### Analisi delle componenti principali
#RStoolbox
dan2021r_pca<-rasterPCA(dan2021r)
dan2021r_pca
summary(dan2021r_pca$model)
Importance of components:
#                             Comp.1       Comp.2       Comp.3       Comp.4
#Standard deviation     1484.2245787 428.03193377 91.044972644 3.900148e+01
#Proportion of Variance    0.9194382   0.07646728  0.003459674 6.348711e-04
#Cumulative Proportion     0.9194382   0.99590545  0.999365129 1.000000e+00
plot(dan2021r_pca$map)

plotRGB(dan2021r_pca$map, r=1, g=2, b=3, stretch="lin", axes=TRUE, main="Mappa r=PC1, g=PC2, b=PC3")

### Variabilità locale
# NDVI 2021
nir21<-dan2021r$T35TPK_20210731T085601_B08
red21<-dan2021r$T35TPK_20210731T085601_B04
ndvi21 <- (nir21-red21) / (nir21+red21)
plot(ndvi21, main="NDVI 2021")

# moving window 3x3 della deviazione standard di ndvi21
#raster
ndvi21sd3 <- focal(ndvi21, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
#clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
#plot(ndvi21sd3, col=clsd, main="Deviazione standard di NDVI21")

# moving window 3x3 della deviazione standard nella PC1
#pc121 <- dan21r_pca$map$PC1
#pc121sd3 <- focal(pc121, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
#plot(pc121sd3, col=clsd, main="Deviazione standard su PC1")
#dev.off()

#library(ggplot2)
#library(viridis)
ggplot() + geom_raster(ndvi21sd3, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis() + ggtitle("Deviazione standard di NDVI21")
dev.off()

### Differenza NDVI
# calcolo prima anche NDVI 2018 su immagine ricampionata
dan2018r <- aggregate(dan2018, fact=50)

# NDVI 2018
nir18<-dan2018r$T35TPK_20180717T085601_B08
red18<-dan2018r$T35TPK_20180717T085601_B04
ndvi18 <- (nir18-red18) / (nir18+red18)
plot(ndvi18, main="NDVI 2018")
dev.off()

par(mfrow=c(1,2))
plot(ndvi18, main="NDVI 2018")
plot(ndvi21, main="NDVI 2021")
dev.off()

# differenza tra ndvi 2021 e ndvi 2018
difndvi <- ndvi21 - ndvi18
cld <- colorRampPalette(c('red','white','green'))(100)
plot(difndvi, col=cld, main="Differenza tra NDVI del 2021 e NDVI del 2018")
dev.off()

### Spectral indices

# b1= blue
# b2= green
# b3= red
# b4= nir

clsi <- colorRampPalette(c('black','darkblue','red','yellow'))(100)

#RStoolbox
spind <- spectralIndices(dan2021r, blue=1, green=2, red=3, nir=4)
plot(spind, col=clsi)
dev.off()

### Classificazione non supervisionata
#RStoolbox
dan2021rc3 <- unsuperClass(dan2021r, nClasses=3)
plot(dan2021rc3$map, main="Classificazione non supervisionata con 3 classi")
dev.off()
dan2021rc5 <- unsuperClass(dan2021r, nClasses=5)
plot(dan2021rc5$map, main="Classificazione non supervisionata con 5 classi")
dev.off()
dan2021rc10 <- unsuperClass(dan2021r, nClasses=10)
plot(dan2021rc10$map, main="Classificazione non supervisionata con 10 classi")
dev.off()

par(mfrow=c(1,2))
plot(dan2021rc10$map)
plotRGB(dan2021, 3,2,1, stretch="lin")
dev.off()

### Calcolo della frequenza dei pixel di una certa classe
freq(dan2021rc5$map)
#     value count
#[1,]     1 10228
#[2,]     2 19184
#[3,]     3  3635
#[4,]     4 10727
#[5,]     5  4626
sum21<-10228+19184+3635+10727+4626
sum21
prop21 <- freq(dan2021rc5$map)/sum21
prop21
#            value      count
#[1,] 2.066116e-05 0.21132231
#[2,] 4.132231e-05 0.39636364
#[3,] 6.198347e-05 0.07510331
#[4,] 8.264463e-05 0.22163223
#[5,] 1.033058e-04 0.09557851

# faccio un dataframe
cover <- c("Agricoltura","Vegetazione","Sedimenti","Laguna","Mare")
percent21<- c(22.16,21.13,9.55,7.51,39.63)
percentages <- data.frame(cover,percent21)

ggplot(percentages, aes(x=cover, y=percent21, color=cover)) + geom_bar(stat="identity", fill="white")+ ggtitle("% copertura 2021")
dev.off()

### Firme spettrali
#raster
plotRGB(dan2021, 3,2,1, stretch="lin")
click(dan2021, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

plotRGB(dan2018, 3,2,1, stretch="lin")
click(dan2018, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

band<-c(1,2,3,4)
pixel1_2021<-c(230, 427, 269, 3698)
pixel2_2021<-c(927, 1312, 2072, 2802)
pixel1_2018<-c(897, 772, 447, 3869)
pixel2_2018<-c(1014, 1113, 682, 3956)
water_2021<-c(365, 323, 258, 193)
water_2018<-c(884, 607, 376, 221)

fs<-data.frame(band, pixel1_2021, pixel1_2018, pixel2_2021, pixel2_2018, water_2021, water_2018)
fs

ggplot(fs, aes(x=band))+
geom_line(aes(y=pixel1_2021, colour="pixel1_2021")) +
geom_line(aes(y=pixel1_2018, colour="pixel1_2018"))+
geom_line(aes(y=pixel2_2021, colour="pixel2_2021")) +
geom_line(aes(y=pixel2_2018, colour="pixel2_2018")) +
geom_line(aes(y=water_2021, colour="water_2021"))+
geom_line(aes(y=water_2018, colour="water_2018"))+
scale_colour_manual("", breaks = c("pixel1_2021","pixel1_2018","pixel2_2021","pixel2_2018","water_2021","water_2018"),values = c("dark green","green","red","magenta","dark blue","blue")) +
labs(x="band",y="reflectance", title="Firme spettrali")






