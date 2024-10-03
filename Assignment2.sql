USE AdventureWorks2019
GO 

--1.
SELECT COUNT(DISTINCT ProductID)
FROM Production.Product

--2.
SELECT COUNT(DISTINCT ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL 

--3. 
SELECT ProductSubcategoryID, COUNT(DISTINCT ProductID) AS TheCount
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL 
GROUP BY ProductSubcategoryID

--4. 
SELECT COUNT(DISTINCT ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NULL 

--5. 
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory 
GROUP BY ProductID

--6. 
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY ProductID 
HAVING SUM(Quantity) < 100

--7. 
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY Shelf, ProductID 
HAVING SUM(Quantity) < 100

--8. 
SELECT ProductID, AVG(Quantity) AS TheAvg  
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID 

--9. 
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg  
FROM Production.ProductInventory
GROUP BY ProductID, Shelf 

--10. 
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg  
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf 

--11. 
SELECT Color, Class, COUNT(ProductID) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL 
GROUP BY Color, Class

--12. 
SELECT c.Name AS Country, s.Name AS Province 
FROM person.CountryRegion c INNER JOIN person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode

--13. 
SELECT c.Name AS Country, s.Name AS Province 
FROM person.CountryRegion c JOIN person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name in ('Germany', 'Canada')

USE Northwind
GO 

--14. 
SELECT d.ProductID 
FROM Orders o JOIN [Order Details] d ON o.OrderID = d.OrderID 
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE()) AND d.Quantity >= 1 

--15. 
SELECT TOP 5 o.ShipPostalCode AS ZipCode, SUM(d.UnitPrice * d.Quantity) AS TotalSales
FROM Orders o JOIN [Order Details] d ON o.OrderID = d.OrderID 
WHERE o.ShipPostalCode IS NOT NULL
GROUP BY o.ShipPostalCode 
ORDER BY TotalSales DESC; 

--16. 
SELECT TOP 5 o.ShipPostalCode AS ZipCode, SUM(d.UnitPrice * d.Quantity) AS TotalSales
FROM Orders o JOIN [Order Details] d ON o.OrderID = d.OrderID 
WHERE o.ShipPostalCode IS NOT NULL AND o.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY o.ShipPostalCode 
ORDER BY TotalSales DESC; 

--17. 
SELECT City, COUNT(CustomerID) AS NumCustomer
FROM Customers 
GROUP BY City 

--18. 
SELECT City, COUNT(CustomerID) AS NumCustomer
FROM Customers 
GROUP BY City 
HAVING COUNT(CustomerID) > 2

--19. 
SELECT c.CompanyName 
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderDate >= '1998-01-01' 

--20. 
SELECT c.CompanyName, MAX(o.OrderDate) AS RecentOrder
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
GROUP BY c.CompanyName
ORDER BY RecentOrder DESC 

--21. 
SELECT c.CompanyName, SUM(d.Quantity) AS Quantity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN [Order Details] d ON o.OrderID = d.OrderID 
GROUP BY c.CompanyName

--22. 
SELECT c.CustomerID, SUM(d.Quantity) AS Quantity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN [Order Details] d ON o.OrderID = d.OrderID 
GROUP BY c.CustomerID
HAVING SUM(d.Quantity) > 100 

--23. 
SELECT s.CompanyName AS [Supplier Company Name], sh.CompanyName AS [Shipper Company Name]
FROM Suppliers s JOIN Products p ON s.SupplierID = p.SupplierID
JOIN [Order Details] d ON p.ProductID = d.ProductID
JOIN Orders o ON d.OrderID = o.OrderID
JOIN Shippers sh ON o.ShipVia = sh.ShipperID
GROUP BY s.CompanyName, sh.CompanyName
ORDER BY s.CompanyName, sh.CompanyName 

--24. 
SELECT o.OrderDate, p.ProductName
FROM Orders o JOIN [Order Details] d ON o.OrderID = d.OrderID 
JOIN Products p ON d.ProductID = p.ProductID 
ORDER BY o.OrderDate, p.ProductName 

--25. 
SELECT e.FirstName + ' ' + e.LastName AS E1, m.FirstName + ' ' + m.LastName AS E2
FROM Employees e JOIN Employees m ON e.Title = m.Title
WHERE e.EmployeeID < m.EmployeeID 

--26. 
SELECT m.FirstName + ' ' + m.LastName AS ManagerName, COUNT(e.EmployeeID) AS NumEmployees
FROM Employees e JOIN Employees m ON e.ReportsTo = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) > 2 

--27. 
SELECT City, CompanyName AS Name, ContactName, 'Customer' AS Type
FROM Customers
UNION
SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS Type
FROM Suppliers
ORDER BY City, Type 









