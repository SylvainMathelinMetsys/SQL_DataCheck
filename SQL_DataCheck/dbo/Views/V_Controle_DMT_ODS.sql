






CREATE VIEW [dbo].[V_Controle_DMT_ODS]
/*WITH ENCRYPTION*/
AS 

SELECT convert(date,Dmt.[Date]) as Date
, Dmt.Stage
      ,Dmt.[Booking_system]
      ,Dmt.[Campaign]
      ,Dmt.Filter1
	  ,Dmt.Filter2
	  ,Dmt.value as Value1
	  ,ods.[value] as Value2
      ,Dmt.value - ods.[value] as Difference
	  ,cast((Dmt.value - Dmt.[value])/case when coalesce(Dmt.[value],1) = 0 then 1 else coalesce(Dmt.[value],1) end as float)  as Ratio
  FROM [technique].[Measures] dmt


  left join  [technique].[Measures] ods on 
  convert(date, dmt.[Date]) =   convert(date, ods.[Date])
 and dmt.Campaign = ods.Campaign 
and dmt.[Domain] = ods.Domain
  and dmt.Booking_system = ods.Booking_system 
  and dmt.Filter1= ods.Filter1 
    and coalesce(dmt.Filter2,'NA')=  coalesce(ods.Filter2,'NA')
  and ods.[Stage] = 'ods'

  where dmt.Stage = 'dmt' and (ods.[value]) is not null and convert(date,dmt.[Date])  = CONVERT(date, getdate()) and convert(date,ods.[Date])  = CONVERT(date, getdate()) --and abs(Dmt.value - ods.[value])  >= 1


