CREATE TRIGGER tr_CheckStockBeforeInsert
ON Sales.SalesOrderDetail
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    /*check for insufficient stocks*/
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        JOIN [AdventureWorks2019].[Production].[ProductInventory] pi ON i.ProductID = pi.ProductID
        GROUP BY i.ProductID
        HAVING SUM(i.OrderQty) > MAX(pi.Quantity)
    )
    BEGIN
        RAISERROR('Insufficient stock for one or more products. Order aborted.', 16, 1);
        RETURN;
    END;

    /*insertion*/
    INSERT INTO [AdventureWorks2019].[Sales].[SalesOrderDetail] (
        SalesOrderID, ProductID, OrderQty, UnitPrice, UnitPriceDiscount, rowguid, ModifiedDate
    )
    SELECT 
        SalesOrderID, ProductID, OrderQty, UnitPrice, UnitPriceDiscount, rowguid, ModifiedDate
    FROM INSERTED;

    /*updation in inventory*/
    UPDATE pi
    SET pi.Quantity = pi.Quantity - i.OrderQty
    FROM [AdventureWorks2019].[Production].[ProductInventory] pi
    JOIN INSERTED i ON pi.ProductID = i.ProductID;
END;
