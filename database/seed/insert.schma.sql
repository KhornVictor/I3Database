use nomnom;
-- USERS
INSERT INTO Users (name, email, password, phone, address, avatar, role) VALUES
('Samnang Hour', 'samnang@email.com', 'pass123', '012345678', 'Phnom Penh', 'avatar1.png', 'admin'),
('Victor Khorn', 'victor@email.com', 'pass123', '011222333', 'Phnom Penh', 'avatar2.png', 'admin'),
('John Doe', 'John@email.com', 'pass123', '015444555', 'Toul Kork', 'avatar3.png', 'customer'),
('Jane Doe', 'Jane@email.com', 'pass123', '010000000', 'Phnom Penh', 'avatar4.png', 'customer');

-- RESTAURANTS
INSERT INTO Restaurants (name, description, phone, latitude, longitude, address, image_url) VALUES
('Hel Corner', 'Papaya Salad restaurant', '023111222', 11.55640000, 104.92820000, 'BKK1, Phnom Penh', 'hel_corner.jpg'),
('Koi the', 'Milk tea restaurant', '023333444', 11.56210000, 104.91600000, 'Toul Kork, Phnom Penh', 'koi_the.jpg'),
('Khmer Taste', 'Local Khmer food', '023555666', 11.57000000, 104.90000000, 'Russian Market, Phnom Penh', 'khmer_taste.jpg');

-- CATEGORIES
INSERT INTO Categories (name, image_url) VALUES
('Papaya Salad', 'papaya_salad.png'),
('Pizza', 'pizza.png'),
('Drink', 'drink.png'),
('Rice', 'rice.png'),
('Dessert', 'dessert.png');

-- PROMOTIONS
INSERT INTO Promotions 
(code, title, description, discount_type, discount_value, min_order_amount, max_discount_amount, start_date, end_date, is_active)
VALUES
('WELCOME10', 'Welcome Discount', '10 percent off for new users', 'percentage', 10.00, 5.00, 3.00, '2026-05-01 00:00:00', '2026-06-30 23:59:59', TRUE),
('NomNom', 'Five Dollar Discount', 'Fixed 5 dollar discount', 'fixed', 5.00, 20.00, 5.00, '2026-05-01 00:00:00', '2026-06-30 23:59:59', TRUE);

-- MENU ITEMS
INSERT INTO Menu_Items (restaurant_id, category_id, name, description, price, image_url, is_available) VALUES
(1, 1, 'Classic Papaya Salad', 'Spicy papaya salad', 3.00, 'papaya_salad.jpg', TRUE),
(1, 3, 'Iced Tea', 'Cold iced tea', 1.25, 'iced_tea.jpg', TRUE),
(1, 4, 'Fried Rice', 'Fried rice with egg', 3.50, 'fried_rice.jpg', TRUE),

(2, 3, 'Milk Tea', 'Classic milk tea', 2.00, 'milk_tea.jpg', TRUE),
(2, 3, 'Brown Sugar Milk Tea', 'Brown sugar drink', 2.50, 'brown_sugar.jpg', TRUE),
(2, 5, 'Cheese Cake', 'Small dessert cake', 3.00, 'cheese_cake.jpg', TRUE),

(3, 4, 'Bai Sach Chrouk', 'Pork rice', 2.50, 'bai_sach_chrouk.jpg', TRUE),
(3, 4, 'Chicken Rice', 'Rice with chicken', 3.00, 'chicken_rice.jpg', TRUE),
(3, 3, 'Sugar Cane Juice', 'Fresh sugar cane juice', 1.00, 'sugar_cane.jpg', TRUE);

-- CARTS
INSERT INTO Carts (user_id) VALUES
(3),
(4);

-- CART ITEMS
INSERT INTO Cart_Items (cart_id, item_id, quantity, price) VALUES
(1, 1, 2, 3.00),
(1, 2, 1, 1.25),
(2, 4, 2, 2.00),
(2, 6, 1, 3.00);

-- ORDERS
INSERT INTO Orders (user_id, promotion_id, total_price, status) VALUES
(3, 1, 7.25, 'confirmed'),
(4, NULL, 7.00, 'preparing'),
(3, 2, 5.00, 'delivered');

-- ORDER ITEMS
INSERT INTO Order_Items (order_id, item_id, quantity, price) VALUES
(1, 1, 2, 3.00),
(1, 2, 1, 1.25),
(2, 4, 2, 2.00),
(2, 6, 1, 3.00),
(3, 7, 2, 2.50);

-- PAYMENTS
INSERT INTO Payments (order_id, amount, payment_method, status) VALUES
(1, 7.25, 'online', 'paid'),
(2, 7.00, 'card', 'pending'),
(3, 5.00, 'cash', 'paid');

-- REVIEWS
INSERT INTO Reviews (user_id, restaurant_id, rating, comment) VALUES
(3, 1, 5, 'Good papaya salad'),
(4, 2, 4, 'Milk tea tasted good'),
(3, 3, 5, 'Nice Khmer food');

-- DELIVERY PERSONNEL
INSERT INTO Delivery_Personnel 
(name, phone, vehicle_type, current_location, current_latitude, current_longitude, status, rating)
VALUES
('Dara Sok', '096111222', 'motorbike', 'BKK1', 11.55640000, 104.92820000, 'available', 4.8),
('Rithy Chan', '097333444', 'motorbike', 'Toul Kork', 11.56210000, 104.91600000, 'busy', 4.5),
('Sopheak Kim', '098555666', 'motorbike', 'Russian Market', 11.57000000, 104.90000000, 'available', 4.7);

-- DELIVERIES
INSERT INTO Deliveries 
(order_id, delivery_person_id, pickup_location, delivery_location, estimated_arrival, actual_arrival, status)
VALUES
(1, 1, 'Hel Corner', 'Toul Kork, Phnom Penh', '2026-05-24 12:30:00', NULL, 'delivering'),
(2, 2, 'Koi the', 'Phnom Penh', '2026-05-24 13:00:00', NULL, 'assigned'),
(3, 3, 'Khmer Taste', 'Toul Kork', '2026-05-23 18:30:00', '2026-05-23 18:25:00', 'delivered');

-- ORDER STATUS HISTORY
INSERT INTO Order_Status_History (order_id, delivery_person_id, status, notes) VALUES
(1, 1, 'confirmed', 'Order confirmed by restaurant'),
(1, 1, 'out_for_delivery', 'Driver is delivering the order'),
(2, 2, 'preparing', 'Restaurant is preparing the food'),
(3, 3, 'delivered', 'Order delivered successfully');

-- NOTIFICATIONS
INSERT INTO Notifications (user_id, order_id, type, title, message, is_read, read_at) VALUES
(3, 1, 'order', 'Order Confirmed', 'Your order has been confirmed.', FALSE, NULL),
(3, 1, 'delivery', 'Order on the Way', 'Your order is being delivered.', FALSE, NULL),
(4, 2, 'order', 'Order Preparing', 'Your food is being prepared.', TRUE, '2026-05-24 12:10:00'),
(3, 3, 'delivery', 'Order Delivered', 'Your order has been delivered.', TRUE, '2026-05-23 18:30:00'),
(4, NULL, 'promotion', 'New Promotion', 'Use WELCOME10 for discount.', FALSE, NULL);