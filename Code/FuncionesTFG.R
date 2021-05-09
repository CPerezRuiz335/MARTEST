########

if (!require(c("VIM"))) install.packages("VIM")
if (!require(c("ggrepel"))) install.packages("ggrepel")
if (!require(c("Amelia"))) install.packages("Amelia")
if (!require(c("mice"))) install.packages("mice")
if (!require(c("mirt"))) install.packages("mirt")
if (!require(c("mirtCAT"))) install.packages("mirtCAT")
if (!require(c("ggplot2"))) install.packages("ggplot2")

#### CAPITULO 1 ####

library(mice)
library(ggplot2)
library(ggrepel)
library(Amelia)
library(VIM)
library(mirt)
library(mirtCAT)

  ## PATRONES ##

patrones <- function(data){
matrixplot(
  (matrix(colMeans(is.na(data))*1.8, 
          nrow(data), ncol(data),
          byrow = T) + ifelse(is.na(data), NA, 0)),
  cex.lab = 1.5,
  cex.axis=1.5,
  ylab = 'Respondientes',
  xlab = 'Items'
  )
}


   ## PLOTFLUX ##

plotflux <- function(data) {
  pat <- md.pairs(data)
  outflux <- rowSums(pat$rm) / (rowSums(pat$rm + pat$mm))
  influx <- rowSums(pat$mr) / (rowSums(pat$mr + pat$rr))
  datframe <- data.frame(influx = influx, outflux = outflux, items = colnames(data),
                   Imputable = colMeans(data, na.rm = T) %in% 0:1)
    ggplot(datframe,aes(influx, outflux, label = items, col = Imputable)) +    
    geom_segment(aes(x = 0, y = 1, xend = 1, yend = 0))+
    coord_cartesian(xlim = c(0:1),
                    ylim = c(0:1)) +
    theme_minimal()+
      geom_point() +
      scale_color_manual(values = c('black','red'))+
    geom_text_repel(
      max.overlaps = ncol(data),
      data = subset(datframe, influx < .5 & outflux < .5 | Imputable),
      segment.linetype = 3.5,
      family = 'mono',
      fontface = 'bold',
      size = 6) +
      theme(legend.position = 'none',
            axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
}


 ## matriz de ángulos para hacer clusters con el método Ward ##

# funcion que calcula el angulo entre dos vectores


ward_mat <- function(df){
  
  # funcion que calcula angulo entre dos vectores
  
  angulo_vectores <- function(angulo1, angulo2) {
    
    coord1 <- cos(angulo1 * pi / 180)
    coord2 <- cos(angulo2 * pi / 180)
    
    acos(sum(coord1 * coord2) / (sqrt(sum(coord1^2)) * sqrt(sum(coord2^2)))) * 180 / pi
    
  }
  
  # subset items completos
  
  angulos <- df[complete.cases(df),]
  
  # calcular angulo entre cada par de items 
  
  mat <- sapply(1:nrow(angulos), function(x){
    
    sapply(1:nrow(angulos), function(y){
      
      angulo_vectores(angulos[x,],angulos[y,])
      
    })
    
  })
  
  mat[is.na(mat)] <- 0
  
  return(mat)
  
}


# sistema de coordenadas polares

#MDIFF

MDIFF <- function(a, d){
  
  -d / sqrt(sum(a^2))
  
}

# MDISC

MDISC <- function(a){
  sqrt(sum(a^2))
}

# inerseccion2d

interseccion2d <- function(a1, a2, d){
  a <-  list(c(a1, a2))
  angulo <- acos(a1/sqrt(a1^2 + a2^2)) 
  x0 <- cos(angulo) * mapply(MDIFF, a, d)
  y0 <- sin(angulo) * mapply(MDIFF, a, d)
  
  return(c(x0, y0, angulo / pi*180))
  
}

# polar_coords

polar_coords <- function(a, d){
  
  MMDD <- sapply(1:nrow(a), function(x){
    
    c(MDIFF(a[x,],d[x]), MDISC(a[x,]))
    
  })
  
  if (ncol(a) == 2){
    
    coords <- mapply(interseccion2d, a[,1],a[,2], d)
    
    x1 <- MMDD[2,] * .25 * cos(coords[3,] * pi / 180) + coords[1,]
    y1 <- MMDD[2,] * .25 * sin(coords[3,] * pi / 180) + coords[2,]
    
    data.frame(a, d, MDIFF = MMDD[1,], MDISC = MMDD[2,], ang1 = coords[3,],
               ang2 = 90 - coords[3,], x0 = coords[1,], y0 = coords[2,], x1, y1)
    
    
  } else {
    
    angulos <- t(apply(a, 1, function(x){
      
      sapply(1:ncol(a), function(y) {
        
        acos(x[y]/sqrt(sum(x^2))) / pi*180
        
      })
    }) 
    )
    colnames(angulos) <- sprintf("ang%d", 1:ncol(angulos))
    
    data.frame(a, d, MDIFF = MMDD[1,], MDISC = MMDD[2,], angulos)
    
  }
}


# coef a data.frame

CoefToDataframe <- function(n_items, modelo, rotate = 'none'){
  
  parametros.lst <- coef(modelo, rotate = rotate)
  
  parametros.df <- rbind(parametros.lst[[1]])
  
  for(i in 2:n_items){
    
    parametros.df <- rbind(parametros.df, parametros.lst[[i]])
    
  }
  
  as.data.frame(parametros.df)
  
}

