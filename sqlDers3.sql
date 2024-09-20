--1. Verilen Customers ve Orders tablolarını kullanarak, Customers tablosundaki müşterileri ve 
--onların verdikleri siparişleri birleştirerek listeleyin. Müşteri adı, sipariş ID'si ve sipariş tarihini gösterin.

SELECT Customers.CompanyName AS [Customer Name], Orders.OrderID, Orders.OrderDate
from Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID

--2 Verilen Suppliers ve Products tablolarını kullanarak tüm tedarikçileri 
--ve onların sağladıkları ürünleri listeleyin. Eğer bir tedarikçinin ürünü yoksa, NULL olarak gösterilsin.

SELECT  Products.ProductID, Products.ProductName, Products.SupplierID, Suppliers.CompanyName
from Products
RIGHT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID

--3. Verilen Employees ve Orders tablolarını kullanarak tüm siparişleri ve bu siparişleri işleyen çalışanları listeleyin. 
--Eğer bir sipariş bir çalışan tarafından işlenmediyse, çalışan bilgileri NULL olarak gösterilsin.

SELECT   Orders.OrderID, Employees.EmployeeID, Employees.FirstName, Employees.LastName
FROM Orders
Left JOIN Employees on  Orders.EmployeeID = Employees.EmployeeID

--4. Verilen Customers ve Orders tablolarını kullanarak tüm müşterileri ve tüm siparişleri listeleyin. 
--Sipariş vermeyen müşteriler ve müşterisi olmayan siparişler için NULL döndürün.

SELECT Orders.OrderID, Customers.CustomerID
from Customers
FULL OUTER JOIN Orders on Customers.CustomerID = Orders.CustomerID

--5.Verilen Products ve Categories tablolarını kullanarak tüm ürünler ve tüm kategoriler için olası tüm kombinasyonları listeleyin. 
Sonuç kümesindeki her satır bir ürün ve bir kategori kombinasyonunu göstermelidir.

SELECT Categories.CategoryID, Products.ProductID
from Categories
CROSS JOIN Products

--6.Verilen Orders, Customers, Employees tablolarını kullanarak bu tabloları birleştirin
--ve 1998 yılında verilen siparişleri listeleyin.Müşteri adı, sipariş ID'si, sipariş tarihi ve ilgili çalışan adı gösterilsin.

SELECT Customers.CompanyName AS [Customer Name],
		Orders.OrderID, Orders.OrderDate,
        Employees.FirstName , Employees.LastName
from Orders
left JOIN Customers on Orders.CustomerID = Customers.CustomerID
LEFT JOIN Employees on Orders.EmployeeID = Employees.EmployeeID
WHERE strftime('%Y',Orders.OrderDate) = 1998

--7. Verilen Orders ve Customers tablolarını kullanarak müşterileri, verdikleri sipariş sayısına göre gruplandırın.
--Sadece 5’ten fazla sipariş veren müşterileri listeleyin.

SELECT Customers.CustomerID, COUNT(Orders.OrderID) AS [Total Orders]
from Customers
left JOIN Orders on Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID
ORDER by [Total Orders] DESC

--8.Verilen OrderDetails ve Products tablolarını kullanarak her ürün için kaç adet satıldığını ve toplam satış miktarını listeleyin.
Ürün adı, satılan toplam adet ve toplam kazancı (Quantity * UnitPrice) gösterin.

SELECT Products.ProductID, 
	SUM(OrderDetails.Quantity) AS [Total Quantity], 
    SUM(OrderDetails.Quantity * Products.UnitPrice) AS [Total Sales]
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductID
ORDER BY Products.ProductID;

--9.Verilen Customers ve Orders tablolarını kullanarak,
müşteri adı "B" harfiyle başlayan müşterilerin siparişlerini listeleyin.

SELECT Orders.OrderID, Customers.CompanyName AS [Customer Name]
from Customers
JOIN Orders On Customers.CustomerID = Orders.CustomerID
where [Customer Name] LIKE 'B%'

