WITH rental_customer_months AS (
	SELECT rental.customer_id, date_trunc('month', rental_date) AS rental_month
	FROM rental
	GROUP BY rental.customer_id, rental_month),
	customer_month_count AS (
	SELECT rental_customer_months.customer_id, COUNT(*)
	FROM rental_customer_months
	GROUP BY rental_customer_months.customer_id),
	total_customer_count AS (
	SELECT COUNT(*)
	FROM customer_month_count),
	active_customer_count AS (
	SELECT COUNT(*) 
	FROM customer_month_count 
	WHERE customer_month_count.count = 5)
	
SELECT CAST(active_customer_count.count AS FLOAT) / CAST(total_customer_count.count AS FLOAT) * 100
FROM active_customer_count, total_customer_count


