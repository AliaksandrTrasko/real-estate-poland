# Polish Real Estate Market Analysis

An end-to-end data analytics project exploring the real estate market (sales and rentals) across 15 major cities in Poland. This repository demonstrates a complete data pipeline: processing raw web-scraped data, structuring a relational database, writing advanced analytical SQL queries, and delivering business insights through data visualization.

**Dataset:** Apartment Prices in Poland (more than 260.000 cleaned records)
**Dataset source:** [Kaggle - Apartment Prices in Poland](https://www.kaggle.com/datasets/krzysztofjamroz/apartment-prices-in-poland/data/code)

## Tech Stack
* **Python (pandas):** Data cleaning and ETL processing.
* **PostgreSQL:** Relational database management, complex querying (CTE, Window Functions, JOINs).
* **Microsoft Excel:** Final data visualization and static dashboard reporting

## Project Structure
```text
├── data/
│   ├── raw/                 # Original scraped CSV files (ignored in git)
│   ├── processed/           # Cleaned dataset ready for SQL import (ignored in git)
│   └── results/             # Query outputs (CSV) used for visualizations (ignored in git)
├── notebooks/
│   ├── 01_combine.ipynb     # Merges 19 raw CSV files, adds offer_type and date_month columns
│   ├── 02_clean.ipynb       # Handles missing values, renames columns, fixes building types
│   ├── setup.sql            # Scripts for table creation and data import
│   ├── ROI_analysis.sql     # Return on Investment logic by city & type
│   ├── pricing_analysis.sql # Premium features and distance-to-center logic
│   └── market_trends.sql    # Time-series analysis and floor impact
└── README.md
```


# Dashboard & Visualizations
The results of the SQL queries were exported to Excel to construct a clean, executive-level dashboard.

---

# Key Business Insights
