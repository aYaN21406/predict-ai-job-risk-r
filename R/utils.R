# utils.R
library(tidyverse)
library(here)
library(janitor)
library(glue)

safe_read_csv <- function(path, ...) {
  readr::read_csv(path, show_col_types = FALSE, progress = FALSE, ...)
}

write_output <- function(df, name, folder = "output") {
  dir.create(folder, showWarnings = FALSE, recursive = TRUE)
  out <- file.path(folder, paste0(name, ".csv"))
  readr::write_csv(df, out)
  message("Wrote: ", out)
  invisible(out)
}
