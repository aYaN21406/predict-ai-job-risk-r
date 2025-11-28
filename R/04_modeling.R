# 04_modeling.R
library(tidymodels)
library(tidyverse)
source("R/utils.R")

occ <- safe_read_csv("data/processed/occupations_features.csv")

# Small modeling example: predict risk_score from salary, employment, growth, etc.
set.seed(123)
split <- initial_split(occ, prop = 0.8)
train <- training(split)
test <- testing(split)

rec <- recipe(risk_score ~ median_salary + employment_2023 + growth_pct_2023_2033 + ai_capability_score + routine_task_share, data = train) %>%
  step_normalize(all_numeric_predictors())

rf_spec <- rand_forest(mode = "regression", trees = 500) %>%
  set_engine("ranger")

wf <- workflow(rec, rf_spec)
rf_fit <- fit(wf, data = train)

dir.create("output/models", showWarnings = FALSE, recursive = TRUE)
saveRDS(rf_fit, "output/models/rf_risk_model.rds")
message("Saved model: output/models/rf_risk_model.rds")

# Evaluate
pred <- predict(rf_fit, test) %>% bind_cols(test %>% select(risk_score))
metrics <- yardstick::metrics(pred, truth = risk_score, estimate = .pred)
write_output(metrics, "model_metrics", folder = "output")
message("Model metrics written to output/model_metrics.csv")
