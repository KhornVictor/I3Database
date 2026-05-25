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

-- more insertion :) (from json of NomNom)
-- Extra Users
INSERT INTO Users
(user_id, name, email, password, phone, address, avatar, role, created_at)
VALUES
(5, 'William Miller', 'william.miller@example.com', '123456', '+1-202-555-0105', '654 Birch Blvd, Phoenix, AZ', 'avatar5.jpg', 'customer', '2026-03-05 16:45:00'),
(6, 'Sophia Wilson', 'sophia.wilson@example.com', '123456', '+1-202-555-0106', '987 Spruce Street, Philadelphia, PA', 'avatar6.jpg', 'customer', '2026-03-06 12:10:00'),
(7, 'James Moore', 'james.moore@example.com', '123456', '+1-202-555-0107', '147 Elm Street, San Antonio, TX', 'avatar7.jpg', 'admin', '2026-03-07 08:55:00'),
(8, 'Isabella Taylor', 'isabella.taylor@example.com', '123456', '+1-202-555-0108', '258 Walnut Avenue, San Diego, CA', 'avatar8.jpg', 'customer', '2026-03-08 13:25:00'),
(9, 'Benjamin Anderson', 'ben.anderson@example.com', '123456', '+1-202-555-0109', '369 Chestnut Drive, Dallas, TX', 'avatar9.jpg', 'customer', '2026-03-09 15:40:00'),
(10, 'Mia Thomas', 'mia.thomas@example.com', '123456', '+1-202-555-0110', '159 Poplar Court, San Jose, CA', 'avatar10.jpg', 'customer', '2026-03-10 17:50:00'),
(11, 'John Smith', 'john.smith@example.com', '123456', '+1-202-555-0112', '123 Maple Street, New York, NY', 'avatar11.jpg', 'customer', '2026-03-01 10:15:00'),
(12, 'Lisa Chan', 'lisa@example.com', '123456', '+855-12-345-678', 'BKK1, Phnom Penh', 'avatar12.jpg', 'customer', '2026-03-11 10:00:00'),
(13, 'David Kim', 'david@example.com', '123456', '+855-98-222-333', 'Toul Kork, Phnom Penh', 'avatar13.jpg', 'customer', '2026-03-11 11:00:00'),
(14, 'Anna Lee', 'anna@example.com', '123456', '+855-97-444-555', 'Chroy Changvar, Phnom Penh', 'avatar14.jpg', 'customer', '2026-03-11 12:00:00'),
(15, 'Chris Wong', 'chris@example.com', '123456', '+855-96-111-222', 'Sen Sok, Phnom Penh', 'avatar15.jpg', 'customer', '2026-03-11 13:00:00');

-- EXTRA PROMOTIONS
INSERT INTO Promotions
(promotion_id, code, title, description, discount_type, discount_value, min_order_amount, max_discount_amount, start_date, end_date, is_active)
VALUES
(3, 'FOOD20', 'Food Discount', '20 percent off selected orders', 'percentage', 20.00, 10.00, 5.00, '2026-05-01 00:00:00', '2026-07-01 23:59:59', TRUE),
(4, 'DRINK5', 'Drink Discount', 'Fixed discount for drinks', 'fixed', 2.00, 5.00, 2.00, '2026-05-01 00:00:00', '2026-07-01 23:59:59', TRUE),
(5, 'BIGMEAL', 'Big Meal Promo', 'Discount for large orders', 'percentage', 15.00, 25.00, 6.00, '2026-05-01 00:00:00', '2026-08-01 23:59:59', TRUE);

-- EXTRA DELIVERY PERSONNEL
INSERT INTO Delivery_Personnel
(delivery_person_id, name, phone, vehicle_type, current_location, current_latitude, current_longitude, status, rating)
VALUES
(4, 'Vireak Long', '096222333', 'motorbike', 'Phnom Penh', 11.55640000, 104.92820000, 'available', 4.6),
(5, 'Sokha Lim', '097444555', 'motorbike', 'Toul Kork', 11.56210000, 104.91600000, 'busy', 4.4),
(6, 'Nita Chan', '098666777', 'motorbike', 'BKK1', 11.55000000, 104.92000000, 'available', 4.9),
(7, 'Davin Roeun', '099888999', 'motorbike', 'Russian Market', 11.54500000, 104.91000000, 'offline', 4.1);

-- EXTRA ORDERS 
INSERT INTO Orders
(order_id, user_id, promotion_id, total_price, status)
VALUES
(5, 5, 3, 18.50, 'confirmed'),
(6, 6, NULL, 12.75, 'preparing'),
(7, 8, 4, 6.00, 'delivered'),
(8, 9, NULL, 21.50, 'out_for_delivery'),
(9, 10, 5, 30.00, 'confirmed'),
(10, 12, NULL, 9.99, 'cancelled');

-- EXTRA ORDER ITEMS 
INSERT INTO Order_Items
(order_item_id, order_id, item_id, quantity, price)
VALUES
(7, 5, 3, 1, 12.00),
(8, 5, 21, 2, 2.50),
(9, 6, 5, 1, 9.99),
(10, 6, 23, 1, 2.75),
(11, 7, 25, 2, 3.00),
(12, 8, 18, 1, 12.00),
(13, 8, 29, 2, 3.00),
(14, 9, 64, 2, 12.99),
(15, 9, 88, 1, 3.50),
(16, 10, 6, 1, 9.99);

