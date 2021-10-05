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


IF OBJECT_ID('Organisation', 'U') IS NOT NULL
DROP TABLE Organisation
GO
IF OBJECT_ID('Client', 'U') IS NOT NULL
DROP TABLE Client
GO
IF OBJECT_ID('MenuItem', 'U') IS NOT NULL
DROP TABLE MenuItem
GO
IF OBJECT_ID('Order', 'U') IS NOT NULL
DROP TABLE [Order]
GO
IF OBJECT_ID('OrderLine', 'U') IS NOT NULL
DROP TABLE OrderLine
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
    CONSTRAINT FK_ClientID FOREIGN KEY (ClientID, OrderDate)
    REFERENCES [Order] (ClientID, OrderDate),
    CONSTRAINT check_Qty CHECK (Qty > 0)
);

select * from Organisation
Select * from Client
Select * from MenuItem
select * from [Order]
select * from OrderLine
GO