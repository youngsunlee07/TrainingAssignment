USE Northwind
GO 

--1.
SELECT DISTINCT e.City
FROM Employees e JOIN Customers c ON e.City = c.City

--2a. 
SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e ON c.City = e.City 
WHERE e.City IS NULL  

--2b. 
SELECT DISTINCT c.City
FROM Customers c
WHERE c.City NOT IN (SELECT DISTINCT e.City FROM Employees e WHERE e.City IS NOT NULL)

--3. 
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM [Order Details] 
GROUP BY ProductID

--4. 
SELECT c.City, COUNT(od.ProductID) AS TotalProductsOrdered
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City 

--5. 
SELECT City, COUNT(CustomerID) AS NumCustomers
FROM Customers 
GROUP BY City 
HAVING COUNT(CustomerID) >= 2

--6. 
SELECT c.City, COUNT(DISTINCT od.ProductID) AS KindsOfProducts
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City 
HAVING COUNT(DISTINCT od.ProductID) >= 2

--7. 
SELECT c.CustomerID, c.City AS CustomerCity, o.ShipCity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE c.City != o.ShipCity

--8. 
WITH ProductTotalQuantity AS (
    SELECT od.ProductID, SUM(od.Quantity) AS TotalQuantity, AVG(od.UnitPrice) AS AveragePrice
    FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY od.ProductID
),
TopProducts AS (
    SELECT TOP 5 ProductID, TotalQuantity, AveragePrice
    FROM ProductTotalQuantity
    ORDER BY TotalQuantity DESC
),
RankedCities AS (
    SELECT od.ProductID, c.City, SUM(od.Quantity) AS CityQuantity,
           ROW_NUMBER() OVER (PARTITION BY od.ProductID ORDER BY SUM(od.Quantity) DESC) AS Rank
    FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY od.ProductID, c.City
)
SELECT tp.ProductID, tp.AveragePrice, rc.City AS TopCustomerCity
FROM TopProducts tp JOIN RankedCities rc ON tp.ProductID = rc.ProductID
WHERE rc.Rank = 1 

--9a.
SELECT DISTINCT City
FROM Employees
WHERE City NOT IN (
    SELECT DISTINCT ShipCity
    FROM Orders
)

--9b. 
SELECT DISTINCT e.City
FROM Employees e LEFT JOIN Orders o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL 

--10. 
WITH EmployeeOrderCount AS (
    SELECT e.City AS EmployeeCity, COUNT(o.OrderID) AS OrderCount
    FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
),
TopEmployeeCity AS (
    SELECT TOP 1 EmployeeCity
    FROM EmployeeOrderCount
    ORDER BY OrderCount DESC
),
CityTotalQuantity AS (
    SELECT o.ShipCity AS OrderCity, SUM(od.Quantity) AS TotalQuantity
    FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY o.ShipCity
),
TopQuantityCity AS (
    SELECT TOP 1 OrderCity
    FROM CityTotalQuantity
    ORDER BY TotalQuantity DESC
)
SELECT tec.EmployeeCity
FROM TopEmployeeCity tec JOIN TopQuantityCity tqc ON tec.EmployeeCity = tqc.OrderCity

--11. 
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY ALL_COLUMNS ORDER BY (SELECT 0)) AS row_num
    FROM Customers
)
DELETE FROM CTE
WHERE row_num > 1;

