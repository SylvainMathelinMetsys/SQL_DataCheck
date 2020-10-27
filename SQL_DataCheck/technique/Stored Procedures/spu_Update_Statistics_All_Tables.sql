

CREATE PROCEDURE [technique].[spu_Update_Statistics_All_Tables]
AS
SET NOCOUNT ON

DECLARE updatestats CURSOR FOR
SELECT table_name, t.TABLE_SCHEMA FROM information_schema.tables t
	where TABLE_TYPE = 'BASE TABLE'
OPEN updatestats

DECLARE @tablename NVARCHAR(128), @schemaname NVARCHAR(128)
DECLARE @Statement NVARCHAR(300)

FETCH NEXT FROM updatestats INTO @tablename, @schemaname
WHILE (@@FETCH_STATUS = 0)
BEGIN
   PRINT N'UPDATING STATISTICS ' + @schemaname + '.'+ @tablename
   SET @Statement = 'UPDATE STATISTICS '  +  @schemaname + '.' + @tablename + '  WITH FULLSCAN'
   EXEC sp_executesql @Statement
   FETCH NEXT FROM updatestats INTO @tablename, @schemaname
END
