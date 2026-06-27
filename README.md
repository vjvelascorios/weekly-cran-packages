# Weekly CRAN Packages

![Weekly CRAN Packages](images/logo_wcp.png)

## Descripción

Snapshots semanales de los paquetes disponibles en CRAN, para mantener un historial estructurado de los paquetes nuevos, actualizados o eliminados.

## Script workflow

1. Descarga la tabla de paquetes disponibles en CRAN.
2. Guarda una instantánea en formato CSV dentro de la carpeta [data](data) con la fecha correspondiente en el nombre del archivo.
3. Compara snapshots consecutivos mediante [code/comparison.R](code/comparison.R) y genera reportes en formato Excel dentro de [reports](reports).
4. Se actualiza semanalmente con Actions [.github/workflows/automaticrun.yml](.github/workflows/automaticrun.yml).


## Estructura del repositorio

- [CRAN Package Tables.R](CRAN%20Package%20Tables.R): script principal que obtiene la tabla actual de paquetes de CRAN y guarda el CSV.
- [code/comparison.R](code/comparison.R): compara archivos CSV sucesivos y genera reportes de paquetes agregados y eliminados.
- [code/CRAN Package Tables WindowsVersion.R](code/CRAN%20Package%20Tables%20WindowsVersion.R): versión adaptada para entornos Windows.
- [data](data): snapshots semanales en CSV.
- [reports](reports): reportes de comparación generados en Excel.
- [.github/workflows/automaticrun.yml](.github/workflows/automaticrun.yml): flujo automatizado para ejecutar el análisis de forma periódica.

## Paquetes utilizados/Dependencias

- pacman
- dplyr
- readr
- rvest
- janitor
- tableHTML
- openxlsx
- purrr
- tictoc

## Contribuciones

Las contribuciones son bienvenidas. Puedes abrir un issue o enviar un pull request si tienes ideas para mejorar el flujo, los reportes o la documentación.