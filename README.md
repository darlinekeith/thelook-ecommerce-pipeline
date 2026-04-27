# theLook eCommerce Data Pipeline

A end-to-end data engineering portfolio project built on **Google BigQuery**, **dbt Core**, and **Dagster** — ingesting, transforming, and orchestrating eCommerce data from Google's public theLook dataset.

![Pipeline](https://img.shields.io/badge/BigQuery-4285F4?style=flat&logo=google-cloud&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat&logo=dbt&logoColor=white)
![Dagster](https://img.shields.io/badge/Dagster-4F43DD?style=flat&logo=dagster&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)

---

## 📊 Live Dashboard

🔗 [View the Looker Studio Dashboard](#) ← replace with your link

The dashboard answers 4 key business questions:
- How has revenue trended month over month?
- What is the split of orders by status (shipped, returned, cancelled)?
- Which products generate the most revenue?
- What does the customer base look like — new vs returning vs loyal?

---

## 🏗️ Architecture

```
bigquery-public-data.thelook_ecommerce   ← Raw source (Google public dataset)
        │
        ▼
   Staging Layer (dbt)                   ← Cleaned, typed, renamed
   stg_orders / stg_order_items
   stg_products / stg_users
        │
        ▼
   Marts Layer (dbt)                     ← Business-level aggregations
   revenue_by_month / top_products
        │
        ▼
   Looker Studio Dashboard               ← Live visualisation
        │
   Dagster                               ← Orchestration + daily schedule
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Google BigQuery | Cloud data warehouse |
| dbt Core | Data transformation + testing + documentation |
| Dagster | Pipeline orchestration + scheduling |
| Looker Studio | Dashboard + visualisation |
| Python 3.11 | Runtime for Dagster |
| Git + GitHub | Version control |

---

## 📁 Project Structure

```
thelook-ecommerce-pipeline/
├── sql/                          # Raw SQL models (Week 1)
│   ├── revenue_by_status.sql
│   ├── revenue_by_month.sql
│   ├── top_products.sql
│   └── customer_segments.sql
│
├── thelook_pipeline/             # dbt Core project (Week 2)
│   ├── models/
│   │   ├── staging/
│   │   │   ├── sources.yml
│   │   │   ├── schema.yml
│   │   │   ├── stg_orders.sql
│   │   │   ├── stg_order_items.sql
│   │   │   ├── stg_products.sql
│   │   │   └── stg_users.sql
│   │   └── marts/
│   │       ├── revenue_by_month.sql
│   │       └── top_products.sql
│   └── dbt_project.yml
│
└── thelook_orchestration/        # Dagster project (Week 3)
    └── definitions.py
```

---

## 🧪 dbt Tests

The project includes **11 data quality tests** across all staging models:

- `unique` and `not_null` checks on all primary keys
- `accepted_values` check on order status
- `not_null` check on sale prices

Run tests with:
```bash
dbt test
```

---

## 📈 dbt Lineage Graph

The lineage graph shows how data flows from raw sources through staging into mart models:

```
thelook_ecommerce.orders ──────┐
                               ├──► stg_orders ────┐
thelook_ecommerce.order_items ─┤                   ├──► revenue_by_month
                               └──► stg_order_items┤
                                                   └──► top_products
thelook_ecommerce.products ────────► stg_products ─┘
thelook_ecommerce.users ───────────► stg_users
```

---

## ⚙️ Dagster Orchestration

The pipeline is orchestrated with Dagster and scheduled to run daily at 6am. The Dagster UI provides:

- Real-time asset materialisation status
- Run history and logs
- Visual DAG of all assets
- On/off toggle for the daily schedule

---

## 🚀 How to Run Locally

### Prerequisites
- Python 3.11
- Google Cloud account with BigQuery access
- `gcloud` CLI installed and authenticated

### Setup

```bash
# Clone the repo
git clone https://github.com/darlinekeith/thelook-ecommerce-pipeline.git
cd thelook-ecommerce-pipeline

# Create and activate virtual environment
python3.11 -m venv dbt-env
source dbt-env/bin/activate

# Install dependencies
pip install dbt-bigquery dagster dagster-webserver dagster-dbt

# Authenticate with Google Cloud
gcloud auth application-default login
gcloud auth application-default set-quota-project YOUR_PROJECT_ID
```

### Run dbt models

```bash
cd thelook_pipeline
dbt run
dbt test
dbt docs serve   # Opens docs at localhost:8080
```

### Run Dagster

```bash
cd ../thelook_orchestration
dagster dev -f definitions.py   # Opens UI at localhost:3000
```

---

## 📊 Key Findings

- **$10.8M** total revenue across all completed orders
- **27,497** unique customers in the dataset
- **181,808** total orders processed
- **30.1%** of orders are still in "Shipped" status — a potential fulfilment insight
- **10.2%** return rate worth investigating for product quality issues
- North Face and Arc'teryx dominate top revenue-generating products

---

## 👩‍💻 Author

**Darline** — Data Engineering Portfolio Project  
Built as part of a 4-week self-directed upskill plan
