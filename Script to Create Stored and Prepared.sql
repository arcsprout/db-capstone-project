CREATE PROCEDURE GetMaxQuantity()
SELECT max(quantity) AS "Max Quantity in Order" FROM orders;

PREPARE GetOrderDetail FROM 
'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';

DELIMITER //

CREATE PROCEDURE CancelOrder(IN orderId INT)
BEGIN
    DELETE FROM Orders WHERE OrderID = orderId;
END //

DELIMITER ;

CALL GetMaxQuantity();

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

Call CancelOrder(5);