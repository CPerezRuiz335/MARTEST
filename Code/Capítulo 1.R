
DatosIniciales <- read.csv('DatosIniciales.csv', header = T)

####### VALORES EN BLANCO #######

## PATRONES

patrones(DatosIniciales)    

## INFLUX OUTFLUX

plotflux(DatosIniciales)

#######  IMPUTAR DATOS, AMELIA  #######

df <- amelia(DatosIniciales, noms = 1:20, m = 1)$imputations$imp1



