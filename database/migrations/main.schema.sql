CREATE DATABASE nomnom;
use nomnom;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    address TEXT,
    avatar VARCHAR(255),
    role VARCHAR(50) NOT NULL DEFAULT 'customer',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (role IN ('customer', 'admin'))
);

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    phone VARCHAR(50),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    address TEXT NOT NULL,
    image_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    image_url VARCHAR(255)
);

CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(100) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    discount_type VARCHAR(50) NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    min_order_amount DECIMAL(10,2) DEFAULT 0,
    max_discount_amount DECIMAL(10,2),
    start_date DATETIME,
    end_date DATETIME,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (discount_type IN ('percentage', 'fixed')),
    CHECK (discount_value >= 0)
);

ALTER TABLE Promotions
ADD CONSTRAINT chk_promotion_dates
CHECK (end_date > start_date);

CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255),
    is_available BOOLEAN DEFAULT TRUE,
    CHECK (price >= 0),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Carts (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Cart_Items (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CHECK (quantity > 0),
    CHECK (price >= 0),
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id),
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id)
);

-- change total_price to null (order depend on order_items first for the order to be created) (Changed)
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    promotion_id INT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (total_price >= 0),
    CHECK (status IN ('pending', 'confirmed', 'preparing', 'out_for_delivery', 'delivered', 'cancelled')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (promotion_id) REFERENCES Promotions(promotion_id)
);

ALTER TABLE Orders
MODIFY total_price DECIMAL(10,2) NULL;

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CHECK (quantity > 0),
    CHECK (price >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL UNIQUE,
    amount DOUBLE NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (amount >= 0),
    CHECK (payment_method IN ('cash', 'card', 'online')),
    CHECK (status IN ('pending', 'paid', 'failed', 'refunded')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (rating BETWEEN 1 AND 5),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Delivery_Personnel (
    delivery_person_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    vehicle_type VARCHAR(50),
    current_location TEXT,
    current_latitude DECIMAL(10,8),
    current_longitude DECIMAL(11,8),
    status VARCHAR(50) DEFAULT 'available',
    rating DOUBLE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (status IN ('available', 'busy', 'offline')),
    CHECK (rating BETWEEN 0 AND 5)
);

ALTER TABLE Delivery_Personnel
MODIFY phone VARCHAR(50) NOT NULL;

ALTER TABLE Delivery_Personnel
MODIFY vehicle_type VARCHAR(50) NOT NULL;

ALTER TABLE Delivery_Personnel
MODIFY rating DOUBLE DEFAULT 0;

CREATE TABLE Order_Status_History (
    status_history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    delivery_person_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (delivery_person_id) REFERENCES Delivery_Personnel(delivery_person_id)
);

CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL UNIQUE,
    delivery_person_id INT NOT NULL,
    pickup_location TEXT,
    delivery_location TEXT,
    estimated_arrival DATETIME,
    actual_arrival DATETIME,
    status VARCHAR(50) DEFAULT 'assigned',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (status IN ('assigned', 'picked_up', 'delivering', 'delivered', 'cancelled')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (delivery_person_id) REFERENCES Delivery_Personnel(delivery_person_id)
);

CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_id INT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    read_at DATETIME,
    CHECK (type IN ('order', 'delivery', 'promotion', 'system')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- update / delete constraints
-- CART_ITEMS 
ALTER TABLE Cart_Items
ADD CONSTRAINT fk_cart_items_cart
FOREIGN KEY (cart_id)
REFERENCES Carts(cart_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Cart_Items
ADD CONSTRAINT fk_cart_items_menu_item
FOREIGN KEY (item_id)
REFERENCES Menu_Items(item_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- MENU_ITEMS
ALTER TABLE Menu_Items
ADD CONSTRAINT fk_menu_items_restaurant
FOREIGN KEY (restaurant_id)
REFERENCES Restaurants(restaurant_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE Menu_Items
ADD CONSTRAINT fk_menu_items_category
FOREIGN KEY (category_id)
REFERENCES Categories(category_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- CARTS
ALTER TABLE Carts
ADD CONSTRAINT fk_carts_user
FOREIGN KEY (user_id)
REFERENCES Users(user_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ORDERS
ALTER TABLE Orders
ADD CONSTRAINT fk_orders_user
FOREIGN KEY (user_id)
REFERENCES Users(user_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_promotion
FOREIGN KEY (promotion_id)
REFERENCES Promotions(promotion_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- ORDER_ITEMS
ALTER TABLE Order_Items
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES Orders(order_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Order_Items
ADD CONSTRAINT fk_order_items_menu_item
FOREIGN KEY (item_id)
REFERENCES Menu_Items(item_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- PAYMENTS
ALTER TABLE Payments
ADD CONSTRAINT fk_payments_order
FOREIGN KEY (order_id)
REFERENCES Orders(order_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- REVIEWS
ALTER TABLE Reviews
ADD CONSTRAINT fk_reviews_user
FOREIGN KEY (user_id)
REFERENCES Users(user_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Reviews
ADD CONSTRAINT fk_reviews_restaurant
FOREIGN KEY (restaurant_id)
REFERENCES Restaurants(restaurant_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- ORDER_STATUS_HISTORY
ALTER TABLE Order_Status_History
ADD CONSTRAINT fk_status_history_order
FOREIGN KEY (order_id)
REFERENCES Orders(order_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Order_Status_History
ADD CONSTRAINT fk_status_history_delivery_person
FOREIGN KEY (delivery_person_id)
REFERENCES Delivery_Personnel(delivery_person_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- DELIVERIES
ALTER TABLE Deliveries
ADD CONSTRAINT fk_deliveries_order
FOREIGN KEY (order_id)
REFERENCES Orders(order_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE Deliveries
ADD CONSTRAINT fk_deliveries_delivery_person
FOREIGN KEY (delivery_person_id)
REFERENCES Delivery_Personnel(delivery_person_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- NOTIFICATIONS
ALTER TABLE Notifications
ADD CONSTRAINT fk_notifications_user
FOREIGN KEY (user_id)
REFERENCES Users(user_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Notifications
ADD CONSTRAINT fk_notifications_order
FOREIGN KEY (order_id)
REFERENCES Orders(order_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

SHOW TABLES;
DESCRIBE Users;
DESCRIBE Orders;
DESCRIBE Order_Items;
DESCRIBE Deliveries;

select * from information_schema.table_constraints where table_schema = 'nomnom';
select * from information_schema.check_constraints where constraint_schema = 'nomnom';
select * from information_schema.referential_constraints where constraint_schema = 'nomnom';