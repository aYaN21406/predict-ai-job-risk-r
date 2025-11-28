# 02_data_clean.R
library(tidyverse)
source("R/utils.R")

# read either real file or fallback
if (file.exists("data/raw/fallback_occupations.csv")) {
  occ <- safe_read_csv("data/raw/fallback_occupations.csv")
} else if (file.exists("data/raw/bls_oes.csv")) {
  occ <- safe_read_csv("data/raw/bls_oes.csv") %>% clean_names()
} else {
  stop("No raw data found. Please place files in data/raw/ or run 01_data_fetch.R")
}

# basic cleaning
occ_clean <- occ %>%
  rename_with(~ str_remove_all(., "\\s+")) %>%
  mutate(
    job = as.character(job),
    ai_capability_score = as.numeric(ai_capability_score),
    routine_task_share = as.numeric(routine_task_share)
  ) %>%
  mutate_if(is.numeric, ~ ifelse(is.na(.), median(., na.rm = TRUE), .))

write_output(occ_clean, "occupations_processed", folder = "data/processed")
message("Processed occupations saved to data/processed/occupations_processed.csv")
