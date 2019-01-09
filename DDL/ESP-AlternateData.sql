/* **********************************************
 * Emergency Service & Product
 * Specification Document 1
 * Sample Data
 ********************************************** */
/** This script adds some data to a table, for demo purposes **/
USE [ESP-A01]
GO
-- Clean out old information
DELETE FROM OrderDetails
DELETE FROM InventoryItems
DELETE FROM Orders
DELETE FROM Customers
GO

-- Add Customer Information
INSERT INTO Customers(FirstName, LastName, [Address], City, Province, PostalCode, PhoneNumber)
    VALUES('Fred', 'Smith', '123 SomeWhere St.', 'Edmonton', 'AB', 'T5H2J9', '(780)436-7867')
INSERT INTO Customers(FirstName, LastName, [Address], City, Province, PostalCode, PhoneNumber)
    VALUES('Gill', 'Thomas', '456 ElseWhere Ave.', 'Edmonton', 'AB', 'T5H3R4', '(780)982-7234')
INSERT INTO Customers(FirstName, LastName, [Address], City, Province, PostalCode, PhoneNumber)
    VALUES('Henry', 'Unger', '7810-72 St.', 'Edmonton', 'AB', 'T5G1B7', '(780)444-0915')
GO

-- Add InventoryItems
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('H23', 'Heater Fan Belt - 23"', 11.99, 5, 3)
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('H29', 'Heater Fan Belt - 29"', 12.49, 7, 4)
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('H35', 'Heater Fan Belt - 35"', 12.99, 3, 2)
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('H319', 'Heater Fan Belt Support Brackets', 4.99, 10, 12)
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('M24', 'Bolts - 24 mm', 0.29, 53, 50)
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('M26', 'Bolts - 26 mm', 0.29, 48, 50)
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('M28', 'Bolts - 28 mm', 0.29, 50, 50)
GO

-- Add a customer order (with details)
INSERT INTO Orders(CustomerNumber, [Date], Subtotal, GST)
    VALUES((SELECT CustomerNumber FROM Customers WHERE LastName = 'Smith'),
            CAST('2012-01-16' AS date), 24.29, 1.70)

INSERT INTO OrderDetails(OrderNumber, ItemNumber, Quantity, SellingPrice)
    SELECT OrderNumber, ItemNumber, 1, CurrentSalePrice
    FROM   Orders, InventoryItems
    WHERE  ItemNumber = 'H23'
INSERT INTO OrderDetails(OrderNumber, ItemNumber, Quantity, SellingPrice)
    SELECT OrderNumber, ItemNumber, 1, CurrentSalePrice
    FROM   Orders, InventoryItems
    WHERE  ItemNumber = 'H319'
INSERT INTO OrderDetails(OrderNumber, ItemNumber, Quantity, SellingPrice)
    SELECT OrderNumber, ItemNumber, 1, CurrentSalePrice
    FROM   Orders, InventoryItems
    WHERE  ItemNumber = 'M24'

GO