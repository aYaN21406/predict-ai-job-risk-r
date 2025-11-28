# 01_data_fetch.R
# Purpose: place raw CSVs into data/raw/ OR generate fallback synthetic data

source("R/utils.R")

dir.create("data/raw", showWarnings = FALSE, recursive = TRUE)
dir.create("data/processed", showWarnings = FALSE, recursive = TRUE)

# If you don't have real datasets, the script below generates small synthetic sample data
generate_fallback <- function() {
  set.seed(42)
  occupations <- c(
    "Frontend Developer",
    "Backend Developer",
    "DevOps Engineer",
    "QA Engineer",
    "Mobile Developer",
    "Data Engineer",
    "ML Engineer"
  )
  n <- length(occupations)
  df <- tibble(
    job = occupations,
    soc_code = paste0("15-", sprintf("%03d", seq(1, n))),
    median_salary = round(runif(n, 70000, 145000), -2),
    employment_2023 = sample(20000:200000, n),
    growth_pct_2023_2033 = round(runif(n, -5, 20), 1),
    ai_capability_score = runif(n, 0, 1),
    routine_task_share = runif(n, 0, 1)
  )
  readr::write_csv(df, "data/raw/fallback_occupations.csv")
  message("Wrote fallback: data/raw/fallback_occupations.csv")
}

# Use fallback if no files present
raw_files <- list.files("data/raw")
if (length(raw_files) == 0) {
  generate_fallback()
} else {
  message("Found raw files in data/raw/: ", paste(raw_files, collapse = ", "))
}
