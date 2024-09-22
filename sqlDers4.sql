--1. En Pahalı Ürünü Getirin
SELECT productid, productname, unitprice
From Products
where unitprice = 
(
  SELECT MAX(unitprice)
  FROM Products
 )
	                
--2. En Son Verilen Siparişi Bulun -- son orderdaki ürünlerin hepsi
SELECT p.ProductID, o.OrderID, o.OrderDate
from OrderDetails od
JOIN Orders o ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
where o.OrderDate =
(
  SELECT MAX(Orders.OrderDate)
  FROM Orders
 )
 
--3. Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin
SELECT productid, productname, unitprice
from Products
WHERE unitprice >
(
  SELECT AVG(unitprice)
  FROM Products
  )

--4. Belirli Kategorilerdeki Ürünleri Listeleyin
SELECT c.CategoryID, c.categoryname, p.productname
from Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
where c.CategoryID = 
(
  SELECT c2.CategoryID
  from Categories c2
  where c2.CategoryName= 'Beverages'
)

--5. En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin
select p.CategoryID, p.ProductID, p.UnitPrice, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.UnitPrice =
(
  SELECT MAX(unitprice) from Products
  WHERE Products.CategoryID = p.CategoryID
)
Order BY c.CategoryID

--6. Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin
SELECT o.OrderID, o.CustomerID, cu.Country
FROM Orders o
JOIN Customers cu ON o.CustomerID = cu.CustomerID
WHERE cu.Country = 'Germany' 

--7. Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin
SELECT Categories.CategoryID, Products.ProductID, Products.UnitPrice
from Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice > 
(
  SELECT AVG(Products.UnitPrice) from Products
  WHERE Products.CategoryID = Products.CategoryID
  )
ORDER BY Categories.CategoryID

--8. Her Müşterinin En Son Verdiği Siparişi Listeleyin ?
SELECT o.CustomerID, o.OrderID, o.OrderDate
FROM Orders o
JOIN (
  SELECT customerid, MAX(orderdate) AS MaxOrderDate
  FROM Orders
  GROUP BY CustomerID
) AS lastOrder ON o.CustomerID = lastOrder.CustomerID AND o.OrderDate = lastOrder.MaxOrderDate
ORDER BY o.CustomerID

--9. Her Çalışanın Kendi Departmanındaki Ortalama Maaşın Üzerinde Maaş Alıp Almadığını Bulun

--10. En Az 10 Ürün Satın Alınan Siparişleri Listeleyin
SELECT o.OrderID, o.CustomerID
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.CustomerID
HAVING COUNT(od.ProductID) >= 10;

--11. Her Kategoride En Pahalı Olan Ürünlerin Ortalama Fiyatını Bulun
SELECT Categories.CategoryID, AVG(avgPrice.maxPrice) AS AveragePrice
from Categories
JOIN
(
  SELECT categoryid, MAX(unitprice) AS maxPrice 
  from Products
  GROUP by categoryid
  ) as avgPrice
  on Categories.CategoryID = avgPrice.CategoryID
GROUP by Categories.CategoryID
 
--12. Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın
SELECT COUNT(orderid)AS [total orders], customerid 
from Orders
GROUP by customerid
ORDER BY  [total orders]

--13. En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin'
SELECT COUNT(o.OrderID) AS [total orders], c.CustomerID, MAX(o.OrderDate) AS [Last Orders]
from Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP by c.CustomerID
ORDER BY  [total orders] DESC
LIMIT 5

--14. Toplam Ürün Sayısı 7'den Fazla Olan Kategorileri Listeleyin
SELECT ca.CategoryID, COUNT(p.ProductID) AS totalProducts
FROM Products p
JOIN Categories ca ON p.CategoryID = ca.CategoryID
GROUP by ca.CategoryID
HAVING totalProducts > 7

--15. En Fazla 5 Farklı Ürün Sipariş Eden Müşterileri Listeleyin
SELECT COUNT(DISTINCT (od.ProductID)) AS ProductNumber, c.CustomerID
from Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP by c.CustomerID
HAVING ProductNumber <= 77

--16. 3 ve 3'ten Fazla Ürün Sağlayan Tedarikçileri Listeleyin
select s.SupplierID, COUNT(pr.ProductID) AS totalProducts
from Suppliers s
JOIN Products pr ON s.SupplierID = pr.SupplierID
GROUP by s.SupplierID
HAVING totalProducts >= 3

--17. Her Müşteri İçin En Pahalı Ürünü Bulun	?
SELECT cu.CustomerID, od.ProductID, od.UnitPrice
FROM Orders o
JOIN Customers cu ON o.CustomerID = cu.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE (cu.CustomerID, od.UnitPrice) IN (
  SELECT cu2.CustomerID, MAX(od2.UnitPrice)
  FROM Orders o2
  JOIN Customers cu2 ON o2.CustomerID = cu2.CustomerID
  JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
  GROUP BY cu2.CustomerID, od.ProductID, od.UnitPrice
)

--18. 1.720.000'den Fazla Sipariş Değeri Olan Çalışanları Listeleyin
SELECT e.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName) AS FullName, totalOrders.TotalOrderValue
FROM Employees e
JOIN (
    SELECT o.EmployeeID, SUM(od.Quantity * od.UnitPrice) AS TotalOrderValue
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY o.EmployeeID
) AS totalOrders ON e.EmployeeID = totalOrders.EmployeeID
WHERE totalOrders.TotalOrderValue > 49500000
ORDER BY e.EmployeeID


--19. Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun
SELECT ca.CategoryID, p.ProductID, SUM(od.Quantity)
from Categories ca
JOIN Products p ON ca.CategoryID = p.CategoryID
JOIn OrderDetails od ON p.ProductID = od.ProductID
GROUP by ca.CategoryID, p.ProductID
HAVING SUM(od.Quantity) = 
(
  SELECT MAX(TotalQuantity)
    FROM (
        SELECT SUM(od_inner.Quantity) AS TotalQuantity
        FROM Products p_inner
        JOIN OrderDetails od_inner ON p_inner.ProductID = od_inner.ProductID
        WHERE p_inner.CategoryID = ca.CategoryID
        GROUP BY p_inner.ProductID
    ) AS SubQuery
)
ORDER BY ca.CategoryID;

--20. Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin
SELECT o.CustomerID, od.ProductID, o.OrderDate
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.OrderDate = (
    SELECT MAX(OrderDate)
    FROM Orders
    WHERE CustomerID = o.CustomerID
)
ORDER BY o.CustomerID;

--21. Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin_?
select Employees.EmployeeID, Orders.OrderDate, SUM(OrderDetails.UnitPrice * OrderDetails.Quantity) AS MostExpensiveOrder
from Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails On Orders.OrderID = OrderDetails.OrderID
GROUP by Employees.EmployeeID, Orders.OrderDate
HAVING MostExpensiveOrder =
(
  SELECT MAX(SUM(OrderDetails.UnitPrice * OrderDetails.Quantity)) 
  from Orders
  JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
  GROUP by Orders.OrderID
  )
order by Employees.EmployeeID

--22. En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 1;
