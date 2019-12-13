SELECT date_trunc('month', rental_date) AS rental_month, count(*) as monthly_sum
FROM rental
GROUP BY rental_month
ORDER BY rental_month