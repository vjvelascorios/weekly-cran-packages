# Get table about the latest CRAN Packages
rm(list=ls())
pacman::p_load(tidyverse,rvest,janitor,tableHTML)
# webshot::install_phantomjs()

day <- Sys.Date()
dir <- ("/home/vjvelascorios/Documentos/weekly cran packages/data/")

content <- read_html("https://cran.r-project.org/web/packages/available_packages_by_date.html")

table <- content %>% html_table(fill = TRUE)
table <- table[[1]] %>% 
  clean_names()

write_csv(table, file = paste0(dir,day," weekly cran package table.csv"))
write_tableHTML(tableHTML(table), file = paste0(dir,day," weekly cran package table.html"))


# zip(zipfile = "/home/vjvelascorios/Documentos/weekly cran packages/archive/archive.zip",files = list.files(dir,full.names = T))
