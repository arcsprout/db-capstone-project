CREATE VIEW OrdersView AS
SELECT 
OrderID, 
Quantity, 
TotalCost

FROM orders

WHERE Quantity > 2;

CREATE VIEW Task2View AS
SELECT 
customers.CustomerID, 
customers.Names, 
orders.OrderID, 
orders.TotalCost, 
menus.MenuID, 
menus.starters,
menus.CourseName

FROM customerdetails customers 
INNER JOIN orders
ON customers.CustomerID = orders.customerID

INNER JOIN menu menus ON menus.OrderID = orders.OrderID 

WHERE TotalCost > 150  

ORDER BY TotalCost;

CREATE VIEW Task3View AS
SELECT Menus.MenuID
FROM Menu Menus
WHERE Menus.OrderID = ANY (
    SELECT Orders.OrderID
    FROM Orders
    GROUP BY Orders.OrderID
    HAVING COUNT(*) > 2
);