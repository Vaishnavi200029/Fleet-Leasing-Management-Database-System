CREATE VIEW [Car_Availability_View] 
AS
SELECT cs.Car_ID, c.Model_Name, c.Make, cs.Start_Date, cs.End_Date, cs.Availability_Status
FROM Car_Schedule cs 
JOIN Car c ON cs.Car_ID = c.Car_ID;
 

CREATE VIEW CustomerReservationsView AS
SELECT r.Reservation_ID, 
       u.Name AS Customer_Name, 
       u.Contact_Number AS Customer_Contact,
       cr.Model_Name, 
       cr.Make, 
       r.Pickup_Date, 
       r.Return_Date, 
       r.Cost
FROM Reservation r
JOIN [User] u ON r.Customer_ID = u.User_ID
JOIN Car cr ON r.Schedule_ID = cr.Car_ID;


CREATE VIEW MaintenanceLogsView AS
SELECT ml.Maintenance_ID, 
       c.Model_Name, 
       c.Make, 
       ml.Maintenance_Type, 
       ml.Maintenance_Date, 
       ml.Cost, 
       ml.Description
FROM Maintenance_Log ml
JOIN Car c ON ml.Car_ID = c.Car_ID;


SELECT * FROM Car_Availability_View;
SELECT * FROM CustomerReservationsView;
SELECT * FROM  MaintenanceLogsView;