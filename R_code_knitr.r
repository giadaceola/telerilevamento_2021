# R_code_knitr.r
# uso la funzione knitr per creare un report, quindi pdf unico in cui inserisco più immagini e/o il codice R

# imposto la working directory
setwd("C:/lab/") # Windows
# setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac

# knitr prende un codice all'esterno di R, e all'interno di R genera un report (che viene salvato nella cartella del codice)
# richiamo la funzione knitr
library(knitr)

# la funzione stitch prende il codice di riferimento e, utilizzando il pacchetto knitr, genera il pdf come output
stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))


