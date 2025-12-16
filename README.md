# Logistics Operation SQL Portfolio

This portfolio demonstrates end-to-end **logistics data analysis** using PostgreSQL and Power Query, following a clear **ETL flow** (Extract → Transform → Load).

---

## Project Structure
- `schema.sql` → Database schema for logistics operations
- `Data/` → Sample CSV datasets
- `Analyst/` → SQL queries and output screenshots
- `Analyst/screenshots/` → Visual outputs, data profiling, ETL flow diagrams

---

## ETL Flow

### 1. Extract
- Source: CSV files exported from logistics operations database
- Files loaded into **Power Query** to inspect data structure, types, and quality

### 2. Transform
- Data cleaned and standardized using **Power Query**:

### 3. Load
- Cleaned CSV files loaded into **PostgreSQL**
- Database schema defined in `schema.sql`
- SQL queries executed on **clean data** for analysis

---

## Business Questions & SQL Analysis

1. **Top Revenue Customers** – identify highest revenue-generating customers
2. **Driver On-Time Performance** – top drivers for punctual deliveries
3. **Truck Maintenance Costs** – monitor truck maintenance and downtime
4. **Fuel Consumption** – analyze fuel efficiency by truck
5. **Route Revenue & Distance** – identify profitable routes
6. **Incident Analysis** – monitor driver/truck safety incidents
7. **Average Load Weight & Trip Analysis** – optimize logistics planning

> SQL queries with comments are in `Analyst/queries.sql`. Screenshots of outputs are in `Analyst/screenshots/`.

---

## SQL Techniques Used
- `JOIN` (INNER, LEFT)
- `GROUP BY` and Aggregations (`SUM`, `AVG`, `COUNT`)
- Window Functions (`ROW_NUMBER`, `RANK`)
- Common Table Expressions (CTE)
- Date/Time functions and calculations
- Conditional aggregations and filtering

---

## Key Found Insights
1. Top Revenue Customers
Revenue is heavily concentrated among a small group of high‑value contract customers, especially in Retail and Consumer Goods. Inactive accounts represent millions in lost potential revenue.

2. Driver On‑Time Performance
Experienced drivers and those based in major hubs consistently achieve the highest on‑time delivery rates. Strong on‑time performance often aligns with safer, more consistent driving habits.

3. Truck Maintenance Costs
Older trucks and high‑mileage units incur the most maintenance costs and downtime. Frequent repairs directly reduce asset utilization and monthly revenue.

4. Fuel Consumption & Efficiency
Newer trucks deliver better MPG, while routes with heavy traffic or elevation changes reduce fuel efficiency. Even small MPG improvements can significantly lower fleet-wide fuel costs.

5. Route Revenue & Distance
Short‑haul, high‑rate routes generate the strongest profit margins due to lower fuel consumption. Long‑haul routes bring higher total revenue but lower margin because of fuel and wear.

6. Safety Incident Analysis
Preventable incidents cluster around newer drivers and congested metro regions. Weather‑related incidents spike seasonally, increasing operational risk during winter months.

7. Load & Trip Pattern Insights
Trip patterns show opportunities to reduce empty miles and balance freight across terminals. Consistent regional lanes suggest potential for optimizing trailer assignment and route planning.

---

## Tech Stack
- PostgreSQL (pgAdmin 4)
- SQL
- Power Query / Excel for data cleaning and profiling
- GitHub for version control and portfolio presentation

