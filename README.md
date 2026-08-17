# Logistics Operations SQL Project

End-to-end logistics data analysis project — from data modeling to analysis — built with PostgreSQL and Power Query, following a clear ETL flow and version-controlled via Git/GitHub.

**Business impact at a glance:** revenue is concentrated among a small group of top customers, older/high-mileage trucks drive most maintenance costs, and short-haul routes deliver the strongest margins — see [Key Insights](#key-insights) below.

## Project Structure

- `Schema_diagram.pdf` — data model / ER diagram
- `schema.sql` — database schema for logistics operations
- `Data/` — sample CSV datasets
- `Analyst/` — SQL queries with comments
- `Analyst/screenshots/` — data profiling and query output screenshots

## Setup

1. Install PostgreSQL and pgAdmin 4.
2. Run `schema.sql` in pgAdmin to create the database schema.
3. Load the CSV files from `Data/` into the corresponding tables (via `COPY` or pgAdmin's import tool).
4. Open the queries in `Analyst/` to reproduce the analysis and screenshots.

## Data Modeling

### Entities and Table Types

```
FACT TABLES (Events/Transactions)
├─ trips             → drivers, trucks, trailers, loads
├─ loads             → customers, routes
├─ delivery_events   → loads, trips, facilities
├─ safety_incidents  → trips, trucks, drivers
├─ fuel_purchases    → trips, trucks, drivers
└─ maintenance_records → trucks

DIMENSION TABLES (Reference/Master Data)
├─ drivers
├─ trucks
├─ trailers
├─ routes
├─ customers
└─ facilities

AGGREGATED TABLES (Downstream reporting layer, built on the star schema)
├─ driver_monthly_metrics   (aggregate of trips + incidents)
└─ truck_utilization_metrics (aggregate of trips + maintenance)
```

### Normalization (3NF)

The core model is a star schema; dimension tables are normalized to eliminate redundant data.

**Before (redundant)** — driver info repeated in every trip row:

| trip_id | driver_id | driver_name | hire_date | email |
|---|---|---|---|---|
| T001 | D001 | John | 2020-01-15 | john\@email.com |
| T002 | D001 | John | 2020-01-15 | john\@email.com |

**After (normalized)** — driver info stored once, referenced by key:

`drivers`

| driver_id | driver_name | hire_date | email |
|---|---|---|---|
| D001 | John | 2020-01-15 | john\@email.com |

`trips`

| trip_id | driver_id |
|---|---|
| T001 | D001 |
| T002 | D001 |

### Data Quality Constraints

```sql
-- Primary Keys ensure unique identifiers
driver_id, truck_id, load_id, trip_id, etc.

-- Foreign Keys maintain referential integrity
trips.driver_id → drivers.driver_id
trips.truck_id  → trucks.truck_id

-- NOT NULL constraints on critical fields
customer_name   -- must know customer
revenue         -- must have value for billing
incident_date   -- must know when incident occurred

-- Domain constraints on valid values
trip_status   IN ('Completed', 'In Progress', 'Delayed')
incident_type IN ('Moving Violation', 'Accident', 'Equipment Damage')
```

## ETL Flow

### 1. Extract
- Source: CSV files exported from the logistics operations database.
- Files loaded into Power Query to inspect data structure, types, and quality.

### 2. Transform
Data cleaned and standardized using Power Query:
- Removed duplicate records and blank rows.
- Standardized date formats and data types (e.g., dates, numeric fields).
- Handled missing values in critical columns.
- Renamed columns for consistency with `schema.sql`.

### 3. Load
- Cleaned CSV files loaded into PostgreSQL.
- Database schema defined in `schema.sql`.
- SQL queries executed on clean data for analysis.

## Business Questions & SQL Analysis

1. **Top Revenue Customers** – identify highest revenue-generating customers
2. **Driver On-Time Performance** – top drivers for punctual deliveries
3. **Truck Maintenance Costs** – monitor truck maintenance and downtime
4. **Fuel Consumption** – analyze fuel efficiency by truck
5. **Route Revenue & Distance** – identify profitable routes
6. **Incident Analysis** – monitor driver/truck safety incidents
7. **Average Load Weight & Trip Analysis** – optimize logistics planning

> SQL queries with comments are in `Analyst/`. Screenshots of outputs are in `Analyst/screenshots/`.

## SQL Techniques Used

- `JOIN` (INNER, LEFT)
- `GROUP BY` and aggregations (`SUM`, `AVG`, `COUNT`)
- Window functions (`ROW_NUMBER`, `RANK`)
- Common Table Expressions (CTE)
- Date/time functions and calculations
- Conditional aggregations and filtering

## Key Insights

1. **Top Revenue Customers** — Revenue is heavily concentrated among a small group of high-value contract customers, especially in Retail and Consumer Goods. Inactive accounts represent millions in lost potential revenue.
2. **Driver On-Time Performance** — Experienced drivers and those based in major hubs consistently achieve the highest on-time delivery rates. Strong on-time performance often aligns with safer, more consistent driving habits.
3. **Truck Maintenance Costs** — Older trucks and high-mileage units incur the most maintenance costs and downtime. Frequent repairs directly reduce asset utilization and monthly revenue.
4. **Fuel Consumption & Efficiency** — Newer trucks deliver better MPG, while routes with heavy traffic or elevation changes reduce fuel efficiency. Even small MPG improvements can significantly lower fleet-wide fuel costs.
5. **Route Revenue & Distance** — Short-haul, high-rate routes generate the strongest profit margins due to lower fuel consumption. Long-haul routes bring higher total revenue but lower margin because of fuel and wear.
6. **Safety Incident Analysis** — Preventable incidents cluster around newer drivers and congested metro regions. Weather-related incidents spike seasonally, increasing operational risk during winter months.
7. **Load & Trip Pattern Insights** — Trip patterns show opportunities to reduce empty miles and balance freight across terminals. Consistent regional lanes suggest potential for optimizing trailer assignment and route planning.

## Tech Stack

- PostgreSQL (pgAdmin 4)
- SQL
- Power Query / Excel for data cleaning and profiling
- GitHub for version control and portfolio presentation
