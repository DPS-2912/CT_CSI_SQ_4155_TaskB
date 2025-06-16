CREATE VIEW MyProducts AS
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    ISNULL(p.Size, '') + ' ' + CAST(p.Weight AS VARCHAR) AS QuantityPerUnit, 
    p.ListPrice AS UnitPrice,
    s.Name AS CompanyName,
    c.Name AS CategoryName
FROM [AdventureWorks2019].[Production].[Product] p
JOIN [AdventureWorks2019].[Production].[ProductSubcategory] sub ON p.ProductSubcategoryID = sub.ProductSubcategoryID
JOIN [AdventureWorks2019].[Production].[ProductCategory] c ON sub.ProductCategoryID = c.ProductCategoryID
JOIN [AdventureWorks2019].[Purchasing].[ProductVendor] pv ON p.ProductID = pv.ProductID
JOIN [AdventureWorks2019].[Purchasing].[Vendor] s ON pv.BusinessEntityID = s.BusinessEntityID
WHERE p.DiscontinuedDate IS NULL OR p.DiscontinuedDate > GETDATE();
