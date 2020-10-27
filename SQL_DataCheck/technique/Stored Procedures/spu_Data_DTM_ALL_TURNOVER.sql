






-- ----------------------------------------------------------------------------
-------------------------------
CREATE PROCEDURE [technique].[spu_Data_DTM_ALL_TURNOVER]
AS 

INSERT INTO [technique].[Measures]

SELECT 

GETDATE() as [date1],
[Qualification_System_code] as Booking_System,
'DMT' as Stage,
'Turnover' as Domain,
'Excluding_VAT_OC' as [Field],
'' as [Description],
[Qualification_Campaign] as [Campaign] , 
	cast( 
		case when 
			Booking_System = 1 
		then [Booking_Status_System_Code]
		else coalesce([Booking_Status_System_Name],'NA') end
	as varchar(100) ) 
	as Filter1,
'NoPMS' as Filter2,

sum([Excluding_VAT_OC]) as [Turnover]
     
FROM [DTM_DATACAMP].[dbo].[FACT_PRODUCT_TURNOVER_OVERVIEW] f

left join [DTM_DATACAMP].[dbo].[DIM_BOOKED_STAY] bs on bs.Booked_Stay_ID = f.Booked_Stay_ID

left join [DTM_DATACAMP].[dbo].[DIM_FACTS_QUALIFICATION] fq on fq.Qualification_ID = f.Qualification_ID

where Pricing_ID <> 1 and Pricing_ID <> -1  --Exclu les coûts manuels et les pricing_id non attribué (tva DSIS)

group by 
cast( 
	case when 
		Booking_System = 1 
	then [Booking_Status_System_Code]
	else coalesce([Booking_Status_System_Name],'NA') end
as varchar(100) ) 
,[Qualification_System_code]
,[Qualification_Campaign]