-- EXTRA PAYMENTS 
INSERT INTO Payments
(payment_id, order_id, amount, payment_method, status)
VALUES
(5, 5, 18.50, 'online', 'paid'),
(6, 6, 12.75, 'card', 'pending'),
(7, 7, 6.00, 'cash', 'paid'),
(8, 8, 21.50, 'online', 'paid'),
(9, 9, 30.00, 'card', 'paid'),
(10, 10, 9.99, 'online', 'failed');

-- EXTRA DELIVERIES 
INSERT INTO Deliveries
(delivery_id, order_id, delivery_person_id, pickup_location, delivery_location, estimated_arrival, actual_arrival, status)
VALUES
(8, 5, 4, 'Pasta Corner', 'Phoenix, AZ', '2026-05-25 12:30:00', NULL, 'assigned'),
(9, 6, 5, 'Brown Coffee', 'Philadelphia, PA', '2026-05-25 13:00:00', NULL, 'picked_up'),
(10, 7, 6, 'Starbucks', 'San Diego, CA', '2026-05-24 11:30:00', '2026-05-24 11:25:00', 'delivered'),
(11, 8, 5, 'Pizza Hut', 'Dallas, TX', '2026-05-25 14:00:00', NULL, 'delivering'),
(12, 9, 4, 'DQ', 'San Jose, CA', '2026-05-25 15:00:00', NULL, 'assigned');

-- EXTRA ORDER STATUS HISTORY 
-- INSERT IGNORE INTO Order_Status_History
-- (status_history_id, order_id, delivery_person_id, status, notes)
-- VALUES
-- (6, 5, 4, 'preparing', 'Restaurant is preparing the order'),
-- (7, 6, 5, 'preparing', 'Food is being prepared'),
-- (8, 7, 6, 'delivered', 'Order delivered successfully'),
-- (9, 8, 5, 'out_for_delivery', 'Driver is on the way'),
-- (10, 9, 4, 'confirmed', 'Order confirmed'),
-- (11, 10, 4, 'cancelled', 'Order cancelled by customer');

-- EXTRA REVIEWS
INSERT INTO Reviews
(review_id, user_id, restaurant_id, rating, comment)
VALUES
(11, 5, 6, 4, 'Good burger and quick service.'),
(12, 6, 3, 5, 'Coffee was fresh and tasty.'),
(13, 8, 8, 4, 'Dessert was nice.'),
(14, 9, 8, 5, 'Pizza was very good.'),
(15, 10, 7, 5, 'Milk tea was amazing.');

-- EXTRA NOTIFICATIONS
INSERT INTO Notifications
(notification_id, user_id, order_id, type, title, message, is_read, read_at)
VALUES
(6, 5, 5, 'order', 'Order Confirmed', 'Your order has been confirmed.', FALSE, NULL),
(7, 6, 6, 'order', 'Food Preparing', 'The restaurant is preparing your food.', FALSE, NULL),
(8, 8, 7, 'delivery', 'Order Delivered', 'Your order has been delivered.', TRUE, '2026-05-24 11:30:00'),
(9, 9, 8, 'delivery', 'Out for Delivery', 'Your food is on the way.', FALSE, NULL),
(10, 10, 9, 'promotion', 'Promotion Applied', 'Your promotion was applied successfully.', TRUE, '2026-05-25 10:20:00'),
(11, 12, 10, 'order', 'Order Cancelled', 'Your order was cancelled.', FALSE, NULL),
(12, 5, NULL, 'promotion', 'New Discount', 'Use FOOD20 for 20 percent off.', FALSE, NULL),
(13, 6, NULL, 'system', 'New Restaurant', 'A new restaurant is available near you.', FALSE, NULL);

-- EXTRA RESTAURANTS
INSERT INTO Restaurants
(restaurant_id, name, description, phone, latitude, longitude, address, image_url)
VALUES
(4, 'KFC', 'Fast food restaurant', '012111111', 11.5564, 104.9282, 'Phnom Penh', 'kfc.jpg'),
(5, 'Starbucks', 'Coffee and drinks', '012222222', 11.5600, 104.9200, 'Phnom Penh', 'starbucks.jpg'),
(6, 'Burger King', 'Burger restaurant', '012333333', 11.5500, 104.9100, 'Phnom Penh', 'bk.jpg'),
(7, 'Pizza Hut', 'Pizza restaurant', '012444444', 11.5700, 104.9300, 'Phnom Penh', 'pizza.jpg'),
(8, 'Brown Coffee', 'Coffee shop', '012555555', 11.5800, 104.9400, 'Phnom Penh', 'brown.jpg');

