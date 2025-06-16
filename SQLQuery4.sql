CREATE or ALTER PROCEDURE DeleteOrderDetails
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    /*order id exists*/
    IF NOT EXISTS (
        SELECT 1
        FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
        WHERE SalesOrderID = @OrderID
    )
    BEGIN
        PRINT 'Error: OrderID ' + CAST(@OrderID AS VARCHAR) + ' does not exist.';
        RETURN -1;
    END

    /*product exists*/
    IF NOT EXISTS (
        SELECT 1
        FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
        WHERE SalesOrderID = @OrderID AND ProductID = @ProductID
    )
    BEGIN
        PRINT 'Error: ProductID ' + CAST(@ProductID AS VARCHAR) + ' does not exist in OrderID ' + CAST(@OrderID AS VARCHAR) + '.';
        RETURN -1;
    END

    /*delete order*/
    DELETE FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;

    PRINT 'Order detail deleted successfully.';
END
