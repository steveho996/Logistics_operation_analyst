--Truck Incident Rates & Risk Scoring

WITH truck_activity AS (
    SELECT 
        truck_id,
        COUNT(DISTINCT trip_id) AS total_trips,
        SUM(actual_distance_miles) AS total_miles,
        SUM(actual_duration_hours) AS total_hours
    FROM trips
    WHERE trip_status = 'Completed'
    GROUP BY truck_id
),

truck_incidents AS (
    SELECT 
        si.truck_id,
        COUNT(*) AS total_incidents,
        SUM(CASE WHEN si.preventable_flag = TRUE THEN 1 ELSE 0 END) AS preventable_incidents,
        SUM(CASE WHEN si.preventable_flag = FALSE THEN 1 ELSE 0 END) AS non_preventable_incidents,
        SUM(CASE WHEN si.at_fault_flag = TRUE THEN 1 ELSE 0 END) AS at_fault_incidents,
        SUM(CASE WHEN si.injury_flag = TRUE THEN 1 ELSE 0 END) AS injury_incidents,
        ROUND(SUM(si.vehicle_damage_cost + si.cargo_damage_cost), 2) AS total_damage_cost,
        ROUND(SUM(si.claim_amount), 2) AS total_claim_amount,
        -- Incident type 
        SUM(CASE WHEN si.incident_type = 'Moving Violation' THEN 1 ELSE 0 END) AS moving_violations,
        SUM(CASE WHEN si.incident_type = 'Accident' THEN 1 ELSE 0 END) AS accidents,
        SUM(CASE WHEN si.incident_type = 'Equipment Damage' THEN 1 ELSE 0 END) AS equipment_damage,
        SUM(CASE WHEN si.incident_type = 'Customer Complaint' THEN 1 ELSE 0 END) AS customer_complaints
    FROM safety_incidents si
    GROUP BY si.truck_id
)

SELECT 
    t.truck_id,
    t.unit_number,
    t.make,
    t.model_year,
    t.status,
    t.acquisition_date,
    EXTRACT(YEAR FROM CURRENT_DATE) - t.model_year AS truck_age,
    ta.total_trips,
    ta.total_miles,
    ti.total_incidents,
    ti.preventable_incidents,
    ti.non_preventable_incidents,
    ti.at_fault_incidents,
    ti.injury_incidents,
    -- Incident rates
    ROUND((ti.total_incidents::NUMERIC / NULLIF(ta.total_miles, 0)) * 100000, 2) AS incidents_per_100k_miles,
    ROUND((ti.preventable_incidents::NUMERIC / NULLIF(ta.total_miles, 0)) * 100000, 2) AS preventable_per_100k_miles,
    -- Preventability percentage
    ROUND((ti.preventable_incidents::NUMERIC / NULLIF(ti.total_incidents, 0)) * 100, 2) AS preventable_pct,
    -- Financial impact
    ROUND(ti.total_damage_cost, 2) AS total_damage_cost,
    ROUND(ti.total_claim_amount, 2) AS total_claim_amount,
    ROUND(ti.total_damage_cost / NULLIF(ta.total_miles, 0), 4) AS damage_cost_per_mile,
    -- Incident type 
    ti.moving_violations,
    ti.accidents,
    ti.equipment_damage,
    ti.customer_complaints,
    -- Risk Score
    ROUND(
        (ti.preventable_incidents * 10) + 
        (ti.at_fault_incidents * 5) + 
        (ti.injury_incidents * 20) +
        ((ti.total_incidents::NUMERIC / NULLIF(ta.total_miles, 0)) * 100000) +
        ((EXTRACT(YEAR FROM CURRENT_DATE) - t.model_year) * 0.5), 
        2
    ) AS risk_score
FROM trucks t
INNER JOIN truck_activity ta ON t.truck_id = ta.truck_id
LEFT JOIN truck_incidents ti ON t.truck_id = ti.truck_id
WHERE ti.total_incidents > 0  
ORDER BY risk_score DESC, incidents_per_100k_miles DESC
LIMIT 25;