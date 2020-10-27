



-- ----------------------------------------------------------------------------
-- Procédure de contrôle RESALYS
-- Le volume de données chargées à J-1 ne pas être < 20 % ou supp à 200 % du vulume chargé à J-2
-- ----------------------------------------------------------------------------
-- Valeur de retour : 1 si Erreur sinon 0
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_controle_DATALYS_TURNOVER]
@RETOUR int OUTPUT
AS 
DECLARE @NbRecOne numeric(18,4),  @NbRecTwo numeric(18,4), @Ratio1 numeric(18,4) , @Ratio2 numeric(18,4)

SELECT @NbRecOne = cast(SUM([amount_invoiced_et]+[amount_not_invoiced_et]) as numeric(18,4))
FROM [ODS_DATALYS].[dbo].[ODS_DATALYS_TURNOVER]
WHERE convert(DATE , [booking_creation_dt]) =  convert(date,DATEADD(DAY, -1, getdate())) and booking_type = 'indiv'

PRINT 'Hier : ' + CAST( @NbRecOne AS VARCHAR(20))

SELECT @NbRecTwo = cast(SUM([amount_invoiced_et]+[amount_not_invoiced_et])as numeric(18,4))
FROM [ODS_DATALYS].[dbo].[ODS_DATALYS_TURNOVER]
WHERE convert(DATE, [booking_creation_dt] ) =  convert(date,DATEADD(DAY, -2, getdate()))  and booking_type = 'indiv'

PRINT 'Avant hier : ' + CAST( @NbRecTwo AS VARCHAR(20))

IF @NbRecTwo > 0
	SET @Ratio1 =  @NbRecTwo * 0.20
ELSE
	SET @Ratio1 = @NbRecOne

PRINT 'Ratio1 : ' + CAST( @Ratio1 AS VARCHAR(20))

IF @NbRecTwo > 0
	SET @Ratio2 =  @NbRecTwo  * 2
ELSE
	SET @Ratio2 = @NbRecOne

PRINT 'Ratio2 : ' + CAST( @Ratio2 AS VARCHAR(20))

INSERT INTO technique.volumes_DATALYS_TURNOVER ([date1], [volume_date1], [date2], [volume_date2]) 
VALUES ( convert(date,DATEADD(DAY, -1, getdate())), cast(@NbRecOne as int), convert(date,DATEADD(DAY, -2, getdate())), cast(@NbRecTwo as int))

IF @NbRecOne < @Ratio1  or @NbRecOne > @Ratio2 
	SET @RETOUR = 1
ELSE 
	SET @RETOUR = 0

