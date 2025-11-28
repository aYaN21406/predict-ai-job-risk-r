# Predict-AI-Job-Risk (R)

**What:** Predictive analysis of how AI may impact jobs — focusing on software roles (frontend, backend, devops, QA, etc.).

**Stack:** R (tidyverse, tidymodels), RMarkdown for reporting. Easy to extend to SQLite, Go, C later.

## Quick project goals

- Ingest labor / job / skills datasets
- Compute an automation-risk score by job and role
- Build predictive models and forecast trends
- Visualize results and generate a report

## Repo layout

```
predict-ai-job-risk-r/
├─ README.md
├─ .gitignore
├─ install_packages.R
├─ data/
│  ├─ raw/      # raw files (download links & instructions below)
│  └─ processed/
├─ R/
│  ├─ 01_data_fetch.R
│  ├─ 02_data_clean.R
│  ├─ 03_features.R
│  ├─ 04_modeling.R
│  ├─ 05_viz.R
│  └─ utils.R
├─ report/
│  └─ report.Rmd
├─ output/
│  ├─ figures/
│  └─ tables/
└─ LICENSE
```

## Datasets (recommended)

1. **BLS**: Occupational Employment and Wage Statistics (OEWS) — download CSV for occupational employment and wages.
   - https://www.bls.gov/oes/data.htm
2. **O*NET**: Skills & tasks by occupation
   - https://www.onetcenter.org/download.html
3. **StackOverflow / GitHub survey** (optional): developer trends

> If you can't download O*NET, the scripts include a synthetic-data fallback.

## Quick start (local)

1. Install R >= 4.0 and Git.
2. Clone repository or create new project and paste files.
3. From R console: `source("install_packages.R")`
4. Place downloaded CSVs into `data/raw/` as explained below (or run fallback data generation).
5. Run scripts in order (or run the report):
   - `Rscript R/01_data_fetch.R`
   - `Rscript R/02_data_clean.R`
   - `Rscript R/03_features.R`
   - `Rscript R/04_modeling.R`
   - `Rscript R/05_viz.R`
   - To generate report: open `report/report.Rmd` in RStudio and knit to HTML.

## Output

Results and figures are written to `output/`. Models are saved as RDS files in `output/models/`.

## How this is resume-worthy

- Real-world datasets, reproducible pipeline (scripts, Rmd), predictive modeling, and strong visualizations.
- Easy to extend: add a Go microservice to serve predictions, SQLite for storage, C for a CLI result viewer.

## License

MIT — see LICENSE file.
