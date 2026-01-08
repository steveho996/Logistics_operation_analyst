--Driver incident rate and risk scoring
WITH driver_activity AS 
(
	SELECT 
	 driver_id,
	 COUNT(DISTINCT trip_id) AS total_trips,
	 SUM(actual_distance_miles) AS total_miles,
	 SUM(actual_duration_hours) AS total_hours
	FROM trips
	WHERE trip_status = 'Completed'
	GROUP BY driver_id
),

driver_incidents AS
(
	SELECT
		si.driver_id,
		COUNT(*) AS total_incidents,
		SUM(CASE WHEN si.preventable_flag = TRUE THEN 1 ELSE 0 END) AS preventable_incidents,
		SUM(CASE WHEN si.preventable_flag = FALSE THEN 1 ELSE 0 END) AS non_preventable_incidents,
		SUM(CASE WHEN si.at_fault_flag = TRUE THEN 1 ELSE 0 END) AS at_fault_incidents,
		SUM(CASE WHEN si.injury_flag = TRUE THEN 1 ELSE 0 END) AS injury_incidents,
		ROUND(SUM(si.vehicle_damage_cost + si.cargo_damage_cost), 2) AS total_damage_cost,
		ROUND(SUM(si.claim_amount), 2) AS total_claim_amount,
		---Incident type
		SUM(CASE WHEN si.incident_type = 'Moving Violation' THEN 1 ELSE 0 END) AS moving_violations,
		SUM(CASE WHEN si.incident_type = 'Accident' THEN 1 ELSE 0 END) AS accidents,
        SUM(CASE WHEN si.incident_type = 'Equipment Damage' THEN 1 ELSE 0 END) AS equipment_damage,
        SUM(CASE WHEN si.incident_type = 'Customer Complaint' THEN 1 ELSE 0 END) AS customer_complaints
    FROM safety_incidents si
	GROUP BY si.driver_id
)

SELECT 
	d.driver_id,
	d.first_name,
	d.last_name,
	d.hire_date,
    d.license_number,
    d.employment_status,
    da.total_trips,
    da.total_miles,
    di.total_incidents,
    di.preventable_incidents,
    di.non_preventable_incidents,
    di.at_fault_incidents,
    di.injury_incidents,
	--Incident rates (per 1000,000 miles)
	ROUND((di.total_incidents::NUMERIC / NULLIF(da.total_miles, 0)) * 100000, 2) AS incidents_per_100k_miles,
	ROUND((di.preventable_incidents::NUMERIC / NULLIF(da.total_miles, 0)) * 100000, 2) AS preventable_per_100k_miles,
    -- Preventability percentage
    ROUND((di.preventable_incidents::NUMERIC / NULLIF(di.total_incidents, 0)) * 100, 2) AS preventable_pct,
    -- Financial impact
    di.total_damage_cost,
    di.total_claim_amount,
    ROUND(di.total_damage_cost / NULLIF(da.total_miles, 0), 4) AS damage_cost_per_mile,
	-- Incident type breakdown
    di.moving_violations,
    di.accidents,
    di.equipment_damage,
    di.customer_complaints,
	--Risk score
	ROUND(
        (di.preventable_incidents * 10) + 
        (di.at_fault_incidents * 5) + 
        (di.injury_incidents * 20) +
        ((di.total_incidents::NUMERIC / NULLIF(da.total_miles, 0)) * 100000),
        2
    ) AS risk_score
FROM drivers d
INNER JOIN driver_activity da ON d.driver_id = da.driver_id
LEFT JOIN driver_incidents di ON d.driver_id = di.driver_id
WHERE di.total_incidents > 0 
ORDER BY risk_score DESC, incidents_per_100k_miles DESC
LIMIT 25;

