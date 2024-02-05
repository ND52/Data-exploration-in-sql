--Select all the columns of all the records in the Products table:
SELECT * FROM Products

--Getting the ProductName and quantity/unit:
SELECT ProductName, QuantityPerUnit FROM Products

--Getting current Product list (Product ID and name):SELECT ProductID, ProductName FROM Products 
WHERE Discontinued = 'False'
ORDER BY ProductName;

--Getting the discontinued Product list (Product ID and name):SELECT ProductID, ProductName FROM Products 
WHERE Discontinued = 'True'
ORDER BY ProductName;

--Getting the most expensive and least expensive Product list (name and unit price):
SELECT ProductName, UnitPrice FROM Products
ORDER BY UnitPrice DESC;
SELECT ProductName, UnitPrice FROM Products
ORDER BY UnitPrice ASC;

-- Getting the Product list (id, name, unit price) where current Products cost less than $20:
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice<$20 AND Discontinued = 'False'
ORDER BY UnitPrice

--Getting the Product list (id, name, unit price) where products cost between $15 and $25:
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice BETWEEN $15 AND $25
ORDER BY UnitPrice

--Getting the Average Unit price and Product list (name, unit price) of above average price:
SELECT AVG (UnitPrice) FROM Products
SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice>28.8663
ORDER BY UnitPrice

--Getting the Product list (name, unit price) of ten most expensive Products:
SELECT TOP (10) Products.UnitPrice, ProductName AS ten_most_expensive_products
FROM Products
ORDER BY Products.UnitPrice DESC

--count of current and discontinued products:
SELECT Discontinued, COUNT(*) AS 'Number of Products'
FROM Products
GROUP BY Discontinued;

--Getting the Product list (name, units on order, units in stock) of stock is less than the quantity on order:
SELECT ProductName,  UnitsOnOrder , UnitsInStock
FROM Products
 WHERE Discontinued = 'False' AND UnitsInStock<UnitsOnOrder

 --Select all the columns of all the records in the Order Details table and calculate the subtotal for each order:
 SELECT  * from [Order Details] 
 SELECT OrderID, SUM(UnitPrice * Quantity * (1-Discount)) AS subtotal
FROM [Order Details]
GROUP BY OrderID;

--Select all the columns of all records in the Employees table and Calculate each employee’s sales amount by Country:
SELECT * FROM Employees
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Customers.Country, 
SUM([Order Details].Quantity * [Order Details].UnitPrice - ([Order Details].Quantity * [Order Details].UnitPrice * [Order Details].Discount)) 
AS Sales_Amount
FROM Employees
JOIN Orders  ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName, Customers.Country;

--Getting the alphabetical list of Products:
SELECT ProductName FROM Products order by ProductName ASC;

--Select all the columns of all records in the Categories table and calculate the total sales of Products by Category:
SELECT * FROM Categories
SELECT Categories.CategoryName, 
SUM([Order Details].Quantity * [Order Details].UnitPrice - ([Order Details].Quantity * [Order Details].UnitPrice * [Order Details].Discount)) 
AS Sales_by_Category 
FROM Categories
JOIN Products ON Products.CategoryID = Categories.CategoryID
JOIN  [Order Details]  ON Products.ProductID = [Order Details].ProductID
GROUP BY Categories.CategoryName;

--Select all the columns of all records in the Customers and Suppliers table:
SELECT * FROM Customers
SELECT * FROM Suppliers

--Getting the Customers and Suppliers by City, using Union to merge Customers and Suppliers into one result set:
SELECT 'Customer' AS Type, ContactName, City, Country
FROM Customers
UNION
SELECT 'Supplier', ContactName, City, Country
FROM Suppliers;