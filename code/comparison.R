#==============================================================================
# Script para comparar los paquetes de CRAN de esta semana con la semana anterior
#==============================================================================
# Autor: vjvelascorios
# Fecha: 2024-05-04
#==============================================================================

# Limpiar entorno
rm(list = ls())

# Cargar los paquetes necesarios
pacman::p_load(dplyr, readr, tictoc)

# Construir las rutas a los archivos de esta semana y la semana anterior
setwd_auto <- function() {
  if (Sys.info()['sysname'] == 'Windows') {
    setwd("C:/Users/vjvelascorios/Documents/weekly-cran-packages")
  } else {
    setwd("/home/vjvelascorios/Documentos/weekly cran packages/data")
  }
}
setwd_auto()

dir = getwd()

# Lista completa de archivos en el directorio de datos
files = list.files(paste0(dir,"/data"))

# filtrar solo archivos csv en files y ordenarlos
files = files[grep(".csv", files)] %>% sort()

# generar algoritmo para generar cargar archivos y compararlos y generar reporte de comparación entre elementos nuevos, eliminados y actualizados de los paquetes de CRAN


#==============================================================================
#==============================================================================
# previous_file <- read_csv(paste0(dir,"/data/",files[76]))
# actual_file <- read_csv(paste0(dir,"/data/",files[77]))
# 
# 
# # Identificar los paquetes eliminados
# paquetes_eliminados <- setdiff(previous_file$package, actual_file$package)
# 
# # Identificar los paquetes agregados
# paquetes_agregados <- setdiff(actual_file$package, previous_file$package)
# 
# # # Identificar los paquetes actualizados
# # paquetes_actualizados <- intersect(previous_file$package, actual_file$package)
# 
# 
# # Filtrar los datos de los paquetes eliminados, agregados y actualizados en ambos data frames y guardarlos en un excel.
# 
# df_paquetes_eliminados <- previous_file %>%
#   filter(package %in% paquetes_eliminados)
# 
# df_paquetes_agregados <- actual_file %>%
#   filter(package %in% paquetes_agregados)
# 
# 
# df_repor <- list("eliminados"=df_paquetes_eliminados, "agregados"=df_paquetes_agregados)
# 
# # obtener como texto de la fecha del último dataframe para guardarlo en el nombre del reporte:
# elemento <- pull(actual_file[1, 1])
# name_report <- list(as.character(elemento))
# getwd()
# 
# write.xlsx(df_repor,file = paste0("reports/",name_report,".xlsx"), overwrite = T)
#==============================================================================
#==============================================================================


tic()
for (i in 1:length(files)) {
  previous_file <- read_csv(paste0(dir,"/data/",files[i]))
  actual_file <- read_csv(paste0(dir,"/data/",files[i+1]))
  
  
  # Identificar los paquetes eliminados
  paquetes_eliminados <- setdiff(previous_file$package, actual_file$package)
  
  # Identificar los paquetes agregados
  paquetes_agregados <- setdiff(actual_file$package, previous_file$package)
  
  # # Identificar los paquetes actualizados
  # paquetes_actualizados <- intersect(previous_file$package, actual_file$package)
  
  
  # Filtrar los datos de los paquetes eliminados, agregados y actualizados en ambos data frames y guardarlos en un excel.
  
  df_paquetes_eliminados <- previous_file %>%
    filter(package %in% paquetes_eliminados)
  
  df_paquetes_agregados <- actual_file %>%
    filter(package %in% paquetes_agregados)
  
  
  df_repor <- list("eliminados"=df_paquetes_eliminados, "agregados"=df_paquetes_agregados)
  
  # obtener como texto de la fecha del último dataframe para guardarlo en el nombre del reporte:
  elemento <- pull(actual_file[1, 1])
  name_report <- list(as.character(elemento))
  getwd()
  
  write.xlsx(df_repor,file = paste0("reports/",name_report,".xlsx"), overwrite = T)
  
}
toc()
