-- PL/SQL used to automate tasks such as update/modify data after an operation and perform complex calculations with the data. It also helps to validate data on the database.

-- Let's begin with updating order status
CREATE OR REPLACE PROCEDURE UpdateOrderStatus(
    p_OrderID IN NUMBER,
    p_NewStatus IN VARCHAR2
) AS
BEGIN
    UPDATE Orders
    SET Status = p_NewStatus
    WHERE OrderID = p_OrderID;

    COMMIT;
END;
/

-- Procedure to reduce stocks after an order
CREATE OR REPLACE PROCEDURE ReduceStock(
    p_ProductID IN NUMBER,
    p_Quantity IN NUMBER
) AS
BEGIN
    UPDATE Products
    SET StockQuantity = StockQuantity - p_Quantity
    WHERE ProductID = p_ProductID AND StockQuantity >= p_Quantity;

    COMMIT;
END;
/
-- Note: WHERE Clause checks ProductID and allows only if there is sufficiant stock available.

-- Delete a customer and their orders 
CREATE OR REPLACE PROCEDURE DeleteCustomer(
    p_CustomerID IN NUMBER
) AS
BEGIN
    DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = p_CustomerID);

    DELETE FROM Orders WHERE CustomerID = p_CustomerID;

    DELETE FROM Customers WHERE CustomerID = p_CustomerID;

    COMMIT;
END;
/
-- Note: In order to delete a customer you should remove all other referencing table rows in other tables. In this case, it's required to delete data from child table (OrderDetails), parent table (Orders) and then from the customer table. otherwise you'll get constraints error.

-- Calculate total sales for a seller
CREATE OR REPLACE FUNCTION GetTotalSales(
    p_SellerID IN NUMBER
) RETURN NUMBER AS
    v_TotalSales NUMBER := 0;
BEGIN
    SELECT COALESCE(SUM(OD.Subtotal), 0)
    INTO v_TotalSales
    FROM OrderDetails OD
    JOIN Sellers S ON OD.SellerID = S.SellerID
    WHERE S.SellerID = p_SellerID;

    RETURN v_TotalSales;
END;
/
-- Note: COALESCE func outputs 0 if there is no value found.

-- Let's add a barrier to prevent orders if stock is not available or empty
CREATE OR REPLACE TRIGGER CheckStockBeforeOrder
BEFORE INSERT ON OrderDetails
FOR EACH ROW
DECLARE
    v_Stock NUMBER;
BEGIN
    SELECT StockQuantity INTO v_Stock
    FROM Products
    WHERE ProductID = :NEW.ProductID;

    IF v_Stock < :NEW.Quantity THEN
        RAISE_APPLICATION_ERROR(-20001, 'Not enough stock available for this product.');
    END IF;
END;
/
-- Note: This procedure triggers on the OrderDetails table. It doesn't need to call. it automatically triggers when the stock quantity is lower than the requesting quantity.

-- Test Procedures
-----------------------------------------------------------------------------------------------------------------
BEGIN
    UpdateOrderStatus(1, 'Shipped');
END;
/

-----------------------------------------------------------------------------------------------------------------
BEGIN
    ReduceStock(1, 2);
END;
/

-----------------------------------------------------------------------------------------------------------------
BEGIN
    DeleteCustomer(4);
END;
/

-----------------------------------------------------------------------------------------------------------------
SELECT GetTotalSales(2) FROM dual;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, SellerID, Quantity, Subtotal) 
VALUES (3, 3, 2, 2, 50, 13.81);
