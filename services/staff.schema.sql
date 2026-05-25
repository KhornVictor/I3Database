use nomnom;
-- View all pending orders
SELECT o.order_id,
       u.name AS customer_name,
       o.total_price,
       o.status,
       o.created_at
FROM Orders o
JOIN Users u
ON o.user_id = u.user_id
WHERE o.status = 'pending'; 

-- View all orders with customer and payment status
SELECT o.order_id,
       u.name AS customer_name,
       o.total_price,
       o.status AS order_status,
       p.payment_method,
       p.status AS payment_status
FROM Orders o
JOIN Users u
ON o.user_id = u.user_id
LEFT JOIN Payments p
ON o.order_id = p.order_id;

-- View order details for staff
SELECT o.order_id,
       u.name AS customer_name,
       r.name AS restaurant_name,
       m.name AS item_name,
       oi.quantity,
       oi.price,
       o.status
FROM Orders o
JOIN Users u
ON o.user_id = u.user_id
JOIN Order_Items oi
ON o.order_id = oi.order_id
JOIN Menu_Items m
ON oi.item_id = m.item_id
JOIN Restaurants r
ON m.restaurant_id = r.restaurant_id
ORDER BY o.order_id;

-- View all delivery assignments
SELECT d.delivery_id,
       o.order_id,
       dp.name AS delivery_person,
       d.pickup_location,
       d.delivery_location,
       d.status,
       d.estimated_arrival
FROM Deliveries d
JOIN Orders o
ON d.order_id = o.order_id
JOIN Delivery_Personnel dp
ON d.delivery_person_id = dp.delivery_person_id;

-- View available delivery personnel
SELECT delivery_person_id,
       name,
       phone,
       vehicle_type,
       current_location,
       rating
FROM Delivery_Personnel
WHERE status = 'available';

-- Update order status
UPDATE Orders
SET status = 'preparing'
WHERE order_id = 1;
-- (check result)
SELECT order_id,
       status
FROM Orders
WHERE order_id = 1;

-- Insert order status history
INSERT INTO Order_Status_History (order_id, delivery_person_id, status, notes)
VALUES (1, 1, 'preparing', 'Restaurant started preparing the order');

-- Assign delivery person to an order
-- (insert new order)
INSERT INTO Orders (
    user_id,
    promotion_id,
    total_price,
    status
)
VALUES (
    3,
    NULL,
    12.00,
    'pending'
);
-- assign new person
INSERT INTO Deliveries (
    order_id,
    delivery_person_id,
    pickup_location,
    delivery_location,
    estimated_arrival,
    status
)
VALUES (
    4,
    1,
    'Pizza Town',
    'Phnom Penh',
    '2026-05-24 14:00:00',
    'assigned'
);
-- (check result)
SELECT order_id,
       status
FROM Deliveries;

-- Update delivery status
UPDATE Deliveries
SET status = 'delivering'
WHERE delivery_id = 1;
-- (check result)
SELECT *
FROM Order_Status_History
WHERE order_id = 1;

-- Update delivery person status
UPDATE Delivery_Personnel
SET status = 'busy'
WHERE delivery_person_id = 1;
-- check result
SELECT delivery_person_id,
       name,
       status
FROM Delivery_Personnel
WHERE delivery_person_id = 1;

-- View active promotions
SELECT promotion_id,
       code,
       title,
       discount_type,
       discount_value,
       start_date,
       end_date
FROM Promotions
WHERE is_active = TRUE
AND CURRENT_TIMESTAMP BETWEEN start_date AND end_date;

-- Disable expired promotions (doesnt work cuz of safe update mode)
SET SQL_SAFE_UPDATES = 0;
UPDATE Promotions
SET is_active = FALSE
WHERE end_date < CURRENT_TIMESTAMP;
SET SQL_SAFE_UPDATES = 1;
-- check result
SELECT promotion_id,
       code,
       is_active,
       end_date
FROM Promotions;
-- change one promotion to test query
UPDATE Promotions
SET start_date = '2024-01-01 00:00:00',
    end_date = '2025-01-01 00:00:00'
WHERE promotion_id = 1;

-- View unavailable menu items
SELECT m.item_id,
       m.name AS item_name,
       r.name AS restaurant_name
FROM Menu_Items m
JOIN Restaurants r
ON m.restaurant_id = r.restaurant_id
WHERE m.is_available = FALSE;

--  Update menu item availability (to test the query above)
UPDATE Menu_Items
SET is_available = FALSE
WHERE item_id = 1;

-- View all unread notifications by user
SELECT u.name AS customer_name,
       n.title,
       n.message,
       n.created_at
FROM Notifications n
JOIN Users u
ON n.user_id = u.user_id
WHERE n.is_read = FALSE
ORDER BY n.created_at DESC;