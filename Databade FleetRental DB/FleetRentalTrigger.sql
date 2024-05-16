-- DML Trigger to Update Car Availability
CREATE TRIGGER trg_BookCar
ON [FleetRental].[dbo].[Reservation]
AFTER INSERT
AS

BEGIN
    SET NOCOUNT ON;

    DECLARE @CarID INT, @PickupDate DATETIME, @ReturnDate DATETIME;

    SELECT 
        @CarID = r.Car_ID,
        @PickupDate = i.Pickup_Date,
        @ReturnDate = i.Return_Date
    FROM inserted i
    JOIN [FleetRental].[dbo].[Car_Schedule] r ON i.Schedule_ID = r.Schedule_ID;

    BEGIN TRY
        -- Update Car availability status to 'Reserved' if available
        UPDATE [FleetRental].[dbo].[Car_Schedule]
        SET Availability_Status = 'Reserved'
        WHERE Car_ID = @CarID
        AND Availability_Status = 'Available';

        -- Insert pickup and return entries into the Car_Schedule table
        INSERT INTO [FleetRental].[dbo].[Car_Schedule] (Car_ID, Start_Date, End_Date, Availability_Status)
        VALUES (@CarID, @PickupDate, @ReturnDate, 'Reserved');
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE(); -- Print the error message if an error occurs during the transaction.
    END CATCH;
END;




SELECT * FROM Reservation

INSERT INTO [FleetRental].[dbo].[Reservation] (Schedule_ID, Customer_ID, Insurance_ID, Pickup_Date, Return_Date, Cost)
VALUES
(6, 6, 2, '2023-11-05 08:00:00', '2023-11-08 08:00:00', 150.00),
(2, 2, 2, '2024-04-11 10:00:00', '2024-04-13 14:00:00', 200.00); 

SELECT * FROM Reservation
SELECT * FROM Car_Schedule

DELETE from Reservation WHERE Reservation_ID = 33;
DELETE from Car_Schedule WHERE Schedule_ID = 28;


