
CREATE FUNCTION dbo.CalculateRentalCostAndDuration (
    @CarID INT,
    @StartDate DATETIME,
    @EndDate DATETIME,
    @InsuranceName NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN (
    SELECT @CarID as Car_ID,
	@InsuranceName as InsuranceName, 
        DATEDIFF(HOUR, @StartDate, @EndDate) AS DurationInHours,
        CASE 
            WHEN @InsuranceName = 'Basic' THEN (DATEDIFF(HOUR, @StartDate, @EndDate) * c.RateHour) + i.Premium
            WHEN @InsuranceName = 'Medium' THEN (DATEDIFF(HOUR, @StartDate, @EndDate) * c.RateHour) + (i.Premium )
            WHEN @InsuranceName = 'Premium' THEN (DATEDIFF(HOUR, @StartDate, @EndDate) * c.RateHour) + (i.Premium)
        END AS TotalCost
    FROM
        FleetRental.dbo.Car c
    INNER JOIN
        FleetRental.dbo.Rental_Insurance i ON i.Insurance_Name = @InsuranceName
    WHERE
        c.Car_ID = @CarID
);

GO

SELECT * FROM dbo.CalculateRentalCostAndDuration(1, '2024-04-10 08:00:00', '2024-04-11 08:00:00', 'PREMIUM');

GO