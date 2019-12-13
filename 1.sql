WITH rental_count AS (
	SELECT customer.*, COUNT(rental.rental_id) AS rentals
	FROM customer
	JOIN rental ON customer.customer_id = rental.customer_id
	GROUP BY customer.customer_id),
	rental_max AS (
	SELECT *, MAX(rental_count.rentals) OVER (PARTITION BY rental_count.store_id)
	FROM rental_count)

SELECT *
FROM rental_max
WHERE rental_max.rentals = rental_max.max;