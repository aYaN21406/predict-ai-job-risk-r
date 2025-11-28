# 05_viz.R
library(tidyverse)
library(patchwork)
source("R/utils.R")

occ <- safe_read_csv("data/processed/occupations_features.csv")

p1 <- occ %>%
  ggplot(aes(x = reorder(job, risk_score), y = risk_score)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Estimated AI Automation Risk by Role",
    x = "",
    y = "Risk score (0-1)"
  ) +
  theme_minimal()

p2 <- occ %>%
  ggplot(aes(ai_capability_score, routine_task_share, label = job)) +
  geom_point(size = 3, color = "darkred") +
  geom_text(nudge_y = 0.03, check_overlap = TRUE, size = 3) +
  labs(
    title = "AI capability vs routine task share",
    x = "AI capability score",
    y = "Routine task share"
  ) +
  theme_minimal()

dir.create("output/figures", showWarnings = FALSE, recursive = TRUE)
ggsave("output/figures/risk_by_role.png", p1, width = 10, height = 6)
ggsave("output/figures/ai_vs_routine.png", p2, width = 8, height = 6)
message("Saved figures to output/figures/")
