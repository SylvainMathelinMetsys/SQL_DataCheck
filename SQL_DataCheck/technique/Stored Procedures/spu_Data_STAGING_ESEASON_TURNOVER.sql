










-- ----------------------------------------------------------------------------
--Récupération des données de CA source de l'ODS pour ESEASON
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_Data_STAGING_ESEASON_TURNOVER]
AS 

INSERT INTO [technique].[Measures]

SELECT 
GETDATE() as [date1],
2 as Booking_System,
'Staging' as Stage,
'Turnover' as Domain,
'[CoutsTTC]+[CoutsAnnexTTC]' as [Field],
'' as [Description],
cast(left(coalesce([DateFinSejour],1),4) as int)	as [Campaign] , 
[StatusReservation]+'-'+[SituationReservation] as Filter1,
'NoPMS' as Filter2,
      sum(cast([CoutsTTC] as float)+cast([CoutsAnnexTTC] as float)) as [Turnover]
     
  FROM [STAGING_ESEASON].[dbo].[STG_ESEASON_UR]
  where [StatusReservation] <> 'CANCEL' and cast(left(coalesce(finPresta,coalesce([DateFinSejour],1)),4) as int)= cast(left(coalesce([DateFinSejour],1),4) as int)

group by 
cast(left(coalesce([DateFinSejour],1),4) as int)
,[StatusReservation]+'-'+[SituationReservation]

