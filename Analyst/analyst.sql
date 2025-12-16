-- Question 1: Which routes generate the highest profit margin after fuel costs?
-- To answer this question, firstly, we define which is "Revenue per mile", "distance", and "fuel cost per mile"
--- "Revenue per mile" = base_rate_per_mile (from routes table) + fuel_surcharge_rate (from routes table)
--- "Distance" = typical_distance_miles (from routes table)
--- Fuel cost per mile = price_per_gallon/average_mpg = 4/6.5 (frpm trips table)

WITH routes_calculation AS (
    SELECT
        route_id,
        origin_city,
        origin_state,
        destination_city,
        destination_state,
        typical_distance_miles,
        typical_distance_miles * (base_rate_per_mile + fuel_surcharge_rate) AS total_revenue,
        (typical_distance_miles / 6.5) * 4.00 AS fuel_cost
    FROM routes
)
SELECT 
route_id,
        origin_city,
        origin_state,
        destination_city,
        destination_state,
        typical_distance_miles,
        total_revenue,
        fuel_cost,
        (total_revenue - fuel_cost) AS profit,
        ROUND((total_revenue - fuel_cost) / total_revenue, 4) AS profit_margin
FROM routes_calculation
ORDER BY profit_margin DESC
LIMIT 10;