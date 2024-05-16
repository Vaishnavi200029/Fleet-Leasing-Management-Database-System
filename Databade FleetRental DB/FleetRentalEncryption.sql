
Use FleetRental

create MASTER KEY
ENCRYPTION BY PASSWORD = 'damg6210';

SELECT name KeyName,
symmetric_key_id KeyID,
key_length KeyLength,
algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;
go

CREATE CERTIFICATE UserPass
WITH SUBJECT = 'Employee Sample Password';
GO

CREATE SYMMETRIC KEY UserPass_SM
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE UserPass;
GO

OPEN SYMMETRIC KEY UserPass_SM
DECRYPTION BY CERTIFICATE UserPass;

UPDATE dbo.[User] set [Password] = EncryptByKey(Key_GUID('UserPass_SM'), convert(varbinary,[Password]) )
GO

OPEN SYMMETRIC KEY UserPass_SM
DECRYPTION BY CERTIFICATE UserPass;
SELECT *,
CONVERT(varchar, DecryptByKey([Password]))
AS 'Decrypted password'
FROM dbo.[User];
GO

Select * from [user]