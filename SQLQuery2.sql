CREATE OR ALTER PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity SMALLINT = NULL,
    @Discount FLOAT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @OldQuantity INT;
        DECLARE @NewQuantity INT;
        DECLARE @OldUnitPrice MONEY;
        DECLARE @OldDiscount FLOAT;
        DECLARE @StockChange INT;

        /*get current order details*/
        SELECT 
            @OldQuantity = OrderQty,
            @OldUnitPrice = UnitPrice,
            @OldDiscount = UnitPriceDiscount
        FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
        WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;

        IF @OldQuantity IS NULL
        BEGIN
            PRINT 'Order detail not found.';
            RETURN;
        END

        /*use of ISNULL() */
        SET @NewQuantity = ISNULL(@Quantity, @OldQuantity);
        SET @UnitPrice = ISNULL(@UnitPrice, @OldUnitPrice);
        SET @Discount = ISNULL(@Discount, @OldDiscount);

        /*updating sales order details*/
        UPDATE [AdventureWorks2019].[Sales].[SalesOrderDetail]
        SET 
            OrderQty = @NewQuantity,
            UnitPrice = @UnitPrice,
            UnitPriceDiscount = @Discount,
            ModifiedDate = GETDATE()
        WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;

        /*update inventory*/
        SET @StockChange = @NewQuantity - @OldQuantity;

        UPDATE [AdventureWorks2019].[Production].[ProductInventory]
        SET Quantity = Quantity + @StockChange
        WHERE ProductID = @ProductID;

        PRINT 'Order detail updated successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END
