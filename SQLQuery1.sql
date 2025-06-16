CREATE OR ALTER PROCEDURE InsertOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity SMALLINT,
    @Discount FLOAT = 0
AS
BEGIN
    SET NOCOUNT ON; /* Disable the default return message*/
    
        DECLARE @AvailableStock INT;
        DECLARE @ReorderLevel INT;
        DECLARE @Price MONEY;
        DECLARE @NewStock INT;

        /*1. getting stock info*/
        SELECT 
            @AvailableStock = pi.Quantity,
            @ReorderLevel = p.ReorderPoint,
            @Price = ISNULL(@UnitPrice, p.ListPrice)
        FROM [AdventureWorks2019].[Production].[ProductInventory] pi
        INNER JOIN [AdventureWorks2019].[Production].[Product] p ON p.ProductID = pi.ProductID
        WHERE pi.ProductID = @ProductID;

        /*check stock*/
        IF @AvailableStock IS NULL
        BEGIN
            PRINT 'Product not found in inventory.';
            RETURN;
        END

        IF @AvailableStock < @Quantity
        BEGIN
            PRINT 'Insufficient stock. Order aborted.';
            RETURN;
        END

        /* insert order in salesorderdetails*/
        INSERT INTO [AdventureWorks2019].[Sales].[SalesOrderDetail] (
            SalesOrderID, ProductID, OrderQty, UnitPrice, UnitPriceDiscount,
            rowguid, ModifiedDate
        )
        VALUES (
            @OrderID, @ProductID, @Quantity, @Price, @Discount,
            NEWID(), GETDATE()
        );

        /*insertion successful*/
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'Failed to place the order. Please try again.';
            RETURN;
        END

        /*stock updation*/
        SET @NewStock = @AvailableStock - @Quantity;

        UPDATE [AdventureWorks2019].[Production].[ProductInventory]
        SET Quantity = @NewStock
        WHERE ProductID = @ProductID;

        -- 6. Check if stock below reorder point
        IF @NewStock < @ReorderLevel
        BEGIN
            PRINT 'Stock below reorder level!';
        END

        PRINT 'Order placed successfully.';
END


