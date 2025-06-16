CREATE or ALTER FUNCTION dbo.FormatToMMDDYYYY
(
    @InputDate DATETIME
)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @FormattedDate VARCHAR(10)

    /*101 -> DD/MM/YYYY format*/
    SET @FormattedDate = CONVERT(VARCHAR(10), @InputDate, 101)

    RETURN @FormattedDate
END


