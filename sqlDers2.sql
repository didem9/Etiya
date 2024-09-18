--1
select categoryid, Count(productid) AS [Total Product Number] from Products
GROUP BY categoryid;

--2
select * from Products
order BY unitprice DESC
LIMIT 5;

--3
Select supplierid, AVG(unitprice) From Products
GROUP by supplierid 

--4
select categoryid, AVG(unitprice)from Products
where unitprice > 100
GROUP by categoryid

--5
SELECT unitprice, quantity, (unitprice * quantity) AS [Total Sale] from 'Order Details'
where (unitprice * quantity) > 1000

--6
SELECT OrderID, shippeddate FROM Orders
ORDER BY ShippedDate DESC
LIMIT 10;

--7
SELECT AVG(unitprice) FROM Products

--8
SELECT SUM(unitsinstock) AS [Total Stock Amount] FROM Products
WHERE unitprice > 50

--9
select MIN(orderdate) from Orders

--10
SELECT employeeid, hiredate, (CURRENT_DATE - hiredate) AS [Years Ago] from Employees

--11
SELECT orderid, ROUND(SUM(unitprice),2) AS [Average price] FROM 'Order Details'
GROUP By orderid

--12
SELECT COUNT(unitsinstock) AS [Total Stock Amount] from Products

--13
SELECT productid, unitprice AS Price from Products
where unitprice = (SELECT MIN(unitprice) AS [Minimum Price] FROM Products)
	OR unitprice = (SELECT MAX(unitprice) AS [Maximum Price] FROM Products)
    
--14

--15 
select firstname ||' '|| lastname AS [Full Name] from Employees

--16
select customerid, city, LENGTH(city) from Customers

--17
select productname, unitprice, ROUND(unitprice,2) from Products

--18
SELECT COUNT(*) AS [Total Orders] from Orders

--19
SELECT categoryid, AVG(unitprice) AS [Average Price] FROM Products
group by categoryid

--20
select (COUNT(*) * 100.0/ (select COUNT(*) from Orders)) AS Percentage from Orders
where shippeddate ISNULL

--21
SELECT productid, (MAX(unitprice) * 1.10) AS [Maximum Price] from Products

--22
select productname, SUBSTRING(ProductName, 1, 3) AS [First Three Characters] FROM Products

--23
select COUNT(orderdate) from Orders
--?

--24
SELECT ROUND(SUM(unitprice* quantity), 2)from 'Order Details'
GROUP by orderid, productid

--25
select SUM(unitprice) from Products
where unitsinstock=0
