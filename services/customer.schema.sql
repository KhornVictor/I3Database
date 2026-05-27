use nomnom;
show tables;

-- View all restaurant
SELECT *
FROM Restaurants;

-- View all available menu items
SELECT name, price
FROM Menu_Items
WHERE is_available = TRUE;

-- View menu items from a specific restaurant
SELECT m.name, m.price, r.name AS restaurant_name
FROM Menu_Items m
JOIN Restaurants r
ON m.restaurant_id = r.restaurant_id
WHERE r.name = 'Hel Corner'; 

-- View items by category
SELECT m.name, c.name AS category
FROM Menu_Items m
JOIN Categories c
ON m.category_id = c.category_id
WHERE c.name = 'Drink'; 

-- View customer cart
SELECT u.name AS customer,
       m.name AS item,
       ci.quantity,
       ci.price
FROM Cart_Items ci
JOIN Carts c
ON ci.cart_id = c.cart_id
JOIN Users u
ON c.user_id = u.user_id
JOIN Menu_Items m
ON ci.item_id = m.item_id
WHERE u.user_id = 3; 

-- Calculate cart total price
SELECT u.name,
       SUM(ci.quantity * ci.price) AS total_cart_price
FROM Cart_Items ci
JOIN Carts c
ON ci.cart_id = c.cart_id
JOIN Users u
ON c.user_id = u.user_id
WHERE u.user_id = 3 
GROUP BY u.user_id, u.name;

-- View customer order history
SELECT o.order_id,
       o.total_price,
       o.status,
       o.created_at
FROM Orders o
WHERE o.user_id = 3; 

-- View items inside an order
SELECT o.order_id,
       m.name AS item_name,
       oi.quantity,
       oi.price
FROM Order_Items oi
JOIN Orders o
ON oi.order_id = o.order_id
JOIN Menu_Items m
ON oi.item_id = m.item_id
WHERE o.order_id = 1; 

-- Track delivery status
SELECT o.order_id,
       d.status,
       d.estimated_arrival,
       dp.name AS delivery_person
FROM Deliveries d
JOIN Orders o
ON d.order_id = o.order_id
JOIN Delivery_Personnel dp
ON d.delivery_person_id = dp.delivery_person_id
WHERE o.order_id = 1; 

-- View customer notifications
SELECT title,
       message,
       created_at
FROM Notifications
WHERE user_id = 3; 

-- View unread notifications
SELECT title,
       message
FROM Notifications
WHERE user_id = 3
AND is_read = FALSE;

-- View restaurant reviews
SELECT r.name AS restaurant,
       rv.rating,
       rv.comment
FROM Reviews rv
JOIN Restaurants r
ON rv.restaurant_id = r.restaurant_id
WHERE r.name = 'Khmer Taste';

-- View active promotions
SELECT code,
       title,
       discount_type,
       discount_value
FROM Promotions
WHERE is_active = TRUE;

-- View orders with payment status
SELECT o.order_id,
       o.total_price,
       p.payment_method,
       p.status
FROM Orders o
JOIN Payments p
ON o.order_id = p.order_id;

-- Find top-rated restaurants
SELECT r.name,
       AVG(rv.rating) AS average_rating
FROM Reviews rv
JOIN Restaurants r
ON rv.restaurant_id = r.restaurant_id
GROUP BY r.name
ORDER BY average_rating DESC;

-- Customers who spent above average
SELECT name
FROM Users
WHERE user_id IN (
    SELECT user_id
    FROM Orders
    GROUP BY user_id
    HAVING SUM(total_price) >
    (
        SELECT AVG(total_spent)
        FROM (
            SELECT SUM(total_price) AS total_spent
            FROM Orders
            GROUP BY user_id
        ) AS spending
    )
);

-- Most expensive menu item
SELECT name, price
FROM Menu_Items
WHERE price = (
    SELECT MAX(price)
    FROM Menu_Items
);

-- Restaurants with above-average ratings
SELECT name
FROM Restaurants
WHERE restaurant_id IN (
    SELECT restaurant_id
    FROM Reviews
    GROUP BY restaurant_id
    HAVING AVG(rating) >
    (
        SELECT AVG(rating)
        FROM Reviews
    )
);