-- INSERT INTO Menu_Items (restaurant_id, category_id, name, description, price, image_url, is_available) VALUES
-- (1, 7, 'Grilled Chicken Plate', 'Juicy grilled chicken served with steamed vegetables and mashed potatoes.', 14.99, 'https://media.istockphoto.com/id/928823336/photo/grilled-chicken-breast-fried-chicken-fillet-and-fresh-vegetable-salad-of-tomatoes-cucumbers.jpg?s=612x612&w=0&k=20&c=x6KbcglhT_oxKEzCoSM5E8abP3rlEZAt7jQhlAPZtoY=', 1),
-- (1, 7, 'BBQ Beef Ribs', 'Slow-cooked beef ribs glazed with smoky barbecue sauce.', 19.5, 'https://www.tasteofhome.com/wp-content/uploads/2017/09/exps39535_CW163683D03_31_2b-.jpg', 1),
-- (2, 8, 'Margherita Pizza', 'Classic pizza with fresh mozzarella, tomato sauce, and basil.', 12, 'https://uk.ooni.com/cdn/shop/articles/20220211142645-margherita-9920_e41233d5-dcec-461c-b07e-03245f031dfe.jpg?crop=center&height=800&v=1737105431&width=800', 1),
-- (2, 8, 'Fettuccine Alfredo', 'Creamy Alfredo sauce tossed with fettuccine pasta and parmesan.', 13.75, 'https://www.modernhoney.com/wp-content/uploads/2018/08/Fettuccine-Alfredo-Recipe-1.jpg', 1),
-- (3, 4, 'Salmon Sushi Roll', 'Fresh salmon roll with avocado and cucumber.', 9.99, 'https://timskitchen.com.hk/wp-content/uploads/2025/02/smoked-salmon-sushi-roll-recipe-1739410610.jpg', 1),
-- (3, 9, 'Spicy Ramen', 'Rich pork broth ramen with chili oil and soft-boiled egg.', 11.5, 'https://www.spoonforkbacon.com/wp-content/uploads/2024/04/spicy-ramen-noodles-recipe-card.jpg', 0),
-- (4, 6, 'Butter Chicken', 'Tender chicken in creamy tomato-based curry sauce.', 15.25, 'https://majasrecipes.com/wp-content/uploads/2024/12/butter-chicken-recipe-5.jpg', 0),
-- (4, 6, 'Garlic Naan', 'Traditional Indian flatbread topped with garlic and butter.', 3.5, 'https://hostthetoast.com/wp-content/uploads/2018/08/Homemade-Garlic-Naan-3.jpg', 0),
-- (5, 5, 'Beef Tacos', 'Three soft tacos filled with seasoned beef and fresh salsa.', 10.75, 'https://www.onceuponachef.com/images/2023/08/Beef-Tacos.jpg', 1),
-- (5, 5, 'Chicken Quesadilla', 'Grilled tortilla stuffed with chicken and melted cheese.', 11.25, 'https://www.julieseatsandtreats.com/wp-content/uploads/2024/10/Chicken-Quesadilla-Square.jpg', 1),
-- (1, 7, 'Fish Amok', 'Traditional Cambodian curry made with fish, coconut milk, and kroeung spices.', 8.5, 'https://grantourismotravels.com/wp-content/uploads/2017/05/Authentic-Fish-Amok-Recipe-Steamed-Fish-Curry-Cambodia-Copyright-2022-Terence-Carter-Grantourismo-T.jpg', 1),
-- (1, 7, 'Beef Lok Lak', 'Stir-fried beef with soy sauce and lime served with rice and fresh vegetables.', 9, 'https://www.simplyrecipes.com/thmb/zb1rbkgxDQT3SfEPZiKncciphp8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Lok-Lak-Mustard-LEAD-05-a0d8c2c5cd064e9c8c31af93a81b51f0.jpg', 1),
-- (2, 7, 'Khmer Red Curry', 'Mild coconut-based curry with chicken, potatoes, and carrots.', 8.25, 'https://xa6zemg4r8.cloudimg.io/_images_/g/62180f05ef54ddc19095525f.jpg', 1),
-- (2, 7, 'Nom Banh Chok', 'Traditional Cambodian breakfast noodle dish with fish gravy and fresh herbs.', 6.5, 'https://grantourismotravels.com/wp-content/uploads/2020/02/Nom-Banh-Chok-Cambodian-Fermented-Rice-Noodles-Copyright-2022-Terence-Carter-Grantourismo-F.jpg', 0),
-- (3, 7, 'Grilled Lemongrass Chicken', 'Tender chicken marinated in lemongrass and spices, grilled to perfection.', 7.5, 'https://hot-thai-kitchen.com/wp-content/uploads/2022/01/lemongrass-chicken-blog.jpg', 1),
-- (3, 7, 'Khmer Beef Skewers', 'Spiced beef skewers served with dipping sauce and rice.', 8, 'https://www.seriouseats.com/thmb/G5C2-Pr4m6ET_yEn7GumPe6H0WA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__images__2015__06__20150530-shao-z-beef-skewers-4-be3e8f2aa59d40a9ab4f4c8b6e110bfb.jpg', 1),
-- (4, 7, 'Stir-Fried Morning Glory', 'Popular Cambodian vegetable dish stir-fried with garlic and soy sauce.', 5.5, 'https://beyondsweetandsavory.com/wp-content/uploads/2023/08/Vietnamese-stir-fried-morning-glory-with-garlic-VyTran-4.jpg', 1),
-- (4, 7, 'Grilled Fish with Tamarind Sauce', 'Whole grilled fish topped with tangy tamarind sauce.', 12, 'https://static01.nyt.com/images/2024/10/10/multimedia/ZS-Baked-Fish-iTamarind-Saucerex-vmzl/ZS-Baked-Fish-iTamarind-Saucerex-vmzl-threeByTwoMediumAt2X.jpg', 1),
-- (5, 7, 'Khmer Chicken Soup (Samlor Machu)', 'Sour and aromatic Cambodian soup with chicken, tamarind, and herbs.', 7.75, 'https://angkorchef.com/wp-content/uploads/2019/12/Somlaw-Machu-Kroeung-on-Table.jpg', 1),
-- (5, 7, 'Prahok Ktis', 'Traditional Cambodian dip made with fermented fish, coconut milk, and spices.', 6.75, 'https://angkorchef.com/wp-content/uploads/2020/04/IMG_8444-web.jpeg', 1),
-- (1, 2, 'Iced Coffee', 'Sweet Cambodian-style iced coffee with condensed milk.', 2.5, 'https://www.eatingbirdfood.com/wp-content/uploads/2025/06/iced-coffee-hero-new.jpg', 1),
-- (1, 2, 'Lemongrass Tea', 'Refreshing herbal tea made from fresh lemongrass.', 2, 'https://goodlfe.com/cdn/shop/articles/20241001192423-lfe-20recipe-20cover-20images-20-7.png?v=1729011813&width=800', 1),
-- (2, 6, 'Sugarcane Juice', 'Freshly pressed sugarcane juice served chilled.', 2.75, 'https://freshggies.in/cdn/shop/files/Sugar_Cane_Juice_FRDJ010_d3dd62bb-be82-4106-abaa-b777dab4241c.jpg?v=1745379748', 1),
-- (2, 6, 'Tamarind Juice', 'Tangy and sweet tamarind juice, a popular Cambodian drink.', 2.5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjMkfuqeORtscJW_kaB7UfB2ftCeC_zG3vAw&s', 1),
-- (3, 6, 'Coconut Water', 'Fresh coconut water served directly from the coconut.', 3, 'https://health.osu.edu/-/media/health/images/stories/2024/09/coconut-water-sm.jpg', 1),
-- (3, 6, 'Pineapple Smoothie', 'Creamy smoothie made with fresh pineapple and ice.', 3.5, 'https://www.purelykaylie.com/wp-content/uploads/2021/07/pineapple-coconut-smoothie-1.jpg', 1),
-- (4, 6, 'Mango Shake', 'Refreshing shake made from ripe mangoes and ice.', 3.25, 'https://tastyoven.com/wp-content/uploads/2022/06/mango-shake-image.jpeg', 1),
-- (4, 6, 'Iced Lemongrass Coffee', 'Fusion of iced coffee with subtle lemongrass flavor.', 2.75, 'https://imbibemagazine.com/wp-content/uploads/2022/07/nam-coffee-cold-brew-lemongrass-orange-orange-county.jpg', 1),
-- (5, 6, 'Passion Fruit Juice', 'Freshly squeezed passion fruit juice served chilled.', 3, 'https://www.savoringthegood.com/wp-content/uploads/2024/09/1200-x-1200-with-crops-copy-2-2-1.jpg', 1),
-- (5, 6, 'Herbal Infusion', 'A calming blend of local herbs served hot.', 2.5, 'https://cdn.shopify.com/s/files/1/0334/3931/8155/files/1_18ec8b3c-8279-4fca-a981-446982949eab.jpg?v=1738752201', 1),
-- (11, 6, 'Hotpot', 'ហឹរហោះលើវេហា​ ❤.', 2.5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2KR2Z-kVHzmiXkQxNACl6kCsCp08r8Hry7w&s', 1),
-- (12, 2, 'Iced Caramel Latte', 'Iced Caramel Latte is a fresh milk coffee with a sweet, light level of coffee, and the aroma of caramel, and fresh milk', 2.8, 'https://tubecafecambodia.com/wp-content/uploads/2025/01/Latte-1-683x1024-1.png', 1),
-- (12, 2, 'Iced Americano', 'Iced Americano is a black coffee with a strong coffee flavor and the aroma of coffee', 2.07, 'https://images.deliveryhero.io/image/menu-import-gateway-prd/regions/AS/chains/MONAKOM_KH_ProdChain/9ea606bb87f4d74972e8136bd09b6b29.jpg?width=%s', 1),
-- (12, 2, 'Coconut Cream Latte', 'Coconut Cream Latte is a creamy coffee with fresh coconut water a sweet taste, light level of coffee, and the aroma of coconut', 2.5, 'https://images.deliveryhero.io/image/menu-import-gateway-prd/regions/AS/chains/MONAKOM_KH_ProdChain/a8f96b4f319d1c6dc3b7150d5c094e41.jpg?width=%s', 1),
-- (12, 2, 'Iced Latte', 'Iced Latte is a fresh milk coffee with a light, creamy cofffee flavor, and the aroma of coffee and fresh milk', 2.43, 'https://tubecafecambodia.com/wp-content/uploads/2025/01/Latte-1-683x1024-1.png', 1),
-- (13, 2, 'Uji Matcha Latte', 'Smooth matcha, blended with fresh milk for a smooth, calming treat', 2.3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ-7T3QcnUheVlgylM_m3F0AiWDdiwEHFrYA&s', 1),
-- (13, 2, 'Passion Green Tea', 'Refreshing jasmine green tea infused with vibrant passion fruit.', 1.9, 'data:image/jpeg;base64,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', 1),
-- (13, 2, 'Milk Tea', 'Classic milk tea brewed using premium Assam -black tea.', 1.9, 'https://koithebd.com/wp-content/uploads/2025/02/Milk-Tea%E5%A5%B6%E8%8C%B6-640x800.webp', 1),
-- (13, 2, 'Golden Bubble Milk Tea', 'Our classic milk tea with chewy golden bubbles.', 2, 'https://koithebd.com/wp-content/uploads/2025/01/Golden-Bubble-Milk-Tea.webp', 1),
-- (13, 2, 'Jumbo Milk Tea', 'Our classic milk tea with soft, chewy jumbo pearls.', 2.3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbRDncynKiJA7JLzx2tgu9yKwYO-cPq-eSZw&s', 1),
-- (13, 2, 'Grass Jelly Milk Tea', 'Our classic milk tea with delicious grass jelly for a healthy beverage.', 2.3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8_AfQ7i3aYHR8uFoE-SU0B9x5Y6Pktc6hSg&s', 1),
-- (13, 2, 'Black Sesame Milk Tea Macchiato', 'Roasted black sesame with milk tea, topped with smooth macchiato cream, offering a rich and comforting taste.', 2.3, 'https://www.koithe.com/en/images/drink-4.png', 1),
-- (13, 2, 'Brown Sugar Milk Tea', 'A delicious blend of classic milk tea and brown sugar.', 2, 'https://www.koithe.com/en/images/drink-6.png', 1),
-- (13, 2, 'Taro Purple Milk Tea', 'A delightful blend of taro and milk tea.', 2, 'https://www.koithe.com/en/images/drink-5.png', 1),
-- (13, 2, 'Juice', 'A refreshing blend of tropical fruits and herbs.', 2.5, 'https://www.koithe.com/en/images/drink-2.png', 1),
-- (13, 2, 'Dark Lava Ovaltine', 'Malty Ovaltine in a crisp chocolate crust.', 2.2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRDeTPiDNXU1izfJ2QcC4bwExANpI6yY1xNQ&s', 1),
-- (13, 2, 'Passion Fruit Green Tea Macchiato', 'Tropical passion fruit combined with fragrant green tea, topped with velvety cream foam for a tangy and refreshing double delight.', 2.3, 'https://koithebd.com/wp-content/uploads/2025/01/Green-Tea-Macchiato-%E7%B6%A0%E8%8C%B6%E7%91%AA%E5%A5%87%E6%9C%B5-430x538.webp', 1),
-- (12, 2, 'Matcha Cream ', 'Matcha Cream has a sweet and creamy taste, balanced level of matcha, and the aroma of matcha and milk cream', 2.43, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcEhASHBnPJDxvRArPrf9yMs9vxxjNRvufFg&s', 1),
-- (12, 2, 'Wildberry Raspberry Tea', 'Described as a mixed berry tea with a balanced sweet and sour profile.', 2.5, 'https://tubecafecambodia.com/wp-content/uploads/2025/01/Wildberry-Raspberry-Tea-1-683x1024-1.png', 1),
-- (12, 2, 'Iced Thnol Coffee', 'Sweet, creamy, and robust with a rich aroma.', 2.5, 'https://tubecafecambodia.com/wp-content/uploads/2025/01/Thnol-Coffee-1-683x1024-1.png', 1),
-- (12, 2, 'Green Milk Tea', 'Green Milk Tea has a sweet taste, light level of coffee, and the aroma of green tea and milk.', 2.43, 'https://tubecafecambodia.com/wp-content/uploads/2025/01/Green-Milk-Tea-1-683x1024-1.png', 1),
-- (12, 2, 'Hot Americano', 'Hot Americano is a hot black coffee, strong level of coffee, and the aroma of cofffe', 2.07, 'https://img3.boatcdn.com/media/b0c21933-9029-5d72-972f-f95a1363c6e9', 1),
-- (12, 2, 'hot Matcha Latte', 'Hot Matcha Latte is a hot fresh milk matcha , balandced level of matcha, and the aroma of matcha and milk foam.', 2.43, 'https://images.deliveryhero.io/image/menu-import-gateway-prd/regions/AS/chains/MONAKOM_KH_ProdChain/4e376659a8e81c58b42e9baa8b7a1139.jpg?width=%s', 1),
-- (12, 2, 'Hot Latte', 'Hot Latte is a hot fresh milk coffee, light level of coffee, and the aroma of coffee and milk foam.', 2.43, 'https://img3.boatcdn.com/media/cb08b804-97b8-5634-9e09-1ec08b37a5b7', 1),
-- (12, 2, 'Espresso', 'Espresso is pure coffee, strong level of coffee and the aroma of coffee', 1.95, 'https://img3.boatcdn.com/media/b0c21933-9029-5d72-972f-f95a1363c6e9', 1),
-- (12, 2, 'Hot Cappuccino', 'Hot Cappuccino is hot milk foam coffee, balanced level of coffee, and the aroma of coffee and milk foam', 2.43, 'https://img3.boatcdn.com/media/cb08b804-97b8-5634-9e09-1ec08b37a5b7', 1),
-- (12, 2, 'Hot Thnol Coffee', 'Hot Thnol Coffee is a hot milk coffee and a Cambodian flavor, with a sweet taste, and unforgettable aroma', 2.43, 'https://img3.boatcdn.com/media/cb08b804-97b8-5634-9e09-1ec08b37a5b7', 1),
-- (12, 2, 'Hot Caramel Latte', 'Hot Caramel Latte is a hot fresh milk coffee with a sweet taste, light level of coffee, and the aroma of coffee carmel and milk foam', 2.8, 'https://img3.boatcdn.com/media/cb08b804-97b8-5634-9e09-1ec08b37a5b7', 1),
-- (12, 2, 'Hot Chocolate Milk', 'Hot Chocolate Milk has a sweet taste, and the aroma of chocolate and milk foam', 2.43, 'https://img3.boatcdn.com/media/cb08b804-97b8-5634-9e09-1ec08b37a5b7', 1),
-- (12, 2, 'Honey Yuzu Soda', 'Honey Yuzu Soda has a sweet and sour taste, and the aroma of honey and yuzu juice', 2.43, 'https://media-cdn.grubhub.com/image/upload/d_search:browse-images:default.jpg/w_150,q_auto:low,fl_lossy,dpr_2.0,c_fill,f_auto,h_150/oieu5v0mfhbwum2gafmu', 1),
-- (12, 2, 'Rose Lychee Soda', 'Rosa Lychee Soda has a sweet and sour taste, pulp os Lychee fruit, and the aroma of rose and lychee', 2.43, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqYwuPxDpuFKI8q5HDkATXQYpTrNN8lZCIeQ&s', 1),
-- (12, 2, 'Lychee Tea', 'Lychee Tea has a sweet taste, light level of tea, and the aroma of tea and lychee', 2.43, 'https://www.foodbuzz.site/wp-content/uploads/2017/10/Cr.-Tube-Cafe.-1.png', 1),
-- (12, 2, 'Fresh Passion Juice', 'Fresh Passion Juice has a sweet and sour taste and the aroma of fresh passion fruit', 2.43, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEH9FKU1hkokqdd1syovBSbPh8GddFfF1tFA&s', 1),
-- (8, 3, 'Pepperoni Crispy Pizza', 'Cheese, Pereroni and pizza suace', 12.99, 'https://images.deliveryhero.io/image/fd-kh/Products/1715840.jpg?width=500', 1),
-- (8, 3, 'Hawaiian Crispy Pizza', 'Chees, Ham, Toastedbacon and pizza suace', 12.99, 'https://images.deliveryhero.io/image/fd-kh/products/1715843.jpg?width=500', 1),
-- (8, 3, 'Cheese Lover Crispy Pizza', 'Mozzarella cheese and pizza sauce', 10.99, 'https://images.deliveryhero.io/image/fd-kh/Products/1715845.jpg?width=500', 1),
-- (8, 3, 'Super Supreme Crispy Pizza', 'Cheese, pepperoni, ham, Italian sausage, smoked chicken, mushrooms, onoins, capsicum, pineapple and pizza suace', 12.99, 'https://images.deliveryhero.io/image/fd-kh/Products/1715847.jpg?width=500', 1),
-- (8, 3, 'New Orleans Deluxe Crispy Pizza', 'Cheese, New Orleans, pineapple, and pizza sauce', 12.99, 'https://images.deliveryhero.io/image/fd-kh/Products/1715848.jpg?width=500', 1),
-- (8, 3, 'Meat Supreme Crispy Pizza', 'Cheese, pepperoni, ham, Italian sausage and pizza suace', 12.99, 'https://images.deliveryhero.io/image/fd-kh/Products/1715849.jpg?width=500', 1),
-- (8, 3, 'Tropical Seafood Crispy Pizza', 'Cheese Shrimp, Mussel, Squid, crap stick, pineaple and 1000 island sauce', 14.99, 'https://images.deliveryhero.io/image/fd-kh/Products/1715850.jpg?width=500', 1),
-- (8, 3, 'Spicy Shrimp BBQCrispy Pizza', 'Cheese, Shrimp, Green Capsicum, Onion, Pineaple and Spicy BBQ sauce', 14.99, 'https://images.deliveryhero.io/image/fd-kh/Products/1715854.jpg?width=500', 1),
-- (6, 3, 'Hamburger', 'Try our Hamburger, a signature flame-frilled beef patty topped with a simple layer of crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun', 3.9, 'https://images.deliveryhero.io/image/fd-kh/products/1944565.jpg?width=500', 1),
-- (6, 3, 'hamburger Meal', 'A flame-grilled beef patty with crunchy pickles, yellow mustard, and ketchup on a toasted sesame sed bun', 5.3, 'https://images.deliveryhero.io/image/fd-kh/products/1944566.jpg?width=500', 1),
-- (6, 3, 'Cheeseburger Meal', 'For ref only: A cheeseburger is a hamburger topped with cheese', 5.7, 'https://images.deliveryhero.io/image/fd-kh/products/1944568.jpg?width=500', 1),
-- (6, 3, 'Bacon Cheeseburger', 'For ref only: The juicy patty is prepared with flavorful ground beef, while the crunchy bacon and gooey cheese lend a delicious crunch and creaminess', 5.1, 'https://images.deliveryhero.io/image/fd-kh/products/1944569.jpg?width=500', 1),
-- (6, 3, 'Bacon Cheeseburger Meal', 'For ref only: The juicy patty is prepared with flavorful ground beef, while the crunchy bacon and gooey cheese lend a delicious crunch and creaminess', 6.5, 'https://images.deliveryhero.io/image/fd-kh/products/1944570.jpg?width=500', 1),
-- (6, 3, 'Double Cheeseburger Burger', 'Two signature flame-grilled beef patties topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard & ketchup on a toasted sesame seed bun', 6.6, 'https://images.deliveryhero.io/image/fd-kh/Products/1933755.jpg?width=500', 1),
-- (6, 3, 'Double BBQ Bacon Cheese', 'Signature flame-grilled 100% Australian beef patties or your choice of pork patties with melted cheese and the winning combination of sizzling bacon smoky BBQ sauce', 6.7, 'https://images.deliveryhero.io/image/fd-kh/products/1944573.jpg?width=500', 1),
-- (6, 3, 'Double BBQ Cheese Burger', 'Signature flame-grilled 100% Australian beef patties or your choice of pork patties with melted cheese and the winning combination of sizzling bacon and smoky BBQ sauce', 6.7, 'https://images.deliveryhero.io/image/fd-kh/products/1944575.jpg?width=500', 1),
-- (7, 3, 'Cheese Crust MEATZZA PIZZA-Medium', 'Delicious combination of crispy pepperoni, ham, bacon and cheese sausage with 100% Mozzarella cheese on smoky blended BBQ sauce', 13, 'https://images.deliveryhero.io/image/fd-kh/Products/3819465.jpg?width=500', 1),
-- (7, 3, 'Cheese Crust SEAFOOD PIZZA-Medium', 'A delicious pizza topped with a variety of seafood, offering a fresh and savory flavor, now 15% off (For ref only)', 13, 'https://images.deliveryhero.io/image/global-menu-service/FP_KH/vendor/spme/product/4316283/4c0626f9-f4a5-4a9b-a0b9-9865c3e6ad87.jpg?width=500', 1),
-- (7, 3, 'Cheese Crust TROPICAL SEAFOOD PIZZA-Medium', 'Fresh big shrimp & seafood mix (squid, baby clam, mussel), crab meet with fresh onion, green capsicum, black olive on new creamy islander sauce with 100% Mozzarella cheese', 13, 'https://images.deliveryhero.io/image/global-menu-service/FP_KH/vendor/spme/product/4316285/e29265a8-28a8-4b8f-84dc-5fa9dae918b8.jpg?width=500', 1),
-- (7, 3, 'Cheese Crust VEGGIE PIZZA-Medium', 'A veggie lover''s delight, now 15% off (For ref only)', 13, 'https://images.deliveryhero.io/image/fd-kh/Products/3819469.jpg?width=500', 1),
-- (7, 3, 'Cheese Crust MARGHERITA PIZZA-Medium', 'For cheese lover with 100% Mozzarella cheese on pizza sauce', 13, 'https://images.deliveryhero.io/image/fd-kh/Products/3819471.jpg?width=500', 1),
-- (7, 3, 'Cheese Crust HAWWALLAN PIZZA-Medium', 'Experience hawaiian taste with fresh shrimp, cheese sausage and juicy pineapple on pizza sauce with 100% Mozzarella cheese and mayo swirl', 13, 'https://images.deliveryhero.io/image/fd-kh/Products/3819472.jpg?width=500', 1),
-- (7, 3, 'Cheese Crust BBQ MEAT OVERLOADER PIZZA-Medium', 'Fully loaded with crispy pepperoni, ham, bacon, cheese sausage, sweet corn, fresh onions and green capsicum on new top secret smoked BBQ sauce with 100% mozzarella cheese', 13, 'https://images.deliveryhero.io/image/fd-kh/Products/3819476.jpg?width=500', 1),
-- (7, 3, 'CHEESE CRUST SUPER SUPERMEAT PIZZA-Medium', 'Pizza Sauce, Mozzarella cheese, pepperoni, ham, bacon, Cheese Sausage, corn, pineapple, black olive, onion, mushroom, green capsicum.', 13, 'https://images.deliveryhero.io/image/fd-kh/Products/3819478.jpg?width=500', 1),
-- (9, 5, 'Strawberry Blizzard® Treat (Small)', 'Luscious strawberry blended with DQ vanilla soft serve to Blizzard Perfection.', 3.5, 'https://images.deliveryhero.io/image/fd-kh/Products/161400.jpg?width=500', 1),
-- (9, 5, 'Kit Kat Blizzard® Treat (Small)', 'KitKat® wafer pieces and chocolate topping blended with creamy DQ® soft serve to Blizzard® Treat perfection.', 3.5, 'https://images.deliveryhero.io/image/fd-kh/Products/161402.jpg?width=500', 1),
-- (9, 5, 'Choco Chunk Blizzard® Treat (Small)', 'Vanilla mix with Choco chunk', 3.5, 'https://images.deliveryhero.io/image/fd-kh/Products/161398.jpg?width=500', 1),
-- (9, 5, 'Chocolate Covered Strawberry Blizzard® Treat (Small)', 'Vanilla mix with Chocolate', 3.5, 'https://images.deliveryhero.io/image/fd-kh/Products/161403.jpg?width=500', 1),
-- (9, 5, 'Green Tea Blizzard® Treat (Small)', 'Vanilla mix with green tea', 3.5, 'https://images.deliveryhero.io/image/fd-kh/Products/161396.jpg?width=500', 1),
-- (9, 5, 'Oreo Blizzard® Treat', 'Oreo® cookie pieces blended with creamy DQ® soft serve to Blizzard® Treat perfection.', 3.5, 'https://images.deliveryhero.io/image/fd-kh/Products/3091240.jpg?width=500', 1),
-- (9, 5, 'Green Tea Choco Chunk Blizzard® Cake', 'Vanilla with green tea and Choco chunk', 26.9, 'https://images.deliveryhero.io/image/fd-kh/Products/161389.jpg?width=500', 1),
-- (9, 5, 'Oreo Blizzard® Cake', 'Cake layers include Oreo® cookie pieces, chocolate topping, fudge & crunch centre layer and creamy DQ®soft serve.', 26.9, 'https://images.deliveryhero.io/image/fd-kh/Products/332483.jpg?width=500', 1),
-- (10, 3, 'Super Beef Burger', 'A hearty grilled beef patty topped with cheese, signature sauce, and vegetables', 4.49, 'https://images.deliveryhero.io/image/fd-kh/Products/3969367.jpg?width=500', 1),
-- (10, 3, 'Crispy Chicken Burger', 'A classic golden-fried chicken patty served with creamy mayonnaise and fresh lettuce on a bun', 2, 'https://images.deliveryhero.io/image/fd-kh/Products/3969366.jpg?width=500', 1),
-- (10, 3, 'Spicy Chicken Burger', 'A breaded, fried chicken patty topped with spicy sauce and lettuce served on a toasted bun', 2.2, 'https://images.deliveryhero.io/image/fd-kh/Products/3969365.jpg?width=500', 1),
-- (10, 3, 'Grilled Chicken Leg Burger', 'A tender, boneless whole chicken leg grilled in savory sauce and served in a bun', 2.5, 'https://images.deliveryhero.io/image/fd-kh/products/3969368.jpg?width=500', 1),
-- (10, 3, 'Chicken Roll', 'Grilled or fried chicken strips wrapped in a soft tortilla with veggies and dressing', 2, 'https://images.deliveryhero.io/image/fd-kh/Products/3969371.jpg?width=500', 1),
-- (10, 3, 'Egg Tart', '1pc, a flaky pastry shell filled with a sweet, creamy egg custard, baked until golden', 2, 'https://images.deliveryhero.io/image/fd-kh/Products/3969372.jpg?width=500', 1),
-- (10, 3, 'Stretchy Hot Dog Stick', 'A battered and fried stick containing a hot dog and mozzarella cheese that stretches when pulled', 2.19, 'https://images.deliveryhero.io/image/fd-kh/Products/3969373.jpg?width=500', 1),
-- (10, 3, 'Spicy Chicken Wings', 'Crispy fried or roasted wings tossed in a hot chili seasoning', 2.5, 'https://images.deliveryhero.io/image/fd-kh/Products/3969377.jpg?width=500', 1),
-- (11, 9, 'Hotpot Special Beef', 'Potato Glass Noodles/ Large Fiber Noodles, Mushrooms, Bak Choy Cabbage, Chinese Cabbage, White Sesame, Parsley, Duck Blood, Slide Meat, Meatball Tofu Sauce, Chili, Garlic.', 2.7, 'https://images.deliveryhero.io/image/fd-kh/Products/3874870.jpg?width=500', 1),
-- (11, 9, 'Hotpot Special Duck', 'Potato Glass Noodles/ Large Fiber Noodles, Mushrooms, Bak Choy Cabbage, Chinese Cabbage, White Sesame, Parsley, Duck Blood, Slide Meat, Meatball Tofu Sauce, Chili, Garlic.', 2.7, 'https://images.deliveryhero.io/image/fd-kh/Products/3874869.jpg?width=500', 1),
-- (11, 9, 'Hotpot Pepper Chicken', 'Potato Glass Noodles/ Large Fiber Noodles, Mushrooms, Bak Choy Cabbage, Chinese Cabbage, White Sesame, Parsley, Duck Blood, Slide Meat, Meatball Tofu Sauce, Chili, Garlic.', 5.4, 'https://images.deliveryhero.io/image/fd-kh/Products/3874868.jpg?width=500', 1);