SELECT customer_id, 
		customer_name, 
		customer_type, 
		credit_terms_days, 
		primary_freight_type, 
		annual_revenue_potential
FROM customers
WHERE account_status = 'Active'
ORDER BY annual_revenue_potential DESC
LIMIT 10;







