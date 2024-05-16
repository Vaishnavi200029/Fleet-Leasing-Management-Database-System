-- Sample data for User Table
INSERT INTO [FleetRental].[dbo].[User] ([Name], [Password], [User_Role], [Email], [Contact_Number]) 
VALUES 
    ('John Doe', CONVERT(varbinary, 'password123'), 'Admin', 'john.doe@example.com', '1234567890'),
    ('Jane Smith', CONVERT(varbinary, 'pass456'), 'Customer', 'jane.smith@example.com', '9876543210'),
    ('Bob Johnson', CONVERT(varbinary, 'bobpass'), 'Car Lender', 'bob.johnson@example.com', '5554443333'),
    ('Emily Brown', CONVERT(varbinary, 'emilypass'), 'Customer', 'emily.brown@example.com', '1112223333'),
    ('David Lee', CONVERT(varbinary, 'davidpass'), 'Customer', 'david.lee@example.com', '4445556666'),
    ('Sarah Adams', CONVERT(varbinary, 'sarahpass'), 'Admin', 'sarah.adams@example.com', '7778889999'),
    ('Michael Clark', CONVERT(varbinary, 'michaelpass'), 'Car Lender', 'michael.clark@example.com', '2223334444'),
    ('Jennifer Hall',CONVERT(varbinary, 'jenniferpass') , 'Customer', 'jennifer.hall@example.com', '6667778888'),
    ('Ryan Wilson',CONVERT(varbinary, 'ryanpass') , 'Admin', 'ryan.wilson@example.com', '9998887777'),
    ('Amanda Martinez',CONVERT(varbinary, 'amandapass') , 'Customer', 'amanda.martinez@example.com', '3332221111');

-- Sample data for Car Table
INSERT INTO [FleetRental].[dbo].[Car] (VIN, Model_Name, Make, Year, Color, Mileage, RateHour) 
VALUES 
    ('1HGCM82633A004352', 'Civic', 'Honda', 2019, 'Blue', 30000, 15.00),
    ('1GKFK16Z34J263823', 'Escalade', 'Cadillac', 2020, 'Black', 25000, 25.00),
    ('1G1YY22G0Y5123456', 'Corvette', 'Chevrolet', 2021, 'Red', 15000, 35.00),
    ('1C4RJFAG0CC357951', 'Grand Cherokee', 'Jeep', 2018, 'Silver', 40000, 20.00),
    ('2C3CDXHG1FH867530', 'Challenger', 'Dodge', 2017, 'White', 35000, 30.00),
    ('1FTEW1EF5FFC25168', 'F-150', 'Ford', 2016, 'Black', 50000, 25.00),
    ('1N4AL2AP3BN415263', 'Altima', 'Nissan', 2019, 'Gray', 28000, 18.00),
    ('5XXGM4A7XFG333333', 'Optima', 'Kia', 2018, 'Blue', 32000, 17.00),
    ('1FTSX21565EB36468', 'F-250', 'Ford', 2020, 'White', 20000, 30.00),
    ('1G1BE5SM8K7256312', 'Malibu', 'Chevrolet', 2022, 'Silver', 10000, 20.00);

-- Sample data for Car_Lender Table
INSERT INTO [FleetRental].[dbo].[Car_Lender] (Lender_ID, Car_ID) 
VALUES 
    (3, 1),
    (7, 2),
    (7, 3),
    (10, 4),
    (4, 5),
    (10, 6),
    (3, 7),
    (4, 8),
    (3, 9),
    (7, 10);

-- Sample data for Administration Table
INSERT INTO [FleetRental].[dbo].[Administration] (Admin_ID) 
VALUES 
    (1),
    (5),
    (9);

-- Sample data for Customer Table
INSERT INTO [FleetRental].[dbo].[Customer] (Customer_ID, Registration_Date, License_Number) 
VALUES 
    (2, '2023-01-15', 'ABCD123456789'),
    (4, '2022-07-20', 'EFGH987654321'),
    (5, '2023-03-10', 'IJKL567890123'),
    (8, '2022-12-05', 'MNOP345678901'),
    (10, '2023-05-01', 'QRST123456789'),
    (6, '2023-08-15', 'UVWX987654321'),
    (3, '2023-10-20', 'YZAB567890123'),
    (7, '2023-02-28', 'CDEF345678901'),
    (9, '2022-11-10', 'GHIJ123456789'),
    (1, '2022-05-15', 'LMNO987654321');


-- Sample data for Maintenance_Log Table
INSERT INTO [FleetRental].[dbo].[Maintenance_Log] (Car_ID, Maintenance_Type, Maintenance_Date, Cost, Description) 
VALUES 
    (3, 'Service', '2023-08-10', 150.00, 'Regular maintenance checkup'),
    (8, 'Repair', '2023-05-20', 300.00, 'Replacement of damaged parts'),
    (2, 'Service', '2023-02-05', 120.00, 'Oil change and filter replacement'),
    (7, 'Repair', '2022-10-15', 250.00, 'Brake system repair'),
    (5, 'Service', '2023-04-18', 180.00, 'Wheel alignment and balancing'),
    (10, 'Repair', '2022-12-28', 200.00, 'Engine overhaul'),
    (9, 'Service', '2023-09-10', 100.00, 'Tire replacement'),
    (4, 'Repair', '2023-01-25', 350.00, 'Transmission repair'),
    (1, 'Service', '2023-07-03', 200.00, 'Coolant system flush'),
    (6, 'Repair', '2023-11-12', 280.00, 'Suspension repair');

