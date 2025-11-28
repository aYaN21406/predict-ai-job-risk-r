# 03_features.R
library(tidyverse)
source("R/utils.R")

occ <- safe_read_csv("data/processed/occupations_processed.csv")

# Build feature set and risk score
# risk_score is a weighted composite:
# - ai capability (higher means more risk),
# - routine task share (higher -> more risk),
# - low growth increases risk.

occ_feat <- occ %>%
  mutate(
    growth_inverse = pmax(0, 100 - (growth_pct_2023_2033 + 50)),
    ai_scaled = scales::rescale(ai_capability_score, to = c(0, 1)),
    routine_scaled = scales::rescale(routine_task_share, to = c(0, 1))
  ) %>%
  mutate(
    risk_score = 0.5 * ai_scaled + 0.3 * routine_scaled + 0.2 * scales::rescale(growth_inverse, to = c(0, 1))
  ) %>%
  arrange(desc(risk_score))

write_output(occ_feat, "occupations_features", folder = "data/processed")
message("Feature set written to data/processed/occupations_features.csv")
