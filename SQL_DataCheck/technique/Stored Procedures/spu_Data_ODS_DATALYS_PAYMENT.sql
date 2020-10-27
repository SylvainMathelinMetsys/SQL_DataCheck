








-- ----------------------------------------------------------------------------
-- Procédure de contrôle RESALYS
-- Le volume de données chargées à J-1 ne pas être < 20 % ou supp à 200 % du vulume chargé à J-2
-- ----------------------------------------------------------------------------
-- Valeur de retour : 1 si Erreur sinon 0
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_Data_ODS_DATALYS_PAYMENT]
AS 

INSERT INTO [technique].[Measures]

SELECT 
GETDATE() as [date1],
1 as Booking_System,
'ODS' as Stage,
'Payments' as Domain,
'amount_payment' as [Field],
'' as [Description],
YEAR(payment_dt) as [Campaign] , 
'All'as Filter1,
NULL  as Filter2,
      sum(amount_payment) as [Turnover]
     
  FROM [ODS_DATALYS].[dbo].[ODS_DATALYS_PAYMENT]

  --where property_no <> 1004 and [booking_status_cd] <> 'cin'

  group by 
 YEAR(payment_dt)

