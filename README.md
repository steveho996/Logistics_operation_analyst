# Logistics_operation_analyst

Most logistics datasets are either proprietary (unavailable) or overly simplified (unrealistic). This fills the gap: operational complexity without confidentiality concerns. The data reflects real industry patterns:

Fuel prices track the 2022 diesel spike and 2023-2024 decline
Driver turnover sits at 15% annually (industry standard)
Equipment utilization averages 65% (typical for dry van operations)
On-time delivery performance ranges 85-95% (realistic service levels)
Maintenance intervals follow Class 8 PM schedules
Dataset Structure
Core Entities (Reference Tables):

Drivers (150 records) - Demographics, employment history, CDL info
Trucks (120 records) - Fleet specs, acquisition dates, status
Trailers (180 records) - Equipment types, current assignments
Customers (200 records) - Shipper accounts, contract terms, revenue potential
Facilities (50 records) - Terminals and warehouses with geocoordinates
Routes (60+ records) - City pairs with distances and rate structures
Operational Transactions:

Loads (57,000+ records) - Shipment details, revenue, booking type
Trips (57,000+ records) - Driver-truck assignments, actual performance
Fuel Purchases (131,000+ records) - Transaction-level data with pricing
Maintenance Records (6,500+ records) - Service history, costs, downtime
Delivery Events (114,000+ records) - Pickup/delivery timestamps, detention
Safety Incidents (114 records) - Accidents, violations, claims
Aggregated Analytics:

Driver Monthly Metrics (5,400+ records) - Performance summaries
Truck Utilization Metrics (3,800+ records) - Equipment efficiency
Key Features
Temporal Coverage: January 2022 through December 2024 (3 years)

Geographic Scope: National operations across 25+ major US cities

Realistic Patterns:

Seasonal freight fluctuations (Q4 peaks)
Historical fuel price accuracy
Equipment lifecycle modeling
Driver retention dynamics
Service level variations
Data Quality:

Complete foreign key integrity
No orphaned records
Intentional 2% null rate in driver/truck assignments (reflects reality)
All timestamps properly sequenced
Financial calculations verified

Use Case Examples
Business Intelligence:
Create executive dashboards showing revenue per truck, cost per mile, driver efficiency rankings, maintenance spend by equipment age, customer concentration risk.

Predictive Analytics:
Build models forecasting equipment failures based on maintenance history, predict driver turnover using performance metrics, estimate route profitability for new lanes.

Operations Optimization:
Analyze route efficiency, identify underutilized assets, optimize maintenance scheduling, calculate ideal fleet size, evaluate driver-to-truck ratios.

Sample Questions to Explore
1. Which drivers have the highest on‑time delivery rate, and how does this correlate with their average MPG?
2. What is the revenue per mile for each route, and which lanes generate the highest profit after fuel costs?
3. Which trucks generate the most revenue per month, and how many miles do they run compared to the fleet average?
4. Which trucks have the highest maintenance cost per mile, and how does downtime affect their revenue contribution?
5. How does fuel efficiency (MPG) vary by route type, distance, and driver?
6. Which customers generate the most revenue, and how do their on‑time delivery rates compare to others?
7. Which drivers and trucks have the highest incident rates, and what percentage of incidents were preventable?
8. How do load volumes and revenue fluctuate by month or season across different freight types?
9. What is the average fuel cost per route, and which lanes are most sensitive to fuel price changes?
10. Which facilities experience the most inbound and outbound loads, and how does this relate to operating hours and dock capacity?
11. Which routes generate the highest profit margin after fuel costs?
