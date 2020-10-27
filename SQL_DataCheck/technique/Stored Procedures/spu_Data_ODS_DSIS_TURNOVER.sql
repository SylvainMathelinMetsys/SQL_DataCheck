






-- ----------------------------------------------------------------------------
-- Procédure de contrôle RESALYS
-- Le volume de données chargées à J-1 ne pas être < 20 % ou supp à 200 % du vulume chargé à J-2
-- ----------------------------------------------------------------------------
-- Valeur de retour : 1 si Erreur sinon 0
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_Data_ODS_DSIS_TURNOVER]
AS 

INSERT INTO [technique].[Measures]

SELECT 
GETDATE() as [date1],
4 as Booking_System,
'ODS' as Stage,
'Turnover' as Domain,
'SalesAmount' as [Field],
'SalesAmount + Sales from Booking table -> sum is OC and all included' as [Description],
YEAR([StartDate]) as [Campaign] , 
case when  Canceled =1 
							 then 'Canceled' 
							 else 
								Case when PrebookingFinal = 1 
								then 'PrebookingFinal'
								else 
									Case when  Prebooking = 1
									then 'Prebooking'
									else 'Booked'
									end
								end
							end   as Filter1,
'NoPMS' as Filter2,
     sum(SalesAmount + coalesce([SalesAdministrationCosts],0) + coalesce([SalesTravelInsuranceAmount],0) + coalesce([SalesCancellationInsuranceAmount],0)) as [Turnover]
     
  FROM [ODS_DSIS].[dbo].[Stays] st
left join [ODS_DSIS].[dbo].Bookings b on b.ID = BookingId
where Canceled = 0
group by 
YEAR([StartDate])
,
case when  Canceled =1 
							 then 'Canceled' 
							 else 
								Case when PrebookingFinal = 1 
								then 'PrebookingFinal'
								else 
									Case when  Prebooking = 1
									then 'Prebooking'
									else 'Booked'
									end
								end
							end

