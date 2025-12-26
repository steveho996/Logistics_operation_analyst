WITH on_time AS (
SELECT 
    t.driver_id,
	ROUND(AVG(average_mpg), 2) AS average_mpg,
    COUNT(*) AS total_deliveries,
    COUNT(CASE WHEN de.on_time_flag = TRUE THEN 1 END) AS on_time_deliveries,
    ROUND(
		COUNT(CASE WHEN de.on_time_flag = TRUE THEN 1 END) * 1.0 / COUNT(*) *100, 2
		) AS on_time_rate
FROM trips t
JOIN delivery_events de
    ON t.trip_id = de.trip_id
GROUP BY t.driver_id
),
mpg AS (
SELECT 
)
SELECT 
	dr.driver_id,
	dr.first_name,
	dr.last_name,
	ot.total_deliveries,
	ot.on_time_deliveries,
	ot.on_time_rate,
	ot.average_mpg
FROM drivers dr
JOIN on_time ot 
	ON dr.driver_id = ot.driver_id
ORDER BY ot.on_time_rate DESC, ot.average_mpg DESC
	

