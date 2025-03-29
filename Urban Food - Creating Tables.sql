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
    CONSTRAINT fk_delivery_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
