SELECT m.name AS food, r.name AS restaurant
FROM Menu_Items m
JOIN Restaurants r
ON m.restaurant_id = r.restaurant_id
ORDER BY r.name;