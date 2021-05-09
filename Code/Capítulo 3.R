####### OBTENCIÓN DE PARÁMETROS #######   

n_items <- ncol(df)

mirtCluster(parallel::detectCores()-1)    

# MODELOs EXPLORATORIO

mirt.exp.3F <- mirt(df[,1:10], 10, itemtype = '2PL', method = 'MHRM')

mirt.exp.3F

mirt.exp.2F <- mirt(df, 20, itemtype = '2PL', method = 'MHRM')

mirt.exp.2F

# MODELOs CONFIRMATORIO


modelo.TwoTier.3F <- mirt.model('
                                F1 = 1-20
                                F2 = 1-20
                                F3 = 1-20
                                COV = F1*F2*F3
                                ')

mirt.TwoTier.3F <- bfactor(df,
                           c(rep(1:4, each = 5)),  
                           modelo.TwoTier.3F, 
                           itemtype='2PL')

mirt.bifactor.4F <- bfactor(df,
                            c(rep(1:4, each = 5)),  
                            itemtype='2PL')

mirtCluster(remove = TRUE)

####### BONDAD DE AJUSTE #######       

# ANOVA

anova.exp.1 <- anova(mirt.exp.2F, mirt.exp.3F) 

anova.exp.1

anova.conf.1 <- anova(mirt.bifactor.4F, mirt.TwoTier.3F)

anova.conf.1   

# itemfit

itemfit.mirt.exp.3F <- itemfit(mirt.exp.3F, QMC = T)

itemfit.mirt.exp.3F[which(itemfit.mirt.exp.3F$p.S_X2 < 0.05),]

itemfit.mirt.exp.3F

# M2

M2.mirt.exp.3F <- M2(mirt.exp.3F, QMC = T)

M2.mirt.exp.3F

# residuals

residuals.mirt.exp.3F <- residuals(mirt.exp.3F, df.p = T, QMC = T)

cbind(which(residuals.mirt.exp.3F$df.p < 0.05, arr.ind = T),
      p = residuals.mirt.exp.3F$LD[which(residuals.mirt.exp.3F$df.p < 0.05)])

# clusters

parametros.mirt.exp.3F <- CoefToDataframe(modelo = mirt.exp.3F, n_items = n_items)

coordenadas.mirt.exp.3F <- polar_coords(parametros.mirt.exp.3F[,1:3],
                                        parametros.mirt.exp.3F$d)

Ward.mirt.exp.3F <- ward_mat(coordenadas.mirt.exp.3F[c('ang1', 'ang2', 'ang3')])

clusters.mirt.exp.3F <-  hclust(as.dist(Ward.mirt.exp.3F), method = 'ward.D2')

plot(clusters.mirt.exp.3F)

rect.hclust(clusters.mirt.exp.3F, k = 3, border = 1:3)