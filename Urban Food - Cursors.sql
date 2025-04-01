-- A cursor is used to fetch multiple rows one by one from a query result

-- Cursor to view high demand products 
CREATE OR REPLACE PROCEDURE GetHighDemandProducts(p_min_orders IN NUMBER) AS
    CURSOR high_demand_cursor IS
        SELECT P.ProductID, P.Name, COUNT(OD.OrderDetailID) AS OrderCount
        FROM Products P
        JOIN OrderDetails OD ON P.ProductID = OD.ProductID
        GROUP BY P.ProductID, P.Name
        HAVING COUNT(OD.OrderDetailID) > p_min_orders;

    v_ProductID NUMBER;
    v_Name VARCHAR2(255);
    v_OrderCount NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('High-Demand Products:');
    
    OPEN high_demand_cursor;
    LOOP
        FETCH high_demand_cursor INTO v_ProductID, v_Name, v_OrderCount;
        EXIT WHEN high_demand_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_ProductID || ', Name: ' || v_Name || ', Orders: ' || v_OrderCount);
    END LOOP;
    
    CLOSE high_demand_cursor;
END;
/

EXEC GetHighDemandProducts(1);

-----------------------------------------------------------------------------------------------------------------
-- Cursor to process pending deliveries status into Out For Delivery status 
CREATE OR REPLACE PROCEDURE ProcessPendingDeliveries AS
    CURSOR pending_deliveries_cursor IS
        SELECT DeliveryID FROM Deliveries WHERE DeliveryStatus = 'Pending';

    v_DeliveryID NUMBER;
BEGIN
    OPEN pending_deliveries_cursor;
    LOOP
        FETCH pending_deliveries_cursor INTO v_DeliveryID;
        EXIT WHEN pending_deliveries_cursor%NOTFOUND;

        UPDATE Deliveries SET DeliveryStatus = 'Out for Delivery' WHERE DeliveryID = v_DeliveryID;
    END LOOP;
    
    CLOSE pending_deliveries_cursor;
    COMMIT;
END;
/
-- Note: This converts every 'Pending' deliveries into 'Out for Delivery' status 

EXEC ProcessPendingDeliveries;