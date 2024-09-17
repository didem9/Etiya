--1
--SELECT * FROM Products 
--where supplierid BETWEEN 1 and 5

--2
--SELECT * FROM Products 
--where supplierid IN (1,2,3,4,5)
--3
--SELECT * FROM Products 
--where productname = 'Chang' or productname = 'Aniseed Syrup'

--4
--SELECT * FROM Products 
--where supplierid = 3 or unitprice > 10

--5
--SELECT productname || ' ' || unitprice FROM Products 

--6
--SELECT UPPER(productname) FROM Products 
--where productname LIKE '%C%'

--7
SELECT * FROM Products
WHERE productname LIKE 'n%'

--8
--SELECT * FROM Products 
--where unitsinstock > 50

--9
--SELECT MIN(unitprice) FROM Products 
--SELECT MAX(unitprice) FROM Products 

--10
--SELECT * FROM Products
--where productname LIKE '%Spice%'




