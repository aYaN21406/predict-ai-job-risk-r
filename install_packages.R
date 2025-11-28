# install_packages.R

packages <- c(
  "tidyverse",
  "readr",
  "readxl",
  "lubridate",
  "janitor",
  "here",
  "glue",
  "tidymodels",
  "rmarkdown",
  "knitr",
  "scales",
  "patchwork",
  "ranger"
)

installed <- rownames(installed.packages())
to_install <- packages[!packages %in% installed]

if (length(to_install)) install.packages(to_install)

# optional: initialize renv
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

message("Packages installed. Optionally run renv::init() to snapshot dependencies.")