-- Sample data for Car_Schedule Table
INSERT INTO [FleetRental].[dbo].[Car_Schedule] (Car_ID, [Start_Date], End_Date, Availability_Status) 
VALUES 
    (1, '2023-07-05 09:00:00', '2023-07-07 09:00:00', 'Available'),
    (2, '2023-08-20 10:30:00', '2023-08-25 10:30:00', 'Available'),
    (3, '2023-10-10 12:00:00', '2023-10-15 12:00:00', 'Maintenance'),
    (4, '2023-09-15 14:00:00', '2023-09-18 14:00:00', 'Out of Service'),
    (5, '2023-06-25 16:30:00', '2023-06-28 16:30:00', 'Reserved'),
    (6, '2023-11-05 08:00:00', '2023-11-08 08:00:00', 'Available'),
    (7, '2023-03-15 11:00:00', '2023-03-18 11:00:00', 'Reserved'),
    (8, '2023-05-20 13:30:00', '2023-05-25 13:30:00', 'Maintenance'),
    (9, '2023-12-10 15:00:00', '2023-12-15 15:00:00', 'Available'),
    (10, '2023-04-30 17:00:00', '2023-05-03 17:00:00', 'Reserved'),
	(1, '2023-09-01 09:00:00', '2023-09-05 09:00:00', 'Available'),
    (2, '2023-10-01 10:30:00', '2023-10-05 10:30:00', 'Available'),
    (3, '2023-11-01 12:00:00', '2023-11-05 12:00:00', 'Available'),
    (4, '2023-12-01 14:00:00', '2023-12-05 14:00:00', 'Available'),
    (5, '2024-01-01 16:30:00', '2024-01-05 16:30:00', 'Available'),
    (6, '2024-02-01 08:00:00', '2024-02-05 08:00:00', 'Available'),
    (7, '2024-03-01 11:00:00', '2024-03-05 11:00:00', 'Available'),
    (8, '2024-04-01 13:30:00', '2024-04-05 13:30:00', 'Available'),
    (9, '2024-05-01 15:00:00', '2024-05-05 15:00:00', 'Available'),
    (10, '2024-06-01 17:00:00', '2024-06-05 17:00:00', 'Available');


-- Sample data for Rental_Insurance Table
INSERT INTO [FleetRental].[dbo].[Rental_Insurance] (Insurance_Name, Premium) 
VALUES 
    ('Basic', 50.00),
    ('Medium', 75.00),
    ('Premium', 100.00);

-- Sample data for Reservation Table
INSERT INTO [FleetRental].[dbo].[Reservation] (Schedule_ID, Customer_ID, Insurance_ID, Pickup_Date, Return_Date, Cost) 
VALUES 
    (1, 2, 1, '2023-07-05 09:00:00', '2023-07-07 09:00:00', 90.00),
    (2, 4, 2, '2023-08-20 10:30:00', '2023-08-25 10:30:00', 375.00),
    (3, 5, 3, '2023-10-10 12:00:00', '2023-10-15 12:00:00', 600.00),
    (4, 8, NULL, '2023-09-15 14:00:00', '2023-09-18 14:00:00', 240.00),
    (5, 10, 1, '2023-06-25 16:30:00', '2023-06-28 16:30:00', 135.00),
    (6, 6, 2, '2023-11-05 08:00:00', '2023-11-08 08:00:00', 255.00),
    (7, 3, NULL, '2023-03-15 11:00:00', '2023-03-18 11:00:00', 120.00),
    (8, 7, 3, '2023-05-20 13:30:00', '2023-05-25 13:30:00', 500.00),
    (9, 9, 2, '2023-12-10 15:00:00', '2023-12-15 15:00:00', 375.00),
    (10, 1, 1, '2023-04-30 17:00:00', '2023-05-03 17:00:00', 150.00);

-- Sample data for Payment Table
INSERT INTO [FleetRental].[dbo].[Payment] (Reservation_ID, Amount, Payment_Date, Payment_Method, Payment_Status) 
VALUES 
    (1, 90.00, '2023-07-07 09:00:00', 'Credit', 'Success'),
    (2, 375.00, '2023-08-25 10:30:00', 'Debit', 'Success'),
    (3, 600.00, '2023-10-15 12:00:00', 'Cash', 'Pending'),
    (4, 240.00, '2023-09-18 14:00:00', 'Credit', 'Success'),
    (5, 135.00, '2023-06-28 16:30:00', 'Debit', 'Success'),
    (6, 255.00, '2023-11-08 08:00:00', 'Cash', 'Success'),
    (7, 120.00, '2023-03-18 11:00:00', 'Credit', 'Success'),
    (8, 500.00, '2023-05-25 13:30:00', 'Debit', 'Success'),
    (9, 375.00, '2023-12-15 15:00:00', 'Cash', 'Success'),
    (10, 150.00, '2023-05-03 17:00:00', 'Credit', 'Success');

-- Insert sample feedback data into Feedback table
INSERT INTO [FleetRental].[dbo].[Feedback] (Car_ID, Customer_ID, Feedback_Date, Comments, Rating)
VALUES 
    (1, 1, '2024-04-23', 'Great car, smooth ride!', 5),
    (2, 2, '2024-04-22', 'The car was clean and well-maintained.', 4),
    (3, 3, '2024-04-21', 'Average experience, could have been better.', 3),
    (4, 4, '2024-04-20', 'The car had some issues with the brakes.', 2),
    (5, 5, '2024-04-19', 'Excellent service, will rent again.', 5);

