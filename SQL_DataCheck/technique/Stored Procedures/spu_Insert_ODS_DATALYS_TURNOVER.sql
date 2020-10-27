




-- ----------------------------------------------------------------------------
-- Procédure de contrôle RESALYS
-- Le volume de données chargées à J-1 ne pas être < 20 % ou supp à 200 % du vulume chargé à J-2
-- ----------------------------------------------------------------------------
-- Valeur de retour : 1 si Erreur sinon 0
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_Insert_ODS_DATALYS_TURNOVER]
AS 

INSERT INTO [technique].[Source_TURNOVER]

SELECT 
GETDATE() as [date1],
1 as Booking_System,
'ODS' as Stage,
'amount_sale_ati' as [Field],
'' as [Description],
campaign_cd as [Campaign] , 
cast([booking_status_cd] as varchar(10) ) as [booking_status_cd],
      sum([amount_sale_ati]) as [Turnover]
     
  FROM [ODS_DATALYS].[dbo].[ODS_DATALYS_TURNOVER]

  group by 
  campaign_cd,
  [booking_status_cd]

