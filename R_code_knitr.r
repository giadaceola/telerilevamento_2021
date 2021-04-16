# R_code_knitr.r
# uso la funzione knitr per creare un report, quindi pdf unico in cui inserisco più immagini e/o il codice R

# imposto la working directory
setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# knitr prende un codice all'esterno di R, e all'interno di R genera un report (che viene salvato nella cartella del codice)
# richiamo la funzione knitr
library(knitr)
