DECLARE
    CURSOR order_cursor IS
    SELECT order_id, customer_id, total_amount FROM Orders;

    v_order order_cursor%ROWTYPE;
BEGIN
    IF NOT order_cursor%ISOPEN THEN
        OPEN order_cursor;
    END IF;

    LOOP
        FETCH order_cursor INTO v_order;
        EXIT WHEN order_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Order ID:' || v_order.order_id || ', Customer ID: ' || v_order.customer_id || ', Total Amount: ' || v_order.total_amount);
    END LOOP;

    IF order_cursor%ISOPEN THEN
        CLOSE order_cursor;
    END IF;
END;
/

DECLARE
    CURSOR order_cursor IS
    SELECT order_id, customer_id, total_amount
    FROM Orders;

    v_order order_cursor%ROWTYPE;
BEGIN
    OPEN order_cursor;

    LOOP
        FETCH order_cursor INTO v_order;
        EXIT WHEN order_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Order ID:' || v_order.order_id || ', Customer ID: ' || v_order.customer_id || ', Total Amount: ' || v_order.total_amount);
    END LOOP;

    CLOSE order_cursor;
END;
/

DECLARE
    CURSOR order_cursor(p_customer_id NUMBER) IS
        SELECT order_id, order_date, total_amount, status FROM Orders
        WHERE customer_id = p_customer_id;

BEGIN
    FOR order_rec IN order_cursor(10)
    LOOP
        v_order_id := order_rec.order_id;
        v_order_date := order_rec.order_date;
        v_total_amount := order_rec.total_amount;
        v_status := order_rec.status;

        DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_order_id || ', Date: ' || v_order_date || ', Total: ' || v_total_amount || ', Status: ' || v_status); 
    END LOOP;
END;
/

-- Cursor with %ROWCOUNT and %NOTFOUND
DECLARE
    CURSOR c_product_cursor IS
    SELECT product_id, name, price FROM Product
    WHERE price > 50
    ORDER BY price DESC;

    v_product_record c_product_cursor%ROWTYPE;
BEGIN
    OPEN c_product_cursor;
    LOOP
        FETCH c_product_cursor INTO v_product_record;
        EXIT WHEN c_product_cursor%ROWCOUNT > 5 OR c_product_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_product_record.product_id || ' ' || v_product_record.name || '&' || v_product_record.price);
    END LOOP;
    CLOSE c_product_cursor;
END;
/

-- Update cursor 
DECLARE
    CURSOR order_cursor IS
        SELECT O.order_id, C.first_name || ' ' || C.last_name AS customer_name, O.status, P.amount FROM Orders O
        JOIN Customer C ON O.customer_id = C.customer_id
        JOIN Payment P ON O.order_id = P.order_id WHERE O.status = 'Pending'
        FOR UPDATE OF O.status;
    v_order_id Orders.order_id%TYPE;
    v_customer_name VARCHAR2(101);
    v_status Orders.status%TYPE;
    v_amount Payment.amount%TYPE;
BEGIN
    OPEN order_cursor;
    LOOP
        FETCH order_cursor INTO v_order_id, v_customer_name, v_status, v_amount;
        EXIT WHEN order_cursor%NOTFOUND;
        IF v_amount IS NOT NULL AND v_amount >= 500 THEN
            UPDATE Orders
            SET status = 'Completed'
            WHERE order_id = v_order_id;
            DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_order_id || 'Update Completed');
        END IF;
    END LOOP;
    CLOSE order_cursor;
END;
/