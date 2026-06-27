#==============================================================================
# Script Optimizado y Estable para comparar paquetes de CRAN
#==============================================================================
# Autor: vjvelascorios
# Modificado: 2026
#==============================================================================

rm(list = ls())
sink("~/comparison.log", split = TRUE) 

# Cargamos purrr, dplyr, readr, tictoc y openxlsx (eliminamos future para evitar bloqueos)
pacman::p_load(dplyr, readr, tictoc, openxlsx, purrr)

# Configurar directorio base según el Sistema Operativo
setwd_auto <- function() {
  if (Sys.info()['sysname'] == 'Windows') {
    setwd("C:/Users/vjvelascorios/Documents/weekly-cran-packages")
  } else {
    setwd("/home/vjvelascorios/Documents/GitHub/weekly-cran-packages")
  }
}
setwd_auto()

base_dir <- getwd()
data_dir <- file.path(base_dir, "data")
reports_dir <- file.path(base_dir, "reports")

if (!dir.exists(reports_dir)) dir.create(reports_dir)

# Lista completa de archivos CSV ordenados con ruta completa
files <- list.files(data_dir, pattern = "\\.csv$", full.names = TRUE) %>% sort()

if (length(files) < 2) {
  stop("No hay suficientes archivos en la carpeta 'data' para realizar una comparación.")
}

tic()

# PASO 1: Leer todos los archivos en memoria una sola vez (Secuencial pero ultrarrápido con readr)
cat("Cargando archivos CSV en memoria...\n")
all_dfs <- lapply(files, read_csv, show_col_types = FALSE)

# PASO 2: Comparación secuencial e impresión con barra de progreso
cat("Procesando comparaciones y generando reportes Excel...\n")

total_comparaciones <- length(all_dfs) - 1

for (i in 1:total_comparaciones) {
  
  previous_file <- all_dfs[[i]]
  actual_file   <- all_dfs[[i+1]]
  
  # Identificar los paquetes eliminados y agregados
  paquetes_eliminados <- setdiff(previous_file$package, actual_file$package)
  paquetes_agregados  <- setdiff(actual_file$package, previous_file$package)
  
  # Filtrar los datos correspondientes
  df_paquetes_eliminados <- previous_file %>% filter(package %in% paquetes_eliminados)
  df_paquetes_agregados  <- actual_file %>% filter(package %in% paquetes_agregados)
  
  # Estructurar el reporte en pestañas
  df_report <- list(
    "eliminados" = df_paquetes_eliminados, 
    "agregados"  = df_paquetes_agregados
  )
  
  # Obtener la fecha/identificador del dataframe actual para el nombre del archivo
  name_report <- as.character(actual_file[[1, 1]])
  name_report <- gsub("/", "-", name_report) 
  
  output_file <- file.path(reports_dir, paste0(name_report, ".xlsx"))
  
  # Guardar Excel secuencialmente (Evita saturar la memoria RAM)
  write.xlsx(df_report, file = output_file, overwrite = TRUE)
  
  # Barra de progreso informativa en consola
  cat(sprintf("\rProgreso: [%d/%d] Generado: %s.xlsx", i, total_comparaciones, name_report))
  flush.console() # Fuerza a R a pintar el texto inmediatamente
}

cat("\n\n¡Proceso completado con éxito!\n")
toc()
sink()
