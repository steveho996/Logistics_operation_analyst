WITH route_info AS(
SELECT 
	r.route_id,
	r.origin_city,
	r.destination_city,
	SUM(l.revenue) AS total_revenue,
	SUM(t.actual_distance_miles) AS total_mile,
	SUM(f.total_cost) AS total_fuel_cost
FROM routes r
JOIN loads l
	ON r.route_id = l.route_id
JOIN trips t
	ON l.load_id = t.load_id
LEFT JOIN fuel_purchases f
	ON t.trip_id = f.trip_id
GROUP BY r.route_id, r.origin_city, r.destination_city
)
SELECT
	route_id,
	origin_city,
	destination_city,
	total_revenue,
	total_mile,
	total_fuel_cost,
	ROUND(total_revenue/ NULLIF(total_mile, 0) * 100, 2) AS revenue_per_mile,
	ROUND(total_fuel_cost/NULLIF(total_mile, 0) * 100, 2) AS fuel_cost_per_mile,
	ROUND((total_revenue - total_fuel_cost)/ NULLIF(total_mile, 0) * 100, 2 ) AS profit_per_mile 
FROM route_info 
ORDER BY profit_per_mile