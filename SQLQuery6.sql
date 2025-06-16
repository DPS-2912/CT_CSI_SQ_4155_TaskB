CREATE or ALTER FUNCTION dbo.FormatToYYYYMMDD
(
    @InputDate DATETIME
)
RETURNS VARCHAR(8)
AS
BEGIN
    DECLARE @FormattedDate VARCHAR(8)

    /* 112 -> YYMMDD format*/
    SET @FormattedDate = CONVERT(VARCHAR(8), @InputDate, 112)

    RETURN @FormattedDate
END
