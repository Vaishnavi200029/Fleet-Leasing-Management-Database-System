
--This will give the available cars for the given time frame

CREATE PROCEDURE GetAvailableCars
(
    @StartDate DATETIME,
    @EndDate DATETIME
)
AS
BEGIN
    SELECT
        c.Car_ID,
        c.VIN,
        c.Model_Name,
        c.Make,
        c.Year,
        c.Color,
        c.Mileage,
        c.RateHour,
		s.Start_Date as Available_Date,
		s.Availability_Status
    FROM
        Car c
    INNER JOIN
        Car_Schedule s ON c.Car_ID = s.Car_ID
    WHERE
        s.Availability_Status = 'Available'
        AND (@StartDate BETWEEN s.Start_Date AND s.End_Date
            OR @EndDate BETWEEN s.Start_Date AND s.End_Date
            OR (s.Start_Date BETWEEN @StartDate AND @EndDate 
                AND s.End_Date BETWEEN @StartDate AND @EndDate))
	ORDER BY Available_Date DESC
END
GO

-- This is how we use the [GetAvailableCars] procedure

DECLARE @StartDateTime DATETIME = '2020-12-10 08:00:00';
DECLARE @EndDateTime DATETIME = '2024-12-10 18:00:00';

EXEC [FleetRental].[dbo].[GetAvailableCars] @StartDateTime, @EndDateTime;


GO


CREATE PROCEDURE GetBookedCars
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT
        C.Car_ID,
        C.VIN,
        C.Model_Name,
        C.Make,
        C.Year,
        C.Color,
        C.Mileage,
        C.RateHour,
        CS.Start_Date AS Booking_Start_Date,
        CS.End_Date AS Booking_End_Date,
        CS.Availability_Status AS Booking_Status
    FROM
        [FleetRental].[dbo].[Car] C
    INNER JOIN
        [FleetRental].[dbo].[Car_Schedule] CS ON C.Car_ID = CS.Car_ID
    WHERE
        CS.Availability_Status = 'Reserved'
        AND CS.Start_Date <= @EndDate
        AND CS.End_Date >= @StartDate;
END;
GO

--DECLARE @StartTime DATETIME;
--DECLARE @EndTime DATETIME;

--SET @StartTime = '2023-06-05 09:00:00';
--SET @EndTime = '2023-09-07 18:00:00';

EXEC GetBookedCars '2020-06-05 09:00:00', '2024-09-07 18:00:00';
GO

--This procedure will generate a Invoice for the user

CREATE PROCEDURE GenerateReservationReport
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT
        R.Reservation_ID,
        U.Name AS Customer_Name,
        U.Contact_Number AS Customer_Contact,
        Ca.Model_Name AS Car_Model,
        Ca.Make AS Car_Make,
        Ca.Color AS Car_Color,
        R.Pickup_Date,
        R.Return_Date,
        RI.Insurance_Name,
        RI.Premium AS Insurance_Premium,
        P.Amount AS Payment_Amount,
        P.Payment_Date,
        P.Payment_Method,
        P.Payment_Status
    FROM
        Reservation R
    INNER JOIN
        [dbo].[Customer] C ON R.Customer_ID = C.Customer_ID
    INNER JOIN
        [dbo].[User] U ON C.Customer_ID = U.User_ID
    INNER JOIN
        [dbo].[Car_Schedule] CS ON R.Schedule_ID = CS.Schedule_ID
    INNER JOIN
        [dbo].[Car] Ca ON CS.Car_ID = Ca.Car_ID
    LEFT JOIN
        [dbo].[Rental_Insurance] RI ON R.Insurance_ID = RI.Insurance_ID
    LEFT JOIN
        [dbo].[Payment] P ON R.Reservation_ID = P.Reservation_ID
    WHERE
        R.Pickup_Date BETWEEN @StartDate AND @EndDate
    ORDER BY
        R.Pickup_Date;
END;

----------------------------
DECLARE @StartDate DATETIME = '2023-05-01'; -- Start date
DECLARE @EndDate DATETIME = '2023-12-31';   -- End date

EXEC GenerateReservationReport @StartDate, @EndDate;


















