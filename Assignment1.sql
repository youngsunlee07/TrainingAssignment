USE AdventureWorks2019
GO 

--1.
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product 

--2.
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product 
WHERE ListPrice != 0 

--3. 
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product 
WHERE Color IS NULL 

--4. 
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product 
WHERE Color IS NOT NULL 

--5. 
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product 
WHERE Color IS NOT NULL AND ListPrice > 0 

--6. 
SELECT Name + ' ' + Color AS NameColor
FROM Production.Product
WHERE Color IS NOT NULL 

--7. 
SELECT 'NAME: ' + Name + '  --  COLOR: ' + Color AS NameColor
FROM Production.Product
WHERE (Name = 'LL Crankarm' AND Color = 'Black')
   OR (Name = 'ML Crankarm' AND Color = 'Black')
   OR (Name = 'HL Crankarm' AND Color = 'Black')
   OR (Name = 'Chainring Bolts' AND Color = 'Silver')
   OR (Name = 'Chainring Nut' AND Color = 'Silver')
   OR (Name = 'Chainring' AND Color = 'Black') 
ORDER BY 
    CASE 
        WHEN Name = 'LL Crankarm' THEN 1
        WHEN Name = 'ML Crankarm' THEN 2
        WHEN Name = 'HL Crankarm' THEN 3
        WHEN Name = 'Chainring Bolts' THEN 4
        WHEN Name = 'Chainring Nut' THEN 5
        WHEN Name = 'Chainring' THEN 6
    END;

--8. 
SELECT ProductID, Name  
FROM Production.Product 
WHERE ProductID BETWEEN 400 AND 500 

--9. 
SELECT ProductID, Name, Color  
FROM Production.Product 
WHERE Color IN ('black', 'blue')

--10. 
SELECT ProductID, Name, Color  
FROM Production.Product 
WHERE Name LIKE 'S%' 

--11. 
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'Seat%' OR Name LIKE 'Short-Sleeve Classic Jersey%'
ORDER BY Name 

--12. 
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'A%' OR Name LIKE 'S%'
ORDER BY Name 

--13. 
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY Name

--14. 
SELECT DISTINCT Color 
FROM Production.Product 
WHERE Color IS NOT NULL
ORDER BY Color DESC 

























