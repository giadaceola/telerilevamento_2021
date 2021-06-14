# R_code_no2.r
library(raster)
library(RStoolbox) # per l'analisi multivariata di raster

# 1. Set the working directory EN
setwd("C:/lab/EN")

# 2. Importare il primo set di dati, la prima banda (EN_0001.png)
EN01 <- raster("EN_0001.png")
EN01

# 3. Plottare la prima immagine con una palette a scelta
cls<-colorRampPalette(c("red","pink","orange","yellow")) (200)
plot(EN01, col=cls)

# 4. Importare l'ultima immagine (13th) e plottarla con la precedente palette
EN13 <- raster("EN_0013.png")
plot(EN13, col=cls)

# 5. Vedere la differenza tra le due immagini, associarla ad un oggetto e plottarla
ENdif <- EN01 - EN13
plot(ENdif, col=cls)

# 6. Plottare tutto insieme
par(mfrow=c(3,1))
plot(EN01, col=cls, main="NO2 in January")
plot(EN13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Difference (January - March)")

# 7. Importare tutte le 13 immagini insieme e le plotto
rlist <- list.files(pattern="EN")
import <- lapply(rlist,raster)
EN <- stack(import)
plot(EN, col=cls)

# 8. Plottare l'immagine 1 e 13 utilizzando lo stack di base
EN
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)

# 9. Fare una PCA sulle 13 immagini (quindi sulla base dello stack), e plottare in RGB le prime tre componenti
ENpca <- rasterPCA(EN)
summary(ENpca$model)
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

# 10. Calcolare la variabilità (local standard deviation) della prima PC
PC1sd <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cls)













