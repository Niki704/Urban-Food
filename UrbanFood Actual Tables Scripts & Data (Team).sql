CREATE TABLE Supplier (
    supplier_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    contact_info VARCHAR2(255),
    address VARCHAR2(255)
);

CREATE TABLE Product (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    description VARCHAR2(255),
    category VARCHAR2(50),
    price NUMBER(10,2),
    stock_quantity NUMBER,
    supplier_id NUMBER,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Customer (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100) UNIQUE,
    contact VARCHAR2(15),
    address VARCHAR2(255),
    register_date DATE DEFAULT SYSDATE
);

CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    order_date DATE DEFAULT SYSDATE,
    total_amount NUMBER(10,2),
    status VARCHAR2(50) DEFAULT 'Pending',
    CONSTRAINT fk_customer 
        FOREIGN KEY (customer_id) 
        REFERENCES Customer(customer_id)
);


CREATE TABLE Order_Item (
    order_item_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER,
    subtotal NUMBER(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
    payment_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    payment_date DATE DEFAULT SYSDATE,
    payment_method VARCHAR2(50),
    amount NUMBER(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Delivery (
    delivery_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    delivery_status VARCHAR2(50),
    delivery_date DATE,
    tracking_number VARCHAR2(100),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(1, 'Fresh Farms', '+1234567890', 'New York');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(2, 'Dairy Delights', '+1987654321', 'London');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(3, 'Baker''s Haven',  '+1122334455', 'Paris');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(4, 'Organic Growers',  '+1444555666', 'Sydney');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(5, 'Sunny Fields', '+1555666777',  'Toronto');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(6, 'EcoHarvest', '+1666777888', 'Berlin');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(7, 'Farm Fresh',  '+1777888999', 'Rome');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(8, 'Rural Bounty',  '+1888999000', 'Tokyo');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(9, 'Healthy Harvest', '+1999000111', 'Barcelona');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(10, 'Village Market', '+2111222333', 'Amsterdam');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(11, 'Nature''s Best', '+2222333444', 'Dubai');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(12, 'AgriWorld', '+2333444555', 'Mumbai');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(13, 'Green Thumb', '+2444555666', 'São Paulo');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(14, 'Sunrise Produce', '+2555666777', 'Cape Town');
INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(15, 'Hometown Goods', '+2666777888', 'Singapore');


INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(1, 'Organic Apples', 'Fresh organic apples', 'Fruits', 55.99, 100, 1);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(2, 'Whole Milk', '1L fresh whole milk', 'Dairy', 52.49, 200, 2);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(3, 'Sourdough Bread', 'Artisan sourdough bread', 'Baked Goods', 60.75, 150, 3);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(4, 'Handmade Cheese', 'Aged cheddar cheese', 'Dairy', 75.30, 120, 2);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(5, 'Organic Honey', 'Raw unprocessed honey', 'Groceries', 58.25, 180, 4);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(6, 'Fresh Salmon', 'Wild-caught fresh salmon', 'Seafood', 95.99, 90, 5);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(7, 'Almond Butter', 'Homemade almond butter', 'Groceries', 65.80, 140, 6);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(8, 'Handmade Chocolate', 'Dark chocolate with nuts', 'Sweets', 78.40, 160, 7);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(9, 'Avocado Oil', 'Cold-pressed avocado oil', 'Cooking Oil', 82.15, 130, 8);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(10, 'Truffle Mushrooms', 'Premium black truffle mushrooms', 'Vegetables', 105.50, 80, 9);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(11, 'Greek Yogurt', 'Traditional Greek-style yogurt', 'Dairy', 53.90, 170, 10);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(12, 'Organic Almonds', 'Raw organic almonds', 'Nuts', 88.25, 200, 11);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(13, 'Blue Mountain Coffee', 'Premium whole bean coffee', 'Beverages', 120.75, 90, 12);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(14, 'Matcha Green Tea', 'Ceremonial-grade matcha powder', 'Beverages', 79.99, 110, 13);
INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(15, 'Handmade Wooden Bowl', 'Eco-friendly handcrafted wooden bowl', 'Handmade Crafts', 99.50, 75, 14);


INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(1, 'Alice', 'Johnson', 'alice@email.com', '+11234567890', 'New York', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(2, 'Michael', 'Smith', 'michael@email.com', '+19876543210', 'London', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(3, 'Sophia', 'Brown', 'sophia@email.com', '+12125557777', 'Paris', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(4, 'David', 'Williams', 'david@email.com', '+13235558888', 'Sydney', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(5, 'Emma', 'Davis', 'emma@email.com', '+14345559999', 'Toronto', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(6, 'Liam', 'Miller', 'liam@email.com', '+15455551111', 'Berlin', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(7, 'Olivia', 'Wilson', 'olivia@email.com', '+16555552222', 'Rome', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(8, 'James', 'Moore', 'james@email.com', '+17655553333', 'Tokyo', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(9, 'Charlotte', 'Taylor', 'charlotte@email.com', '+18755554444', 'Barcelona', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(10, 'Benjamin', 'Anderson', 'benjamin@email.com', '+19855555555', 'Amsterdam', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(11, 'Amelia', 'Thomas', 'amelia@email.com', '+20955556666', 'Dubai', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(12, 'Ethan', 'Harris', 'ethan@email.com', '+21055557777', 'Mumbai', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(13, 'Isabella', 'Martin', 'isabella@email.com', '+22155558888', 'São Paulo', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(14, 'Alexander', 'Thompson', 'alexander@email.com', '+23255559999', 'Cape Town', SYSDATE);
INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(15, 'Mia', 'White', 'mia@email.com', '+24355560000', 'Singapore', SYSDATE);


INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(1, 5, TO_DATE('2025-03-20', 'YYYY-MM-DD'), 15.97, 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(2, 12, TO_DATE('2025-03-21', 'YYYY-MM-DD'), 9.99, 'Delivered');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(3, 8, TO_DATE('2025-03-22', 'YYYY-MM-DD'), 23.45, 'Processing');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(4, 3, TO_DATE('2025-03-23', 'YYYY-MM-DD'), 30.78, 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(5, 15, TO_DATE('2025-03-24', 'YYYY-MM-DD'), 12.89, 'Cancelled');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(6, 7, TO_DATE('2025-03-25', 'YYYY-MM-DD'), 45.60, 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(7, 1, TO_DATE('2025-03-26', 'YYYY-MM-DD'), 19.99, 'Processing');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(8, 10, TO_DATE('2025-03-27', 'YYYY-MM-DD'), 8.49, 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(9, 4, TO_DATE('2025-03-28', 'YYYY-MM-DD'), 32.25, 'Delivered');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(10, 9, TO_DATE('2025-03-29', 'YYYY-MM-DD'), 14.55, 'Cancelled');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(11, 14, TO_DATE('2025-03-30', 'YYYY-MM-DD'), 21.70, 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(12, 6, TO_DATE('2025-03-31', 'YYYY-MM-DD'), 16.35, 'Processing');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(13, 2, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 27.80, 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(14, 11, TO_DATE('2025-03-02', 'YYYY-MM-DD'), 29.99, 'Delivered');
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(15, 13, TO_DATE('2025-03-03', 'YYYY-MM-DD'), 18.50, 'Pending');

INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(1, 12, 5, 2, 9.98);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(2, 3, 7, 4, 11.96);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(3, 14, 3, 2, 11.98);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(4, 8, 10, 2, 15.98);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(5, 1, 12, 1, 5.99);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(6, 7, 6, 3, 11.97);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(7, 10, 2, 2, 6.98);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(8, 15, 9, 1, 2.49);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(9, 5, 14, 3, 14.97);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(10, 9, 1, 3, 8.97);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(11, 6, 4, 1, 1.99);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(12, 2, 15, 2, 17.98);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(13, 4, 8, 1, 6.99);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(14, 13, 11, 3, 11.97);
INSERT INTO Order_Item (order_item_id, order_id, product_id, quantity, subtotal) VALUES(15, 11, 13, 2, 9.98);


ALTER TABLE Customer DROP COLUMN register_date;

ALTER TABLE Customer ADD reg_date DATE(25);

UPDATE customer SET reg_date  = CASE 
    WHEN customer_id = 1 THEN  TO_DATE('2025-03-20', 'YYYY-MM-DD')
    WHEN customer_id = 2 THEN  TO_DATE('2025-03-21', 'YYYY-MM-DD')
    WHEN customer_id = 3 THEN TO_DATE('2025-03-22', 'YYYY-MM-DD')
    WHEN customer_id = 4 THEN TO_DATE('2025-03-23', 'YYYY-MM-DD')
    WHEN customer_id = 5 THEN TO_DATE('2025-03-24', 'YYYY-MM-DD')
    WHEN customer_id = 6 THEN TO_DATE('2025-03-25', 'YYYY-MM-DD')
    WHEN customer_id = 7 THEN TO_DATE('2025-03-26', 'YYYY-MM-DD')
    WHEN customer_id = 8 THEN TO_DATE('2025-03-27', 'YYYY-MM-DD')
    WHEN customer_id = 9 THEN TO_DATE('2025-03-28', 'YYYY-MM-DD')
    WHEN customer_id = 10 THEN TO_DATE('2025-03-29', 'YYYY-MM-DD')
    WHEN customer_id = 11 THEN TO_DATE('2025-03-30', 'YYYY-MM-DD')
    WHEN customer_id = 12 THEN TO_DATE('2025-03-31', 'YYYY-MM-DD')
    WHEN customer_id = 13 THEN TO_DATE('2025-04-01', 'YYYY-MM-DD')
    WHEN customer_id = 14 THEN TO_DATE('2025-04-02', 'YYYY-MM-DD')
    WHEN customer_id = 15 THEN TO_DATE('2025-04-03', 'YYYY-MM-DD')
    ELSE Null
END;

Select * from Customer;