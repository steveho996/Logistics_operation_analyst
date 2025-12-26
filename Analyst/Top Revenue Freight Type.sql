SELECT 
    primary_freight_type,
    SUM(annual_revenue_potential) AS total_revenue
FROM customers
WHERE account_status = 'Active'
GROUP BY primary_freight_type
ORDER BY total_revenue DESC;
