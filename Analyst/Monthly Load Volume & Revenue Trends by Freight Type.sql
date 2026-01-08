SELECT 
    EXTRACT(YEAR FROM l.load_date) AS year,
    EXTRACT(MONTH FROM l.load_date) AS month,
    TO_CHAR(DATE_TRUNC('month', l.load_date), 'Month') AS month_name,
    l.load_type,
    COUNT(*) AS load_count,
    ROUND(SUM(l.revenue + l.fuel_surcharge + l.accessorial_charges), 2) AS total_revenue,
    ROUND(AVG(l.revenue + l.fuel_surcharge + l.accessorial_charges), 2) AS avg_revenue_per_load,
    ROUND(SUM(l.weight_lbs) / 1000.0, 2) AS total_weight_thousands_lbs,
    ROUND(AVG(l.weight_lbs), 2) AS avg_weight_per_load,
    SUM(l.pieces) AS total_pieces,
    ROUND(AVG(l.pieces), 2) AS avg_pieces_per_load,
    -- Revenue
    ROUND(SUM(l.revenue), 2) AS base_revenue,
    ROUND(SUM(l.fuel_surcharge), 2) AS fuel_surcharge_revenue,
    ROUND(SUM(l.accessorial_charges), 2) AS accessorial_revenue,
    -- Booking type
    SUM(CASE WHEN l.booking_type = 'Spot' THEN 1 ELSE 0 END) AS spot_loads,
    SUM(CASE WHEN l.booking_type = 'Dedicated' THEN 1 ELSE 0 END) AS dedicated_loads,
    SUM(CASE WHEN l.booking_type = 'Contract' THEN 1 ELSE 0 END) AS contract_loads
FROM loads l
WHERE l.load_status = 'Completed'
GROUP BY EXTRACT(YEAR FROM l.load_date), 
         EXTRACT(MONTH FROM l.load_date), 
         DATE_TRUNC('month', l.load_date),
         l.load_type
ORDER BY year, month, l.load_type;