-- There are two types of sellers which are Farmers and Producers. In order to view the details of each type, we have to filter columns using queries. Lets go with some filterings.

-- To view all sellers and their seller types
SELECT SellerID, Name, SellerType FROM Sellers;

-- To filter the data of Farmers only
SELECT SellerID, Name, Email, Phone, Address, FarmLocation FROM Sellers WHERE SellerType = 'Urban Farmer';

-- To filter the data of Local Producers only
SELECT SellerID, Name, Email, Phone, Address, BusinessType FROM Sellers WHERE SellerType = 'Local Producer';

-- Use: It let you know about each seller type in easy way. Also retrieves the data from specific type of sellers. Useful when the database is larger.

-----------------------------------------------------------------------------------------------------------------

-- In some cases, we need to know that who sells the each product. Assume that, it's required to join two related tables using their relationship to retrieve specific informations.

-- List all products with their seller information
SELECT P.ProductID, P.Name AS ProductName, P.Category, P.Price, P.StockQuantity, 
       S.Name AS SellerName, S.SellerType
FROM Products P
JOIN Sellers S ON P.SellerID = S.SellerID;

-----------------------------------------------------------------------------------------------------------------

-- This type of platform should provide order details under customer profiles. So the customers can easily list out their orders. To make this more realistic lets take orders under the customer name instead of customer ID.

-- Find orders by customer name
SELECT O.OrderID, C.Name AS CustomerName, O.OrderDate, O.TotalAmount, O.Status
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID;

-----------------------------------------------------------------------------------------------------------------

-- Suppose we need to retrieve order details by orderID along with some additional informations like the name of the item and the person who placed the order. -To achieve this, you must merge multiple tables to make a complete data record. In such case, it can be sorted out like this

-- Get order details for a specific order
SELECT OD.OrderDetailID, O.OrderID, C.Name AS CustomerName, P.Name AS ProductName, 
       OD.Quantity, OD.Subtotal
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE O.OrderID = 1;

-- Expanded (Added seller name related to the product)
SELECT OD.OrderDetailID, O.OrderID, C.Name AS CustomerName, P.Name AS ProductName, S.Name AS SellerName, 
       OD.Quantity, OD.Subtotal
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Sellers S ON P.SellerID = S.SellerID
WHERE O.OrderID = 1;

-----------------------------------------------------------------------------------------------------------------

-- Some higher level company management regulary evaluates ongoing sales data. If there is a need to calculate total sales made by each seller, here is how you can manage it.
-- Total sales made by each seller
SELECT S.Name AS SellerName, SUM(OD.Subtotal) AS TotalSales
FROM OrderDetails OD
JOIN Sellers S ON OD.SellerID = S.SellerID
GROUP BY S.Name
ORDER BY TotalSales DESC;

-----------------------------------------------------------------------------------------------------------------
-- If you're interested in foods, you may be aware of the trends in top selling items. If you want an analysis of the top demanding items on the website, here iss how you can fetch the required data.
-- Find top 5 selling products
SELECT P.Name AS ProductName, SUM(OD.Quantity) AS TotalSold
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalSold DESC
FETCH FIRST 5 ROWS ONLY;

-- IMPORTANT: make a query to calculate remaining stocks in the products table.

-----------------------------------------------------------------------------------------------------------------
-- Based of the company analysis needs, we can calculate the total revenue generated from orders over a specific time period
-- Total revenue generated for a time period
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN TO_DATE('2025-03-01', 'YYYY-MM-DD') 
                    AND TO_DATE('2025-03-31', 'YYYY-MM-DD');

-----------------------------------------------------------------------------------------------------------------
-- A good e-commerce website should provide a facility that allows customers to view their pending orders. here is how we can achieve that
-- Retrieve pending deliveries
SELECT D.DeliveryID, O.OrderID, C.Name AS CustomerName, D.DeliveryStatus, D.EstimatedDeliveryDate
FROM Deliveries D
JOIN Orders O ON D.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE D.DeliveryStatus != 'Delivered';

-- IMPORTANT: this should be filter with a single customer as it needs

-----------------------------------------------------------------------------------------------------------------
-- This analysis is not only for the customers but also for the management. From the customers perspective, it should display the count of their orders. From the management perspective, this should allow them to check the total number of orders placed on the website by all customers.

-- Count of orders made by a single customer
SELECT C.Name AS CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Name
ORDER BY TotalOrders DESC;

-- IMPORTANT: yet to write a query to retrieve all orders count

-----------------------------------------------------------------------------------------------------------------
-- We should let our customers to view their orders list
-- All orders with customer details
SELECT o.OrderID, c.Name AS CustomerName, o.TotalAmount, o.Status 
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;