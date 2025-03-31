CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(15) UNIQUE NOT NULL,
    Address VARCHAR2(255),
    RegistrationDate DATE DEFAULT SYSDATE
);

CREATE TABLE Sellers (
    SellerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(15) UNIQUE NOT NULL,
    Address VARCHAR2(255),
    SellerType VARCHAR2(50) CHECK (SellerType IN ('Urban Farmer', 'Local Producer')),
    FarmLocation VARCHAR2(255),
    BusinessType VARCHAR2(100)
);

CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    SellerID NUMBER NOT NULL,
    Name VARCHAR2(100) NOT NULL,
    Category VARCHAR2(100) CHECK (Category IN ('Fruits', 'Vegetables', 'Dairy', 'Baked Goods', 'Crafts')),
    Price NUMBER(10,2) NOT NULL,
    StockQuantity NUMBER DEFAULT 0,
    CONSTRAINT fk_seller FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    OrderDate DATE DEFAULT SYSDATE,
    TotalAmount NUMBER(10,2) NOT NULL,
    Status VARCHAR2(50) CHECK (Status IN ('Pending', 'Shipped', 'Delivered')),
    CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID NUMBER PRIMARY KEY,
    OrderID NUMBER NOT NULL,
    ProductID NUMBER NOT NULL,
    SellerID NUMBER NOT NULL,
    Quantity NUMBER NOT NULL,
    Subtotal NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT fk_seller_order FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

