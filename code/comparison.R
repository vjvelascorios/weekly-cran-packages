# Cargar los paquetes necesarios
library(dplyr)

# Obtener la fecha actual
fecha_actual <- Sys.Date()

# Obtener la fecha de la semana anterior
fecha_semana_anterior <- fecha_actual - 7

# Construir las rutas a los archivos de esta semana y la semana anterior
ruta_archivo_actual <- paste0("/home/vjvelascorios/Documentos/weekly cran packages/data/", fecha_actual, " weekly cran package table.csv")
ruta_archivo_semana_anterior <- paste0("/home/vjvelascorios/Documentos/weekly cran packages/data/", fecha_semana_anterior, " weekly cran package table.csv")

# Verificar si los archivos existen antes de cargarlos en data frames
if (file.exists(ruta_archivo_actual) && file.exists(ruta_archivo_semana_anterior)) {
  df_actual <- read.csv(ruta_archivo_actual)
  df_anterior <- read.csv(ruta_archivo_semana_anterior)
  
  # Identificar los paquetes eliminados
  paquetes_eliminados <- setdiff(df_anterior$package, df_actual$package)
  
  # Identificar los paquetes agregados
  paquetes_agregados <- setdiff(df_actual$package, df_anterior$package)
  
  # Identificar los paquetes actualizados
  paquetes_actualizados <- intersect(df_anterior$package, df_actual$package)
  
  # Filtrar los datos de los paquetes actualizados en ambos data frames
  df_paquetes_actualizados_anterior <- df_anterior %>%
    filter(package %in% paquetes_actualizados)
  
  df_paquetes_actualizados_actual <- df_actual %>%
    filter(package %in% paquetes_actualizados)
  
  # Combinar los data frames para comparar los detalles de los paquetes actualizados
  df_comparacion <- full_join(df_paquetes_actualizados_anterior, df_paquetes_actualizados_actual, by = "package", suffix = c("_anterior", "_actual"))
  
  # Filtrar los registros donde hay cambios en los detalles de los paquetes actualizados
  df_actualizaciones_diferentes <- df_comparacion %>%
    filter(title_anterior != title_actual | link_anterior != link_actual | `package manual_anterior` != `package manual_actual`)
  
  # Ahora puedes guardar los resultados en un nuevo archivo CSV para su análisis o uso posterior
  ruta_resultado <- "/home/vjvelascorios/Documentos/weekly cran packages/reports/resultados.csv"
  
  write.csv(df_actualizaciones_diferentes, file = ruta_resultado, row.names = FALSE)
  
  # Imprimir los resultados para verlos en la consola
  print(paquetes_eliminados)
  print(paquetes_agregados)
  print(df_actualizaciones_diferentes)
} else {
  print("No se encontraron los archivos de esta semana y la semana anterior.")
}

