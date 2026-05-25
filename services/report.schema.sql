-- Total revenue from paid orders
SELECT SUM(amount) AS total_revenue
FROM Payments
WHERE status = 'paid';

-- Revenue by payment method
SELECT payment_method,
       SUM(amount) AS total_revenue
FROM Payments
WHERE status = 'paid'
GROUP BY payment_method;

-- Total orders by status
SELECT status,
       COUNT(*) AS total_orders
FROM Orders
GROUP BY status;

-- Top-selling menu items
SELECT m.item_id,
       m.name AS item_name,
       SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Menu_Items m
ON oi.item_id = m.item_id
GROUP BY m.item_id, m.name
ORDER BY total_sold DESC;

-- Revenue by restaurant
SELECT r.restaurant_id,
       r.name AS restaurant_name,
       SUM(oi.quantity * oi.price) AS total_revenue
FROM Order_Items oi
JOIN Menu_Items m
ON oi.item_id = m.item_id
JOIN Restaurants r
ON m.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY total_revenue DESC;

-- Average rating by restaurant
SELECT r.restaurant_id,
       r.name AS restaurant_name,
       AVG(rv.rating) AS average_rating,
       COUNT(rv.review_id) AS total_reviews
FROM Restaurants r
LEFT JOIN Reviews rv
ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY average_rating DESC;

-- Most active customers by number of orders
SELECT u.user_id,
       u.name AS customer_name,
       COUNT(o.order_id) AS total_orders
FROM Users u
JOIN Orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY total_orders DESC;

-- Customers with total spending
SELECT u.user_id,
       u.name AS customer_name,
       SUM(o.total_price) AS total_spent
FROM Users u
JOIN Orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY total_spent DESC;

-- Customers who spent more than average order total
SELECT u.user_id,
       u.name AS customer_name,
       SUM(o.total_price) AS total_spent
FROM Users u
JOIN Orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
HAVING SUM(o.total_price) > (
    SELECT AVG(total_price)
    FROM Orders
);

-- Restaurants with above-average rating
SELECT r.restaurant_id,
       r.name AS restaurant_name,
       AVG(rv.rating) AS average_rating
FROM Restaurants r
JOIN Reviews rv
ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.name
HAVING AVG(rv.rating) > (
    SELECT AVG(rating)
    FROM Reviews
);

-- Orders with promotion details
SELECT o.order_id,
       u.name AS customer_name,
       o.total_price,
       p.code AS promotion_code,
       p.discount_type,
       p.discount_value
FROM Orders o
JOIN Users u
ON o.user_id = u.user_id
LEFT JOIN Promotions p
ON o.promotion_id = p.promotion_id;

-- Number of orders using promotions
SELECT COUNT(*) AS orders_using_promotions
FROM Orders
WHERE promotion_id IS NOT NULL;

-- Delivery performance report
SELECT dp.delivery_person_id,
       dp.name AS delivery_person,
       COUNT(d.delivery_id) AS total_deliveries,
       AVG(dp.rating) AS rating
FROM Delivery_Personnel dp
LEFT JOIN Deliveries d
ON dp.delivery_person_id = d.delivery_person_id
GROUP BY dp.delivery_person_id, dp.name
ORDER BY total_deliveries DESC;

-- Orders with delivery and payment status
SELECT o.order_id,
       u.name AS customer_name,
       o.status AS order_status,
       p.status AS payment_status,
       d.status AS delivery_status
FROM Orders o
JOIN Users u
ON o.user_id = u.user_id
LEFT JOIN Payments p
ON o.order_id = p.order_id
LEFT JOIN Deliveries d
ON o.order_id = d.order_id;

-- Daily sales summary
SELECT DATE(p.created_at) AS sale_date,
       COUNT(p.payment_id) AS total_payments,
       SUM(p.amount) AS total_sales
FROM Payments p
WHERE p.status = 'paid'
GROUP BY DATE(p.created_at)
ORDER BY sale_date;

-- Monthly sales summary
SELECT YEAR(p.created_at) AS sale_year,
       MONTH(p.created_at) AS sale_month,
       COUNT(p.payment_id) AS total_payments,
       SUM(p.amount) AS monthly_sales
FROM Payments p
WHERE p.status = 'paid'
GROUP BY YEAR(p.created_at), MONTH(p.created_at)
ORDER BY sale_year, sale_month;

-- Menu items priced above average
SELECT item_id,
       name,
       price
FROM Menu_Items
WHERE price > (
    SELECT AVG(price)
    FROM Menu_Items
);

-- Restaurants with no reviews
SELECT r.restaurant_id,
       r.name AS restaurant_name
FROM Restaurants r
LEFT JOIN Reviews rv
ON r.restaurant_id = rv.restaurant_id
WHERE rv.review_id IS NULL;

-- Users with unread notifications
SELECT u.user_id,
       u.name AS customer_name,
       COUNT(n.notification_id) AS unread_notifications
FROM Users u
JOIN Notifications n
ON u.user_id = n.user_id
WHERE n.is_read = FALSE
GROUP BY u.user_id, u.name;

-- Full order report
SELECT o.order_id,
       u.name AS customer_name,
       r.name AS restaurant_name,
       m.name AS item_name,
       oi.quantity,
       oi.price,
       p.payment_method,
       p.status AS payment_status,
       d.status AS delivery_status
FROM Orders o
JOIN Users u
ON o.user_id = u.user_id
JOIN Order_Items oi
ON o.order_id = oi.order_id
JOIN Menu_Items m
ON oi.item_id = m.item_id
JOIN Restaurants r
ON m.restaurant_id = r.restaurant_id
LEFT JOIN Payments p
ON o.order_id = p.order_id
LEFT JOIN Deliveries d
ON o.order_id = d.order_id
ORDER BY o.order_id;