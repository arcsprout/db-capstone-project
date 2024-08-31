SELECT * FROM littlelemondb.bookings;

CREATE PROCEDURE CheckBooking(IN BookingDate DATE, IN TableNumber INT)
SELECT CONCAT('Table ', TableNumber, ' is already booked') as Booking_status
WHERE exists (SELECT 'Table ' + TableNumber + ' is already booked' FROM Bookings where BookingDate = BookingDate and TableNumber = TableNumber);

CREATE PROCEDURE `LittleLemonDB`.`CheckBooking`(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE table_status VARCHAR(50);

    SELECT COUNT(*) INTO @table_count
    FROM `LittleLemonDB`.`Bookings`
    WHERE `Date` = booking_date AND `TableNumber` = table_number;

    IF (@table_count > 0) THEN
        SET table_status = 'Table is already booked.';
    ELSE
        SET table_status = 'Table is available.';
    END IF;

    SELECT table_status AS 'Table Status';
END;

Call CheckBooking('2022-11-12', 3);

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN new_booking_date DATE, IN new_table_number INT, IN new_customer_id INT)
BEGIN
    DECLARE table_status INT;
    START TRANSACTION;

    SELECT COUNT(*) INTO table_status
    FROM Bookings
    WHERE BookingDate = new_booking_date AND TableNumber = new_table_number;

    IF (table_status > 0) THEN
        ROLLBACK;
        SELECT 'Booking could not be completed. Table is already booked on the specified date.' AS 'Status';
    ELSE
        INSERT INTO Bookings(`BookingDate`, `TableNumber`, `CustomerID`)
        VALUES(new_booking_date, new_table_number, new_customer_id);

        COMMIT;
        SELECT 'Booking completed successfully.' AS 'Status';
    END IF;
END //

DELIMITER ;

call AddValidBooking('2022-12-17', 6, 3);

DELIMITER //
CREATE PROCEDURE AddBooking (IN BookingID INT, IN CustomerID INT, IN TableNumber INT, IN BookingDate DATE)
BEGIN
INSERT INTO bookings (bookingid, customerid, tablenumber, bookingdate) VALUES (BookingID, CustomerID, TableNumber, BookingDate); 
SELECT 'New Booking Added.' AS 'Confirmation';
END //
DELIMITER ;

call AddBooking(10, 3, 4, '2022-12-30');

DELIMITER //
CREATE PROCEDURE UpdateBooking (IN BookingID INT, IN BookingDate DATE)
BEGIN
UPDATE bookings SET bookingdate = BookingDate WHERE bookingid = BookingID; 
SELECT CONCAT('Booking ', bookingid, ' updated') as confirmation;
END //
DELIMITER ;

call UpdateBooking(9, '2022-12-17');