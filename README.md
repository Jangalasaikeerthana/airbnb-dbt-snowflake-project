# Airbnb Data Engineering Pipeline

## Overview
End-to-end data pipeline for Airbnb data using Medallion Architecture (Bronze → Silver → Gold).
Raw data lands in AWS S3, gets loaded into Snowflake, and transformed using dbt into
analytics-ready fact and dimension tables.

## Architecture
AWS S3 (raw data)->Bronze Layer (raw, incremental load)-> Silver Layer (cleaned, standardized) -> Gold Layer (fact + dimension tables, star schema)

## Tech Stack
- **Snowflake** — cloud data warehouse
- **dbt** — data transformation and modeling
- **AWS S3** — raw data storage
- **Python** — data ingestion
- **SQL + Jinja** — dynamic SQL generation

## Key Features
- Medallion Architecture (Bronze → Silver → Gold)
- Incremental loading to efficiently process only new data
- SCD Type 2 snapshots to track historical changes across listings, hosts, and bookings
- Custom dbt macros using Jinja templating for reusable business logic and dynamic SQL generation
- Star schema in Gold layer (Fact + Dimension tables)
- Automated dbt tests for data quality enforcement
- dbt lineage documentation for pipeline visibility

## Project Structure
models/
├── bronze/          # raw data, incremental load
├── silver/          # cleaned and standardized
└── gold/
├── obt.sql      # one big table (intermediate)
├── fact.sql      # fact table (numeric metrics)
└── ephemeral/   # dim models (not materialized)
macros/              # reusable Jinja macros
tests/               # data quality tests
snapshots/           # SCD Type 2 tracking

- **FACT_BOOKINGS** — booking_id, total_amount, service_fee, cleaning_fee, price_per_night
- **DIM_LISTINGS** — property_type, room_type, city, country, bedrooms
- **DIM_HOSTS** — host_name, is_superhost, response_rate

## How to Run

### Prerequisites
- Snowflake account
- dbt installed (`pip install dbt-snowflake`)
- AWS S3 bucket set up

### Setup
1. Clone the repo
```bash
git clone https://github.com/Jangalasaikeerthana/airbnb-dbt-snowflake-project.git
cd airbnb-dbt-snowflake-project
```

2. Configure your Snowflake credentials in `profiles.yml` using environment variables:
```yaml
aws_dbt_snowflake_project:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: "{{ env_var('SNOWFLAKE_ACCOUNT') }}"
      user: "{{ env_var('SNOWFLAKE_USER') }}"
      password: "{{ env_var('SNOWFLAKE_PASSWORD') }}"
      database: AIRBNB
      schema: dbt_schema
```

3. Run dbt models:
```bash
dbt run
```

4. Run tests:
```bash
dbt test
```

5. Generate documentation:
```bash
dbt docs generate
dbt docs serve
```

## What I Learned
- How Jinja templating makes SQL dynamic and maintainable
- Why `ref()` matters for dbt DAG and run order
- Difference between ephemeral, view, and table materializations
- Star schema design — separating facts from dimensions to reduce data redundancy
- SCD Type 2 for tracking historical changes in dimension tables
- Never commit credentials — use environment variables instead




