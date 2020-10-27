








-- ----------------------------------------------------------------------------
-- Procédure de contrôle RESALYS
-- Le volume de données chargées à J-1 ne pas être < 20 % ou supp à 200 % du vulume chargé à J-2
-- ----------------------------------------------------------------------------
-- Valeur de retour : 1 si Erreur sinon 0
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_Data_ODS_HAPIPRO_TURNOVER]
AS 

INSERT INTO [technique].[Measures]

SELECT 
GETDATE() as [date1],
3 as Booking_System,
'ODS' as Stage,
'Turnover' as Domain,
'totalFactureHT' as [Field],
'' as [Description],
[campagne_annee]as [Campaign] , 
cast('NA' as varchar(10) ) as Filter1,
'NoPMS' as Filter2,
      sum([totalFactureHorsTaxe]) as [Turnover]
     
  FROM [ODS_HAPIPRO].[dbo].[ODS_HAPIPRO_EXPORT_FACTURES]

group by 
[campagne_annee]

