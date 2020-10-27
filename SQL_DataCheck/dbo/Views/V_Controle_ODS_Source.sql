







CREATE VIEW [dbo].[V_Controle_ODS_Source]
/*WITH ENCRYPTION*/

AS 


SELECT convert(date,ods.[Date]) as Date
, ods.Stage
      ,ods.[Booking_system]
	  ,ods.domain
      ,ods.[Campaign]
      ,ods.Filter1
	  ,ODS.Filter2
	  ,ods.value as Value1
	  ,Source.[value] as Value2
      ,ods.value - Source.[value] as Difference
	  , cast((ods.value - source.[value])/case when coalesce(ods.[value],1) = 0 then 1 else coalesce(ods.[value],1) end as float) as Ratio
  FROM [technique].[Measures] ods


  left join  [technique].[Measures] source on 
  convert(date, ods.[Date]) =   convert(date, source.[Date])
 and ods.Campaign = source.Campaign 
and ods.[Domain] = source.Domain
  and ods.Booking_system = source.Booking_system 
  and ods.Filter1= source.Filter1 
    and coalesce(ods.Filter2,'NA')=  coalesce(source.Filter2,'NA')
  and Source.[Stage] = 'Source'

  where ods.Stage = 'ODS' and (Source.[value]) is not null and convert(date,GETDATE() )  = CONVERT(date, getdate()) and convert(date,source.[Date])  = CONVERT(date, GETDATE() )
 and ods.Filter1 not in ('bpp','bpc','bpn')


