-- Downtime Impact on Revenue Analysis

WITH truck_revenue AS (
    SELECT 
        tr.truck_id,
        COUNT(DISTINCT tr.trip_id) AS total_trips,
        SUM(tr.actual_distance_miles) AS total_miles,
        SUM(tr.actual_duration_hours) AS total_driving_hours,
        SUM(l.revenue) AS total_revenue,
        ROUND(SUM(l.revenue) / 
              NULLIF(SUM(tr.actual_distance_miles), 0), 2) AS revenue_per_mile
    FROM trips tr
    JOIN loads l ON tr.load_id = l.load_id
    WHERE tr.trip_status = 'Completed'
    GROUP BY tr.truck_id
),

truck_downtime AS (
    SELECT 
        truck_id,
		COUNT(truck_id) AS total_maintenance,
        SUM(downtime_hours) AS total_downtime_hours,
        SUM(total_cost) AS total_maintenance_cost
    FROM maintenance_records
    GROUP BY truck_id
)

SELECT 
    t.truck_id,
    t.unit_number,
    t.make,
    t.model_year,
    t.status,
    tr.total_trips,
    tr.total_miles,
    tr.total_revenue,
    tr.revenue_per_mile,
	td.total_maintenance,
    td.total_maintenance_cost,
    ROUND(td.total_maintenance_cost / NULLIF(tr.total_miles, 0), 4) AS maintenance_cost_per_mile,
    td.total_downtime_hours,
    -- Estimate potential revenue lost during downtime
    ROUND((td.total_downtime_hours / NULLIF(tr.total_driving_hours, 0)) * tr.total_revenue, 2) AS estimated_revenue_lost_to_downtime,
    -- Net revenue after maintenance costs
    ROUND(tr.total_revenue - td.total_maintenance_cost, 2) AS net_revenue_after_maintenance,
    -- Revenue efficiency metric (revenue per maintenance dollar)
    ROUND(tr.total_revenue / NULLIF(td.total_maintenance_cost, 0), 2) AS revenue_per_maintenance_dollar
FROM trucks t
LEFT JOIN truck_revenue tr ON t.truck_id = tr.truck_id
LEFT JOIN truck_downtime td ON t.truck_id = td.truck_id
WHERE tr.total_miles > 0
ORDER BY maintenance_cost_per_mile DESC
LIMIT 20;
