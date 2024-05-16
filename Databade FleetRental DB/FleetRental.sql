-- Create the database
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'FleetRental')
    DROP DATABASE FleetRental;
GO

-- Create database FleetRental;
Create database FleetRental
USE FleetRental;
GO

-- User Table
CREATE TABLE [FleetRental].[dbo].[User] (
    [User_ID] INT PRIMARY KEY IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [Password] VARBINARY(MAX) NOT NULL,
    [User_Role] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) UNIQUE NOT NULL ,
    [Contact_Number] NVARCHAR (15)UNIQUE NOT NULL
);
GO

-- Car Table
CREATE TABLE [FleetRental].[dbo].[Car] (
    Car_ID INT PRIMARY KEY IDENTITY(1,1),
    VIN NVARCHAR(17) UNIQUE NOT NULL,
    Model_Name NVARCHAR(100) NOT NULL,
    Make NVARCHAR(50) NOT NULL,
    Year INT CHECK (Year > 1900 AND Year <= YEAR(GETDATE())),
    Color NVARCHAR(50) NOT NULL,
    Mileage INT CHECK (Mileage >= 0) NOT NULL,
    RateHour DECIMAL(10, 2) CHECK (RateHour >= 0) NOT NULL
);
GO

-- Car Lender Table 

CREATE TABLE [FleetRental].[dbo].[Car_Lender] (
    Lender_ID INT NOT NULL,
    Car_ID INT NOT NULL,
    CONSTRAINT PK_Car_Lender PRIMARY KEY (Lender_ID, Car_ID),
    CONSTRAINT FK_Car_Lender_Lender FOREIGN KEY (Lender_ID) REFERENCES [User](User_ID),
    CONSTRAINT FK_Car_Lender_Car FOREIGN KEY (Car_ID) REFERENCES Car(Car_ID)
);
GO


-- Administration Table
CREATE TABLE [FleetRental].[dbo].[Administration] (
    Admin_ID INT PRIMARY KEY,
	CONSTRAINT FK_Admin_User FOREIGN KEY (Admin_ID) REFERENCES [User](User_ID)
);
GO

-- Customer Table
CREATE TABLE [FleetRental].[dbo].[Customer] (
    Customer_ID INT PRIMARY KEY,
    CONSTRAINT FK_Customer_User FOREIGN KEY (Customer_ID) REFERENCES [User](User_ID),
    Registration_Date DATE NOT NULL,
    License_Number NVARCHAR(50) UNIQUE NOT NULL
);
GO

-- Car Availability Table
--CREATE TABLE [FleetRental].[dbo].[Car_Availability] (
   -- Availability_ID INT PRIMARY KEY IDENTITY(1,1),
   -- Car_ID INT FOREIGN KEY REFERENCES Car(Car_ID),
   -- Availability_Status NVARCHAR(50) CHECK (Availability_Status IN ('Available', 'Reserved', 'Maintenance', 'Out of Service'))
--);
--GO

-- Schedule Table
CREATE TABLE [FleetRental].[dbo].[Car_Schedule] (
    Schedule_ID INT PRIMARY KEY IDENTITY(1,1),
    Car_ID INT FOREIGN KEY REFERENCES Car(Car_ID),
    [Start_Date] DATETIME NOT NULL,
    End_Date DATETIME NOT NULL,
	Availability_Status NVARCHAR(50) CHECK (Availability_Status IN ('Available', 'Reserved', 'Maintenance', 'Out of Service'))
);
GO

-- Maintenance Log Table
CREATE TABLE [FleetRental].[dbo].[Maintenance_Log] (
    Maintenance_ID INT PRIMARY KEY IDENTITY(1,1),
    Car_ID INT FOREIGN KEY REFERENCES Car(Car_ID) NOT NULL,
    Maintenance_Type NVARCHAR(100) CHECK (Maintenance_Type IN ('Service', 'Repair')) NOT NULL, --ADD SOME MORE
    Maintenance_Date DATE NOT NULL,
    Cost DECIMAL(10, 2) CHECK (Cost >= 0) NOT NULL,
    Description NVARCHAR(500) NOT NULL
);
GO
-- Rental Insurance Table 
-- TO DO
CREATE TABLE [FleetRental].[dbo].[Rental_Insurance] (
    Insurance_ID INT PRIMARY KEY IDENTITY(1,1),
    Insurance_Name NVARCHAR(100) NOT NULL CHECK (Insurance_Name IN ('Basic', 'Medium', 'Premium')),
    Premium DECIMAL(10, 2) CHECK (Premium >= 0) NOT NULL
);
GO

-- Reservation Table
CREATE TABLE [FleetRental].[dbo].[Reservation] (
    Reservation_ID INT PRIMARY KEY IDENTITY(1,1),
    Schedule_ID INT FOREIGN KEY REFERENCES Car_Schedule(Schedule_ID) NOT NULL,
    Customer_ID INT FOREIGN KEY REFERENCES Customer(Customer_ID) NOT NULL,
    Insurance_ID INT FOREIGN KEY REFERENCES Rental_Insurance(Insurance_ID), 
    Pickup_Date DATETIME NOT NULL,
    Return_Date DATETIME NOT NULL, 
    Cost DECIMAL(10, 2) CHECK (Cost >= 0) NOT NULL,
    CONSTRAINT CHK_Pickup_Return_Date CHECK (Pickup_Date < Return_Date) 
);
GO


-- Payment Table
CREATE TABLE [FleetRental].[dbo].[Payment] (
    Payment_ID INT PRIMARY KEY IDENTITY(1,1),
    Reservation_ID INT FOREIGN KEY REFERENCES Reservation(Reservation_ID) NOT NULL,
    Amount DECIMAL(10, 2) CHECK (Amount >= 0) NOT NULL,
    Payment_Date DATETIME NOT NULL,
    Payment_Method NVARCHAR(50) CHECK (Payment_Method IN ('Credit', 'Debit', 'Cash')) NOT NULL,
    Payment_Status NVARCHAR(50) CHECK (Payment_Status IN ('Success', 'Pending', 'Failed')) NOT NULL
);
GO

-- Feedback Table
CREATE TABLE [FleetRental].[dbo].[Feedback] (
    Feedback_ID INT PRIMARY KEY IDENTITY(1,1),
    Car_ID INT FOREIGN KEY REFERENCES Car(Car_ID) NOT NULL,
    Customer_ID INT FOREIGN KEY REFERENCES [Customer](Customer_ID) NOT NULL,
    Feedback_Date DATETIME NULL,
    Comments NVARCHAR(1000) NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5) NULL
);
GO

Select *from [user]
Select *from Car
Select *from Reservation

Delete from [User]
where User_ID = 38

Delete from Car
where Car_ID =29

SELECT COUNT(*) AS CarsCount FROM [dbo].[Car]

SELECT COUNT(*) AS ReservationCount FROM [dbo].[Reservation]



