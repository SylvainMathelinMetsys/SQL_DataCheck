


-- ----------------------------------------------------------------------------
-- Procédure de contrôle RESALYS
-- Le volume de données chargées à J-1 ne pas être < 20 % ou supp à 200 %du vulume chargé à J-2
-- ----------------------------------------------------------------------------
-- Valeur de retour : 1 si Erreur sinon 0
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[SAUV_spu_controle_FAITS_CA_NUIT_1]
@RETOUR int OUTPUT
AS 
DECLARE @NbRecOne INT,  @NbRecTwo INT, @Ratio numeric(8,2)

SELECT @NbRecOne = COUNT([FK_DATE_NUIT])
FROM [dbo].[DWH_FACT_CA_NUIT]
WHERE [FK_DATE_RESA] =  [technique].[fnConvertDateToYMD](DATEADD(DAY, -1, getdate()))

PRINT 'Hier : ' + CAST( @NbRecOne AS VARCHAR(20))

SELECT @NbRecTwo = COUNT([FK_DATE_NUIT])
FROM [dbo].[DWH_FACT_CA_NUIT]
WHERE [FK_DATE_RESA] =  [technique].[fnConvertDateToYMD](DATEADD(DAY, -2, getdate()))

PRINT 'Avant hier : ' + CAST( @NbRecTwo AS VARCHAR(20))

IF @NbRecTwo > 0
	SET @Ratio =  CAST(@NbRecTwo AS numeric(10,2)) * 0.10
ELSE
	SET @Ratio = @NbRecOne

PRINT 'Ratio : ' + CAST( @Ratio AS VARCHAR(20))

INSERT INTO technique.volumes_resalys_FACT_CA_NUIT ([date1], [volume_date1], [date2], [volume_date2]) 
VALUES ( DATEADD(DAY, -1, getdate()), @NbRecOne, DATEADD(DAY, -2, getdate()), @NbRecTwo)

IF @NbRecOne < @Ratio 
	SET @RETOUR = 1
ELSE 
	SET @RETOUR = 0

