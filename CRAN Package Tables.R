# Get table about the latest CRAN Packages
rm(list = ls())
options(timeout = 300)
print(getwd())
# if (require("pacman")) {
# install.packages("pacman")
# }

pacman::p_load(readr, rvest, janitor, tableHTML, dplyr)
# webshot::install_phantomjs()

day <- Sys.Date()
dir <- ("data/")

# Check if directory exists, if not create it
if (!dir.exists(dir)) {
  dir.create(dir, recursive = TRUE)
}

content <- read_html(
  "https://cran.r-project.org/web/packages/available_packages_by_date.html"
)

table <- content %>% html_table(fill = TRUE)

table <- table[[1]] %>%
  clean_names()

table <-
  table %>%
  mutate(
    link = paste0(
      "https://cran.r-project.org/web/packages/", table$package, "/index.html"
    ),
    "package manual" = paste0(
      "https://cran.r-project.org/web/packages/", table$package, "/",
      table$package, ".pdf"
    )
  )

# table$Link <- str_replace_all(table$Link, " ", "")

write_csv(
  table, file = paste0(dir, day, " weekly cran package table.csv")
)
write_tableHTML(
  tableHTML(table), file = paste0(dir, day, " weekly cran package table.html")
)

# zip(
#   zipfile = "/home/vjvelascorios/Documentos/weekly cran packages/archive/archive.zip",
#   files = list.files(dir, full.names = T)
# )
