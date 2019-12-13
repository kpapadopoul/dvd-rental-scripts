WITH rental_payment AS (
	SELECT rental.staff_id AS rental_staff, payment.staff_id AS payment_staff
	FROM rental
	JOIN payment ON rental.rental_id = payment.rental_id),
	rental_count AS (
	SELECT COUNT(*)
	FROM rental_payment),
	same_staff_count AS (
	SELECT COUNT(*)
	FROM rental_payment
	WHERE rental_staff = payment_staff)
	
SELECT CAST(same_staff_count.count AS FLOAT) / CAST(rental_count.count AS FLOAT) * 100
FROM same_staff_count, rental_count
	
