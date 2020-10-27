







-- ----------------------------------------------------------------------------
-- Procédure de contrôle RESALYS
-- Le volume de données chargées à J-1 ne pas être < 20 % ou supp à 200 % du vulume chargé à J-2
-- ----------------------------------------------------------------------------
-- Valeur de retour : 1 si Erreur sinon 0
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_Data_ODS_DATALYS_TURNOVER_forDMT]
AS 

INSERT INTO [technique].[Measures]

SELECT 
GETDATE() as [date1],
1 as Booking_System,
'ODS' as Stage,
'Turnover' as Domain,
'amount_sale_et' as [Field],
'Turnover without 1004 campsite ID' as [Description],
campaign_cd as [Campaign] , 
cast([booking_status_cd] as varchar(10) ) as Filter1,
'NoPMS' as Filter2,
      sum([amount_sale_et]) as [Turnover]
     
  FROM [ODS_DATALYS].[dbo].[ODS_DATALYS_TURNOVER]

  where property_no <> 1004 and [booking_status_cd] <> 'cin'
  and Complimentary_fl = 'Non' and Free_fl = 'Non' and cancel_fl = 'Non' and booking_status_cd not in ('bpp','bpc','bpn') 

  group by 
  campaign_cd,
  [booking_status_cd]

