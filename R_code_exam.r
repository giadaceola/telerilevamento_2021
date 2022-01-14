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

p321<-ggRGB(dan2021, 3,2,1, stretch="lin")
p421<-ggRGB(dan2021, 4,2,1, stretch="lin")
grid.arrange(p321, p421, nrow = 1)

par(mfrow=c(2,2))
plot(dan2018$T35TPK_20180717T085601_B02, col=clb, main="Banda blu")
plot(dan2018$T35TPK_20180717T085601_B03, col=clg, main="Banda verde")
plot(dan2018$T35TPK_20180717T085601_B04, col=clr, main="Banda rosso")
plot(dan2018$T35TPK_20180717T085601_B08, col=clnir, main="Banda nir")

p318<-ggRGB(dan2018, 3,2,1, stretch="lin")
p418<-ggRGB(dan2018, 4,2,1, stretch="lin")
grid.arrange(p318, p418, nrow = 1)

par(mfrow=c(2,2))
plotRGB(dan2018, 3,2,1, stretch="lin")
plotRGB(dan2021, 3,2,1, stretch="lin")
plotRGB(dan2018, 4,2,1, stretch="lin")
plotRGB(dan2021, 4,2,1, stretch="lin")

dan2021r <- aggregate(dan2021, fact=50)
plot(dan2021r)

par(mfrow=c(2,1))
plotRGB(dan2021, 4,2,1, stretch="lin")
plotRGB(dan2021r, 4,2,1, stretch="lin")

pairs(dan2021r)
dan2021r_pca<-rasterPCA(dan2021r)
dan2021r_pca
summary(dan2021r_pca$model)
plot(dan2021r_pca$map)
plotRGB(dan2021r_pca$map, r=1, g=2, b=3, stretch="lin")

# variabilità locale
nir21<-dan2021r$T35TPK_20210731T085601_B08
red21<-dan2021r$T35TPK_20210731T085601_B04
ndvi21 <- (nir21-red21) / (nir21+red21)
plot(ndvi21, main="NDVI 2021")

ndvi21sd3 <- focal(ndvi21, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvi21sd3, col=clsd)

pc121 <- dan21r_pca$map$PC1
pc121sd3 <- focal(pc121, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(pc121sd3, col=clsd)
dev.off()

ggplot() + geom_raster(pc121sd3, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis()
dev.off()

# differenza NDVI
# calcolo prima anche NDVI 2018
dan2018r <- aggregate(dan2018, fact=50)

nir18<-dan2018r$T35TPK_20180717T085601_B08
red18<-dan2018r$T35TPK_20180717T085601_B04
ndvi18 <- (nir18-red18) / (nir18+red18)
plot(ndvi18, main="NDVI 2018")
dev.off()

par(mfrow=c(1,2))
plot(ndvi18, main="NDVI 2018")
plot(ndvi21, main="NDVI 2021")
dev.off()

difndvi <- ndvi21 - ndvi18
cld <- colorRampPalette(c('red','white','green'))(100)
plot(difndvi, col=cld, main="Differenza tra NDVI del 2021 e NDVI del 2018")
dev.off()

# spectral indices
# b1= blue
# b2= green
# b3= red
# b4= nir

clsi <- colorRampPalette(c('black','darkblue','red','yellow'))(100)
spind <- spectralIndices(dan2021r, blue=1, green=2, red=3, nir=4)
plot(spind, col=clsi)
dev.off()

# classificazione non supervisionata
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

#calcolo la frequenza dei pixel di una classe
freq(dan2021rc3$map)
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

# firme spettrali
plotRGB(dan2021, 3,2,1, stretch="lin")
click(dan2021, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

plotRGB(dan2018, 3,2,1, stretch="lin")
click(dan2018, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

band<-c(1,2,3,4)
pixel12021<-c(230, 427, 269, 3698)
pixel22021<-c(927, 1312, 2072, 2802)
pixel32021<-c(336, 621, 420, 2824)
pixel42021<-c(483,1116,687,442)
pixel12018<-c(897, 772, 447, 3869)
pixel22018<-c(1014, 1113, 682, 3956)
pixel32018<-c(882, 886, 475, 3024)
pixel42018<-c(1052,1161,712,350)
water2021<-c(365, 323, 258, 193)
water2018<-c(884, 607, 376, 221)

fs<-data.frame(band, pixel12021, pixel12018, pixel22021, pixel22018, pixel32021, pixel32018, pixel42021, pixel42018, water2021, water2018)
fs

ggplot(fs, aes(x=band))+
geom_line(aes(y=pixel12021), color="green") +
geom_line(aes(y=pixel12018), color="green") +
geom_line(aes(y=pixel22021), color="red") +
geom_line(aes(y=pixel22018), color="red") +
geom_line(aes(y=pixel32021), color="brown") +
geom_line(aes(y=pixel32018), color="brown") +
geom_line(aes(y=pixel42021), color="black") +
geom_line(aes(y=pixel42018), color="black") +
geom_line(aes(y=water2021), color="blue")+
labs(x="band",y="reflectance")





