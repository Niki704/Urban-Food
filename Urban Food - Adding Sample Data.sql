-- Inserting Sample Data into the Tables

-- Sample Data for Customers
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address) VALUES (1, 'Alice Johnson', 'alice@email.com', '1234567890', '123 Green St');
INSERT INTO Customers (CustomerID, Name, Email, Phone, Address) VALUES (2, 'Bob Smith', 'bob@email.com', '0987654321', '456 Blue St');

-- Sample Data for Sellers
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType) VALUES (1, 'Fresh Farm', 'farm@email.com', '1112223333', '789 Red St', 'Urban Farmer', 'Farm A', 'Organic');
INSERT INTO Sellers (SellerID, Name, Email, Phone, Address, SellerType, FarmLocation, BusinessType) VALUES (2, 'Bakers Delight', 'baker@email.com', '4445556666', '321 Yellow St', 'Local Producer', 'Bakery B', 'Baked Goods');

-- Sample Data for Products
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity) VALUES (1, 1, 'Organic Apples', 'Fruits', 5.99, 50);
INSERT INTO Products (ProductID, SellerID, Name, Category, Price, StockQuantity) VALUES (2, 2, 'Whole Wheat Bread', 'Baked Goods', 3.49, 30);

-- Sample Data for Orders
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status) VALUES (1, 1, 15.98, 'Pending');
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, Status) VALUES (2, 2, 6.98, 'Delivered');

-- Sample Data for OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal) VALUES (1, 1, 1, 1, 2, 11.98);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal) VALUES (2, 2, 2, 2, 2, 6.98);

-- Sample Data for Payments
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus) VALUES (1, 1, 'Card', 'Pending');
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus) VALUES (2, 2, 'Cash', 'Completed');

-- Sample Data for Deliveries
INSERT INTO Deliveries (DeliveryID, OrderID, DeliveryStatus, EstimatedDeliveryDate) VALUES (1, 1, 'Out for Delivery', TO_DATE('2025-04-01', 'YYYY-MM-DD'));
INSERT INTO Deliveries (DeliveryID, OrderID, DeliveryStatus, EstimatedDeliveryDate) VALUES (2, 2, 'Delivered', TO_DATE('2025-03-28', 'YYYY-MM-DD'));

-- Check inserted data

SELECT * FROM CUSTOMERS;
SELECT * FROM SELLERS;
SELECT * FROM PRODUCTS;
SELECT * FROM ORDERS;
SELECT * FROM ORDERDETAILS;
SELECT * FROM PAYMENTS;
SELECT * FROM DELIVERIES;