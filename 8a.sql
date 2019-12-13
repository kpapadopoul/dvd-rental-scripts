SELECT store.store_id, count(*)
FROM rental
JOIN staff ON rental.staff_id = staff.staff_id
JOIN store ON staff.store_id = store.store_id
GROUP BY store.store_id