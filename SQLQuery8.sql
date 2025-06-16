CREATE VIEW vwCustomerOrders_Yesterday AS
SELECT 
    s.Name AS CompanyName,
    o.SalesOrderID AS OrderID,
    o.OrderDate,
    od.ProductID,
    p.Name AS ProductName,
    od.OrderQty AS Quantity,
    od.UnitPrice,
    od.OrderQty * od.UnitPrice AS TotalPrice
FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] o
JOIN [AdventureWorks2019].[Sales].[SalesOrderDetail] od ON o.SalesOrderID = od.SalesOrderID
JOIN [AdventureWorks2019].[Production].[Product] p ON od.ProductID = p.ProductID
JOIN [AdventureWorks2019].[Sales].[Customer] c ON o.CustomerID = c.CustomerID
JOIN [AdventureWorks2019].[Sales].[Store] s ON c.StoreID = s.BusinessEntityID
WHERE c.StoreID IS NOT NULL
  AND CAST(o.OrderDate AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE);
