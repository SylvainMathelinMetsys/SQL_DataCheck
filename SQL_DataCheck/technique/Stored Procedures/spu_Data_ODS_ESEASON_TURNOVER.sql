










-- ----------------------------------------------------------------------------
--Récupération des données de CA source de l'ODS pour ESEASON
-- ----------------------------------------------------------------------------
CREATE PROCEDURE [technique].[spu_Data_ODS_ESEASON_TURNOVER]
AS 

INSERT INTO [technique].[Measures]

SELECT 
GETDATE() as [date1],
2 as Booking_System,
'ODS' as Stage,
'Turnover' as Domain,
'[CoutsHT]+[CoutsAnnexHT]' as [Field],
'' as [Description],
year([DateFinSejour])	as [Campaign] , 
[StatusReservation]+'-'+[SituationReservation] as Filter1,
'NoPMS' as Filter2,
      sum([CoutsHT]+[CoutsAnnexHT]) as [Turnover]
     
  FROM [ODS_ESEASON].[dbo].[ODS_ESEASON_UR]
  where [StatusReservation] <> 'CANCEL' and YEAR(finPresta) = YEAR([DateFinSejour])

group by 
year([DateFinSejour])
,[StatusReservation]+'-'+[SituationReservation]