CREATE TABLE Payments (
    PaymentID NUMBER PRIMARY KEY,
    OrderID NUMBER NOT NULL,
    PaymentMethod VARCHAR2(50) CHECK (PaymentMethod IN ('Card', 'Cash', 'Online')),
    PaymentDate DATE DEFAULT SYSDATE,
    PaymentStatus VARCHAR2(50) CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed')),
    CONSTRAINT fk_payment_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Deliveries (
    DeliveryID NUMBER PRIMARY KEY,
    OrderID NUMBER NOT NULL,
    DeliveryStatus VARCHAR2(50) CHECK (DeliveryStatus IN ('Pending', 'Out for Delivery', 'Delivered')),
    EstimatedDeliveryDate DATE,
    TrackingNumber VARCHAR2(100),
    CONSTRAINT fk_delivery_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert for Customers
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (1, 'Alice Smith', 'alice.smith@example.com', '1234567890', '123 Elm St, Springfield');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (2, 'Bob Johnson', 'bob.johnson@example.com', '2345678901', '456 Oak St, Rivertown');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (3, 'Charlie Brown', 'charlie.brown@example.com', '3456789012', '789 Pine St, Lakeside');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (4, 'David White', 'david.white@example.com', '4567890123', '101 Maple St, Hillview');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (5, 'Eva Green', 'eva.green@example.com', '5678901234', '202 Birch St, Centerville');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (6, 'Frank Black', 'frank.black@example.com', '6789012345', '303 Cedar St, Seaside');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (7, 'Grace Wilson', 'grace.wilson@example.com', '7890123456', '404 Redwood St, Maplewood');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (8, 'Hannah Lewis', 'hannah.lewis@example.com', '8901234567', '505 Willow St, Brookfield');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (9, 'Ivy Davis', 'ivy.davis@example.com', '9012345678', '606 Ash St, Pinehill');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (10, 'Jack Taylor', 'jack.taylor@example.com', '0123456789', '707 Fir St, Clearfield');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (11, 'Kathy Clark', 'kathy.clark@example.com', '1230987654', '808 Hazel St, Sunnydale');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (12, 'Liam Harris', 'liam.harris@example.com', '2342098765', '909 Pine St, Oakwood');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (13, 'Mia Lewis', 'mia.lewis@example.com', '3453209876', '123 Maple St, Riverside');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (14, 'Nina Walker', 'nina.walker@example.com', '4564310987', '234 Oak St, Greenfield');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address)
VALUES (15, 'Oliver Scott', 'oliver.scott@example.com', '5675421098', '345 Birch St, Westville');

-- Insert for Sellers
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (1, 'Urban Farms', 'urban.farms@example.com', '1234567890', '100 Farm St, Downtown', 'Urban Farmer', 'Downtown City', 'Vegetable Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (2, 'Fresh Produce', 'fresh.produce@example.com', '2345678901', '200 Farm Rd, Rivertown', 'Local Producer', 'Rivertown Valley', 'Fruit Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (3, 'Green Acres', 'green.acres@example.com', '3456789012', '300 Green Ln, Oakridge', 'Urban Farmer', 'Oakridge', 'Organic Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (4, 'Local Dairy', 'local.dairy@example.com', '4567890123', '400 Dairy Ave, Clearfield', 'Local Producer', 'Clearfield Plains', 'Dairy Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (5, 'Sunny Farms', 'sunny.farms@example.com', '5678901234', '500 Sunflower St, Brookfield', 'Urban Farmer', 'Brookfield', 'Vegetable Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (6, 'Baked Goods Co.', 'baked.goods@example.com', '6789012345', '600 Bread Rd, Lakeside', 'Local Producer', 'Lakeside', 'Bakery');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (7, 'Craft Creations', 'craft.creations@example.com', '7890123456', '700 Craft St, Rivertown', 'Urban Farmer', 'Rivertown', 'Handmade Crafts');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (8, 'Herb Gardens', 'herb.gardens@example.com', '8901234567', '800 Herb Ln, Seaside', 'Local Producer', 'Seaside Beach', 'Herb Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (9, 'Fresh Bakery', 'fresh.bakery@example.com', '9012345678', '900 Wheat Rd, Pinehill', 'Local Producer', 'Pinehill', 'Bakery');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (10, 'Mountain Dairy', 'mountain.dairy@example.com', '0123456789', '1000 Milk Ave, Hilltop', 'Local Producer', 'Hilltop Mountains', 'Dairy Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (11, 'Farm Fresh', 'farm.fresh@example.com', '1230987654', '1100 Fresh Ln, Oakwood', 'Urban Farmer', 'Oakwood', 'Organic Produce');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (12, 'Eco Produce', 'eco.produce@example.com', '2342098765', '1200 Green Rd, Maplewood', 'Urban Farmer', 'Maplewood', 'Vegetable Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (13, 'Organic Dairy', 'organic.dairy@example.com', '3453209876', '1300 Cow Rd, Riverside', 'Local Producer', 'Riverside', 'Organic Dairy Farming');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (14, 'Gourmet Baked Goods', 'gourmet.bakery@example.com', '4564310987', '1400 Bakery St, Greenfield', 'Local Producer', 'Greenfield', 'Bakery');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType)
VALUES (15, 'Handmade Crafts', 'handmade.crafts@example.com', '5675421098', '1500 Craft Rd, Westville', 'Urban Farmer', 'Westville', 'Crafts');

-- Insert for Products
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (1, 1, 'Carrot', 'Vegetables', 2.50, 100);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (2, 2, 'Apple', 'Fruits', 1.20, 200);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (3, 3, 'Spinach', 'Vegetables', 3.00, 150);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (4, 4, 'Milk', 'Dairy', 1.50, 500);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (5, 5, 'Tomato', 'Vegetables', 2.80, 120);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (6, 6, 'Bread', 'Baked Goods', 2.00, 250);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (7, 7, 'Handmade Vase', 'Crafts', 15.00, 30);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (8, 8, 'Basil', 'Vegetables', 3.50, 60);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (9, 9, 'Croissant', 'Baked Goods', 3.50, 100);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (10, 10, 'Cheese', 'Dairy', 4.00, 400);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (11, 11, 'Organic Cucumber', 'Vegetables', 2.10, 90);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (12, 12, 'Lettuce', 'Vegetables', 1.80, 130);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (13, 13, 'Organic Yogurt', 'Dairy', 2.50, 300);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (14, 14, 'Cupcake', 'Baked Goods', 2.60, 200);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity)
VALUES (15, 15, 'Handmade Bracelet', 'Crafts', 10.00, 50);

-- Insert for Orders
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (1, 1, 25.00, 'Pending');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (2, 2, 45.50, 'Shipped');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (3, 3, 12.00, 'Delivered');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (4, 4, 50.00, 'Pending');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (5, 5, 15.00, 'Shipped');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (6, 6, 60.00, 'Delivered');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (7, 7, 30.00, 'Pending');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (8, 8, 20.00, 'Shipped');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (9, 9, 40.00, 'Delivered');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (10, 10, 70.00, 'Pending');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (11, 11, 32.50, 'Shipped');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (12, 12, 18.00, 'Delivered');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (13, 13, 22.00, 'Pending');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (14, 14, 35.00, 'Shipped');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status)
VALUES (15, 15, 50.00, 'Delivered');

-- Insert for OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (1, 1, 1, 1, 10, 25.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (2, 2, 2, 2, 20, 40.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (3, 3, 3, 3, 4, 12.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (4, 4, 4, 4, 10, 15.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (5, 5, 5, 5, 5, 14.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (6, 6, 6, 6, 6, 12.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (7, 7, 7, 7, 2, 30.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (8, 8, 8, 8, 4, 14.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (9, 9, 9, 9, 8, 28.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (10, 10, 10, 10, 15, 60.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (11, 11, 11, 11, 10, 21.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (12, 12, 12, 12, 6, 16.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (13, 13, 13, 13, 8, 20.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (14, 14, 14, 14, 7, 18.20);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal)
VALUES (15, 15, 15, 15, 3, 30.00);

-- Insert for Payments
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (1, 1, 'Card', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (2, 2, 'Cash', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (3, 3, 'Online', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (4, 4, 'Card', 'Pending');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (5, 5, 'Cash', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (6, 6, 'Online', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (7, 7, 'Card', 'Pending');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (8, 8, 'Cash', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (9, 9, 'Online', 'Failed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (10, 10, 'Card', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (11, 11, 'Cash', 'Pending');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (12, 12, 'Online', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (13, 13, 'Card', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (14, 14, 'Cash', 'Completed');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES (15, 15, 'Online', 'Failed');

INSERT INTO Deliveries (DeliveryID, OrderID, DeliveryStatus, EstimatedDeliveryDate, TrackingNumber) VALUES
(1, 1, 'Pending', TO_DATE('2025-04-05', 'YYYY-MM-DD'), 'TRK12345'),
(2, 2, 'Out for Delivery', TO_DATE('2025-04-06', 'YYYY-MM-DD'), 'TRK12346'),
(3, 3, 'Delivered', TO_DATE('2025-04-02', 'YYYY-MM-DD'), 'TRK12347'),
(4, 4, 'Pending', TO_DATE('2025-04-07', 'YYYY-MM-DD'), 'TRK12348'),
(5, 5, 'Delivered', TO_DATE('2025-03-30', 'YYYY-MM-DD'), 'TRK12349'),
(6, 6, 'Out for Delivery', TO_DATE('2025-04-04', 'YYYY-MM-DD'), 'TRK12350'),
(7, 7, 'Delivered', TO_DATE('2025-03-28', 'YYYY-MM-DD'), 'TRK12351'),
(8, 8, 'Pending', TO_DATE('2025-04-10', 'YYYY-MM-DD'), 'TRK12352'),
(9, 9, 'Out for Delivery', TO_DATE('2025-04-02', 'YYYY-MM-DD'), 'TRK12353'),
(10, 10, 'Delivered', TO_DATE('2025-03-25', 'YYYY-MM-DD'), 'TRK12354'),
(11, 11, 'Pending', TO_DATE('2025-04-12', 'YYYY-MM-DD'), 'TRK12355'),
(12, 12, 'Delivered', TO_DATE('2025-03-22', 'YYYY-MM-DD'), 'TRK12356'),
(13, 13, 'Out for Delivery', TO_DATE('2025-04-03', 'YYYY-MM-DD'), 'TRK12357'),
(14, 14, 'Delivered', TO_DATE('2025-03-27', 'YYYY-MM-DD'), 'TRK12358'),
(15, 15, 'Pending', TO_DATE('2025-04-09', 'YYYY-MM-DD'), 'TRK12359');



-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(1, 'Fresh Farms', '+1234567890', 'New York');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(2, 'Dairy Delights', '+1987654321', 'London');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(3, 'Baker''s Haven',  '+1122334455', 'Paris');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(4, 'Organic Growers',  '+1444555666', 'Sydney');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(5, 'Sunny Fields', '+1555666777',  'Toronto');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(6, 'EcoHarvest', '+1666777888', 'Berlin');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(7, 'Farm Fresh',  '+1777888999', 'Rome');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(8, 'Rural Bounty',  '+1888999000', 'Tokyo');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(9, 'Healthy Harvest', '+1999000111', 'Barcelona');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(10, 'Village Market', '+2111222333', 'Amsterdam');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(11, 'Nature''s Best', '+2222333444', 'Dubai');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(12, 'AgriWorld', '+2333444555', 'Mumbai');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(13, 'Green Thumb', '+2444555666', 'São Paulo');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(14, 'Sunrise Produce', '+2555666777', 'Cape Town');
-- INSERT INTO Supplier (supplier_id, name, contact_info, address) VALUES(15, 'Hometown Goods', '+2666777888', 'Singapore');


-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(1, 'Organic Apples', 'Fresh organic apples', 'Fruits', 55.99, 100, 1);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(2, 'Whole Milk', '1L fresh whole milk', 'Dairy', 52.49, 200, 2);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(3, 'Sourdough Bread', 'Artisan sourdough bread', 'Baked Goods', 60.75, 150, 3);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(4, 'Handmade Cheese', 'Aged cheddar cheese', 'Dairy', 75.30, 120, 2);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(5, 'Organic Honey', 'Raw unprocessed honey', 'Groceries', 58.25, 180, 4);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(6, 'Fresh Salmon', 'Wild-caught fresh salmon', 'Seafood', 95.99, 90, 5);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(7, 'Almond Butter', 'Homemade almond butter', 'Groceries', 65.80, 140, 6);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(8, 'Handmade Chocolate', 'Dark chocolate with nuts', 'Sweets', 78.40, 160, 7);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(9, 'Avocado Oil', 'Cold-pressed avocado oil', 'Cooking Oil', 82.15, 130, 8);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(10, 'Truffle Mushrooms', 'Premium black truffle mushrooms', 'Vegetables', 105.50, 80, 9);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(11, 'Greek Yogurt', 'Traditional Greek-style yogurt', 'Dairy', 53.90, 170, 10);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(12, 'Organic Almonds', 'Raw organic almonds', 'Nuts', 88.25, 200, 11);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(13, 'Blue Mountain Coffee', 'Premium whole bean coffee', 'Beverages', 120.75, 90, 12);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(14, 'Matcha Green Tea', 'Ceremonial-grade matcha powder', 'Beverages', 79.99, 110, 13);
-- INSERT INTO Product (product_id, name, description, category, price, stock_quantity, supplier_id) VALUES(15, 'Handmade Wooden Bowl', 'Eco-friendly handcrafted wooden bowl', 'Handmade Crafts', 99.50, 75, 14);


-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(1, 'Alice', 'Johnson', 'alice@email.com', '+11234567890', 'New York', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(2, 'Michael', 'Smith', 'michael@email.com', '+19876543210', 'London', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(3, 'Sophia', 'Brown', 'sophia@email.com', '+12125557777', 'Paris', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(4, 'David', 'Williams', 'david@email.com', '+13235558888', 'Sydney', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(5, 'Emma', 'Davis', 'emma@email.com', '+14345559999', 'Toronto', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(6, 'Liam', 'Miller', 'liam@email.com', '+15455551111', 'Berlin', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(7, 'Olivia', 'Wilson', 'olivia@email.com', '+16555552222', 'Rome', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(8, 'James', 'Moore', 'james@email.com', '+17655553333', 'Tokyo', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(9, 'Charlotte', 'Taylor', 'charlotte@email.com', '+18755554444', 'Barcelona', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(10, 'Benjamin', 'Anderson', 'benjamin@email.com', '+19855555555', 'Amsterdam', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(11, 'Amelia', 'Thomas', 'amelia@email.com', '+20955556666', 'Dubai', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(12, 'Ethan', 'Harris', 'ethan@email.com', '+21055557777', 'Mumbai', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(13, 'Isabella', 'Martin', 'isabella@email.com', '+22155558888', 'São Paulo', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(14, 'Alexander', 'Thompson', 'alexander@email.com', '+23255559999', 'Cape Town', SYSDATE);
-- INSERT INTO Customer (customer_id, first_name, last_name, email, contact, address, register_date) VALUES(15, 'Mia', 'White', 'mia@email.com', '+24355560000', 'Singapore', SYSDATE);


-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(1, 5, TO_DATE('2025-03-20', 'YYYY-MM-DD'), 15.97, 'Shipped');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(2, 12, TO_DATE('2025-03-21', 'YYYY-MM-DD'), 9.99, 'Delivered');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(3, 8, TO_DATE('2025-03-22', 'YYYY-MM-DD'), 23.45, 'Processing');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(4, 3, TO_DATE('2025-03-23', 'YYYY-MM-DD'), 30.78, 'Pending');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(5, 15, TO_DATE('2025-03-24', 'YYYY-MM-DD'), 12.89, 'Cancelled');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(6, 7, TO_DATE('2025-03-25', 'YYYY-MM-DD'), 45.60, 'Shipped');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(7, 1, TO_DATE('2025-03-26', 'YYYY-MM-DD'), 19.99, 'Processing');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(8, 10, TO_DATE('2025-03-27', 'YYYY-MM-DD'), 8.49, 'Pending');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(9, 4, TO_DATE('2025-03-28', 'YYYY-MM-DD'), 32.25, 'Delivered');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(10, 9, TO_DATE('2025-03-29', 'YYYY-MM-DD'), 14.55, 'Cancelled');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(11, 14, TO_DATE('2025-03-30', 'YYYY-MM-DD'), 21.70, 'Pending');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(12, 6, TO_DATE('2025-03-31', 'YYYY-MM-DD'), 16.35, 'Processing');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(13, 2, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 27.80, 'Shipped');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(14, 11, TO_DATE('2025-03-02', 'YYYY-MM-DD'), 29.99, 'Delivered');
-- INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES(15, 13, TO_DATE('2025-03-03', 'YYYY-MM-DD'), 18.50, 'Pending');