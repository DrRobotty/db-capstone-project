use mydb

CREATE VIEW OrdersView AS SELECT OrderID, Quantity, BillAmount FROM Orders WHERE Quantity > 2;

SELECT * FROM OrdersView;

SELECT Customers.CustomerID, Customers.FullName, Orders.OrderID, Orders.Cost, Menus.Name, MenuItems.CourseName, MenuItems.StarterName
FROM Orders INNER JOIN Menus ON Orders.MenuID = Menus.MenuID INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN MenuItems ON Menus.MenuItemsID = MenuItems.MenuItemsID;

SELECT MenuName FROM Menus WHERE ANY(SELECT Quantity FROM Orders WHERE Quantity > 2);



INSERT INTO Bookings(BookingID, BookingDate, TableNumber, CustomerID) VALUES 
(1, '2022-10-10', 5, 1),
(2, '2022-10-10', 3, 3),
(3, '2022-10-11',2, 2),
(4, '2022-10-13', 2, 1);

DELIMITER //
CREATE PROCEDURE CheckBooking(IN CheckDate DATE, IN CheckTable INT, OUT CheckStatus VARCHAR(20))
BEGIN
DECLARE Temp INT;
SELECT BooingID INTO Temp FROM Bookings WHERE TableNumber = CheckDate AND TableNumber = CheckTable;

IF Temp = NULL THEN SET CheckStatus = "Table is Available";
ELSE SET CheckStatus = "Table not available";
END IF;
END //
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    END IF;
END$$

DELIMITER ;