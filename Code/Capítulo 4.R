####### TAI #######       

# Aquí se proporciona el ejemplo del Capítulo 4

# Definir df

enunciados <- sprintf('Enunciado.%d', seq_len(n_items))

opciones <- matrix(c('Verdadero', 'Falso'), nrow = n_items, ncol = 2, byrow = T)

respuestas <- sample(c('Verdadero','Falso'), n_items, replace = T)

tipo <- c('radio')

df <- data.frame(Questions = enunciados,  
                 Option = opciones, 
                 Answer = respuestas, 
                 Type = tipo,
                 stringsAsFactors = F)

# Definir preCAT

preTAI <- list(max_items = 5,
               criteria = 'Drule',
               method = 'ML')

# Definir design

contenido <-  rep(c('ComprensiónLectora', 'ComprensiónOral',
                    'Ortografía', 'Cohesión'), each = 5)

contenido_prop <- c(ComprensiónLectora = 0.25,
                    ComprensiónOral = 0.25,
                    Ortografía = 0.30,
                    Cohesión = 0.20)

diseño <- list(min_SEM = 0.2,
               max_items = 15,
               content = contenido,
               content_prop = contenido_prop,
               max_time = 3600,
               exposure = sample(seq(0,1,.1), n_items, replace = T))

# Definir ShinyGUI

GUI <- list(title = 'TAI: Ejemplo 1',
            authors = 'Carlos Pérez',
            instructions = c('Para contestar a un ítem se debe seleccionar siempre una de las dos opciones,
                             no se permiten respuestas en blanco y finalizará en una hora.', 'Siguiente ítem'))

# Crear un modelo mirtCAT a partir de uno mirt explopratorio

mirtCAT.exp.3F <- generate.mirt_object(parametros.mirt.exp.3F, itemtype = '2PL')

# Definir mirtCAT

TAI <- mirtCAT(df = df, mirtCAT.exp.3F, method = 'ML', criteria = 'Drule',
               preCAT = preTAI, design = diseño, shinyGUI = GUI)

# Visualizar y obtener el nivel de habilidad

summary(TAI)

plot(TAI)
