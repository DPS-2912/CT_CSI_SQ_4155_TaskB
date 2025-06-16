CREATE or ALTER PROCEDURE GetOrderDetails
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;

    /*check for a match and display records*/
    IF EXISTS (
        SELECT 1
        FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
        WHERE SalesOrderID = @OrderID
    )
    BEGIN
        SELECT *
        FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
        WHERE SalesOrderID = @OrderID;
    END
    ELSE
    BEGIN        
        PRINT 'The OrderID ' + CAST(@OrderID AS VARCHAR) + ' does not exist'; /*no macth found*/
        RETURN 1;
    END
END
