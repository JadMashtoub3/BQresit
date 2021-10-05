--Jad Mashtoub
--103596586
/*
Organisation(OrgID, OrganisationName)
PK (OrgID)

Client(ClientID, Name, Phone)
PK (ClientID)

MenuItem(ItemID, Description, ServesPerUnit, UnitPrice)
PK (ItemID)

Order(ClientID, DateTimePlaced, DeliveryAddress)
PK (ClientID, DateTimePlaced)
FK (ClientID) REFERENCES Client(ClientID)

OrderLine(ItemId, ClientID, DateTimePlaced, Qty)
PK (ItemID, ClientID, DateTimePlaced)
FK (ClientID, DateTimePlaced) references Order(ClientID, DateTimePlaced)
FK (ItemID) REFERENCES Item(ItemID)
*/
USE MASTER
GO

-- Create a new database called 'BuildQuery'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'BuildQuery'
)
CREATE DATABASE BuildQuery
GO

USE BuildQuery

IF OBJECT_ID('OrderLine', 'U') IS NOT NULL
DROP TABLE OrderLine
GO
IF OBJECT_ID('MenuItem', 'U') IS NOT NULL
DROP TABLE MenuItem

IF OBJECT_ID('Order', 'U') IS NOT NULL
DROP TABLE [Order]
GO
GO
IF OBJECT_ID('Client', 'U') IS NOT NULL
DROP TABLE Client
GO
IF OBJECT_ID('Organisation', 'U') IS NOT NULL
DROP TABLE Organisation
GO
CREATE TABLE Organisation
(
    OrgId [NVARCHAR] (4) PRIMARY KEY,
    OrganisationName [NVARCHAR] (200)  NOT NULL UNIQUE,
);

CREATE TABLE Client
(
    ClientID INT PRIMARY KEY,
    Name [NVARCHAR] (100) NOT NULL,
    Phone [NVARCHAR] (15) NOT NULL UNIQUE,
    OrgID [NVARCHAR] (4),
    FOREIGN KEY (OrgID) REFERENCES ORGANISATION
);

CREATE TABLE MenuItem
(
    ItemID INT PRIMARY KEY,
    Description [NVARCHAR] (100) NOT NULL UNIQUE,
    ServesPerUnit INT NOT NULL,
    UnitPrice MONEY NOT NULL,
    CONSTRAINT check_ServesPerUnit CHECK (ServesPerUnit > 0)
);

CREATE TABLE [Order]
(
    ClientID INT,
    FOREIGN KEY (ClientID) REFERENCES Client,
    OrderDate DATE,
    DeliveryAddress [NVARCHAR] (MAX) NOT NULL
    PRIMARY KEY (ClientID, OrderDate)
);

CREATE TABLE OrderLine
(
    ItemID INT,
    FOREIGN KEY (ItemID) REFERENCES MenuItem,
    ClientID INT,
    OrderDate DATE,
    Qty INT NOT NULL,
    PRIMARY KEY(ItemID, ClientID, OrderDate),
    FOREIGN KEY (ClientID, OrderDate) References [ORDER],
    CONSTRAINT check_Qty CHECK (Qty > 0)
);

select * from Organisation
Select * from Client
Select * from MenuItem
select * from [Order]
select * from OrderLine

Insert INTO Organisation (OrgId, OrganisationName)
VALUES ('DODG',	'Dod & Gy Widget Importers'),
       ('SWUT',	'Swinburne University of Technology');

Insert INTO Client (ClientID, Name, Phone, OrgID)
VALUES ('12',	'James Hallinan',	'(03)5555-1234',	'SWUT'),
        ('15',	'Any Nguyen',	'(03)5555-2345',	'DODG'),
        ('18',	'Karen Mok',	'(03)5555-3456',	'SWUT'),
        ('21',	'Tim Baird',	'(03)5555-4567',	'DODG');

Insert INTO MenuItem (ItemID, [Description], ServesPerUnit, UnitPrice)
VALUES  ('3214',	'Tropical Pizza - Large', 2, $16.00 ),
        ('3216',	'Tropical Pizza - Small',	1,	 $12.00), 
        ('3218',	'Tropical Pizza - Family',	4,	 $23.00), 
        ('4325',	'Can - Coke Zero',	1,	 $2.50), 
        ('4326',	'Can - Lemonade',	1,	 $2.50), 
        ('4327',	'Can - Harden Up',	1,	 $7.50)

Insert INTO [Order] (ClientID, OrderDate, DeliveryAddress)
VALUES  ('12',	'2021/09/20',	'Room TB225 - SUT - 1 John Street, Hawthorn, 3122'),
        ('21',	'2021/09/14',	'Room ATC009 - SUT - 1 John Street, Hawthorn, 3122'),
        ('21',	'2021/09/27',  'Room TB225 - SUT - 1 John Street, Hawthorn, 3122'),
        ('15',	'2021/09/20',	'The George - 1 John Street, Hawthorn, 3122'),
        ('18',	'2021/09/30',	'Room TB225 - SUT - 1 John Street, Hawthorn, 3122')


INSERT INTO OrderLine (ITEMID, CLIENTID, ORDERDATE, QTY) VALUES
        (3216, 12, '2021/9/20', 2),
        (4326, 12, '2021/9/20', 1),
        (3218, 21, '2021/9/14', 1),
        (3214, 21, '2021/9/14', 1),
        (4325, 21, '2021/9/14', 4),
        (4327, 21, '2021/9/14', 2),
        (3216, 21, '2021/9/27', 1),
        (4327, 21, '2021/9/27', 1),
        (3218, 21, '2021/9/27', 2),
        (3216, 15, '2021/9/20', 2),
        (4326, 15, '2021/9/20', 1),
        (3216, 18, '2021/9/30', 1),
        (4327, 18, '2021/9/30', 1);

        select * from Organisation
Select * from Client
Select * from MenuItem
select * from [Order]
select * from OrderLine

GO