--10. Verilen Products ve Categories tablolarını kullanarak tüm kategorileri listeleyin 
ve ürünleri olmayan kategorileri bulun. Ürün adı NULL olan satırları gösterin.

select Categories.CategoryID, Products.ProductID, Products.ProductName
from Products
LEFT JOIN Categories on Products.CategoryID = Categories.CategoryID
WHERE Products.ProductName ISNULL

--11. Verilen Employees tablosunu kullanarak her çalışanın yöneticisiyle birlikte bir liste oluşturun.
SELECT e1.EmployeeID,
	CONCAT(e1.FirstName, ' ', e1.LastName) as "Çalışan",
	CONCAT(e2.FirstName, ' ', e2.LastName) as "Yöneticisi" 
FROM Employees e1
join Employees e2 on e1.ReportsTo = e2.EmployeeID

--12. Verilen Products tablosunu kullanarak her kategorideki en pahalı ürünleri 
ve bu ürünlerin farklı fiyatlara sahip olup olmadığını sorgulayın. ??

SELECT categoryid, productid, MAX(unitprice) from Products
GROUP by categoryid

--13. Verilen Orders ve OrderDetails tablolarını kullanarak bu tabloları birleştirin
--ve her siparişin detaylarını sipariş ID'sine göre artan sırada listeleyin.

select OrderDetails.*
from OrderDetails
LEFT JOIN Orders on Orders.OrderID = OrderDetails.OrderID
order by Orders.OrderID ASC

--14. Verilen Employees ve Orders tablolarını kullanarak her çalışanın kaç tane sipariş işlediğini listeleyin. 
Sipariş işlemeyen çalışanlar da gösterilsin.

SELECT Employees.EmployeeID, Employees.FirstName, COUNT(Orders.OrderID)
from Orders
left JOIN Employees on Orders.EmployeeID = Employees.EmployeeID
group by Employees.EmployeeID, Employees.FirstName

--15.Verilen Products tablosunu kullanarak bir kategorideki ürünleri kendi arasında fiyatlarına göre karşılaştırın
ve fiyatı düşük olan ürünleri listeleyin. ??
	
SELECT categoryid, productid, MIN(unitprice) -- bir kategorideki en düşük fiyatlı ürün
from Products
GROUP by categoryid

--16. Verilen Products ve Suppliers tablolarını kullanarak tedarikçiden alınan en pahalı ürünleri listeleyin.

SELECT Suppliers.SupplierID, Products.ProductID, MAX(Products.UnitPrice)
FROM Products
JOIN Suppliers on Products.SupplierID = Suppliers.SupplierID
GROUP by Suppliers.SupplierID
order by Products.UnitPrice DESC

--17. Verilen Employees ve Orders tablolarını kullanarak her çalışanın işlediği en son siparişi bulun.

SELECT Employees.EmployeeID, Orders.OrderID, MAX(Orders.OrderDate)
from Employees
JOIN Orders on Employees.EmployeeID = Orders.EmployeeID
GROUP by Employees.EmployeeID

--18. Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve fiyatı 20 birimden fazla olan 
ürünlerin sayısını listeleyin.

SELECT COUNT(productid) AS [Number of Products > 20], categoryid, unitprice
from Products
group by unitprice
HAVING unitprice > 20

--19.Verilen Orders ve Customers tablolarını kullanarak 1997 ile 1998 yılları arasında verilen siparişleri 
müşteri adıyla birlikte listeleyin.
SELECT Orders.OrderID, Customers.CustomerID, Customers.CompanyName
from Orders
JOIN Customers on Orders.CustomerID = Customers.CustomerID
WHERE strftime('%Y', Orders.OrderDate) BETWEEN '2012' and '2014'

--20.Verilen Customers ve Orders tablolarını kullanarak hiç sipariş vermeyen müşterileri listeleyin.
select Customers.CustomerID
from Customers
LEFT JOIN Orders on Customers.CustomerID = Orders.CustomerID
where Orders.OrderID ISNULL





