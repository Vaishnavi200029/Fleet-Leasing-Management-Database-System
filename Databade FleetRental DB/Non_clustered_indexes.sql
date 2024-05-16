CREATE NONCLUSTERED INDEX IX_Car_Schedule_Availability
ON [Car_Schedule] (Car_ID, Availability_Status);

CREATE NONCLUSTERED INDEX IX_Reservation_Customer_PickupDate
ON Reservation (Customer_ID, Pickup_Date);

CREATE NONCLUSTERED INDEX IX_Maintenance_Log_Car_ID
ON Maintenance_Log (Car_ID);