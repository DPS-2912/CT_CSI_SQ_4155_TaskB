CREATE or Alter TRIGGER tr_DeleteSalesOrderAndDetails
ON [AdventureWorks2019].[Sales].[SalesOrderHeader]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    /*delete from salesOrderDetail*/
    DELETE FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM DELETED);

    /*dlete from salesOrderHeader*/
    DELETE FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM DELETED);
END;
