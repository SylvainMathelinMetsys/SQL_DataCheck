


CREATE PROCEDURE [technique].[spu_controle_INIT]

AS
DECLARE @RET int
--@MAXSESSIONCONTROL_ID int

--SELECT @MAXSESSIONCONTROL_ID = MAX( sessioncontrol_id) FROM technique.DataCheck_log
 
--SET @MAXSESSIONCONTROL_ID = @MAXSESSIONCONTROL_ID + 1


--EXEC [technique].[spu_controle_DATALYS_TURNOVER]  @RET OUTPUT
--PRINT CAST(@RET AS CHAR(1))

	DROP TABLE IF EXISTS[technique].[Controls];

SELECT  [Code]
      ,[Name]
      ,[Description]
      ,[Step_Name]
      ,[Type_Name]
      ,[Severity_Name]
      ,[Source_Code]
      ,[Source_Name]
      ,[Domaine_Name]
      ,[Mod_Name]
      ,[Criteria_1]
      ,[Criteria_2]
      ,[Criteria_3]

	  into [DATACHECK].[technique].[Controls]
  FROM [MDS_VIEW].[dbo].[V_DATACHECK_Controls]

--INSERT INTO technique.DataCheck_log([date_traitement], [operation], [erreur], sessioncontrol_id) VALUES (getdate(), 'DATALYS Volume Turnover J-2/J-1', @RET, @MAXSESSIONCONTROL_ID)
/*
EXEC technique.spu_controle_DSIS_1  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
INSERT INTO technique.DataCheck_log([date_traitement], [operation], [erreur], sessioncontrol_id) VALUES (getdate(), 'DSIS traitement données J-1', @RET, @MAXSESSIONCONTROL_ID)
*/
/*

EXEC technique.spu_controle_DSIS_2  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
INSERT INTO technique.DataCheck_log([date_traitement], [operation], [erreur], sessioncontrol_id) VALUES (getdate(), 'DSIS Existence d''erreur sur API', @RET, @MAXSESSIONCONTROL_ID)


-- Contrôle d'intégrité sur les Canaux de distribution
-- Attention:  non bloquant dans la chaine SQL Agent du CA Quotidien, donc on lève juste un warning
EXEC [technique].[spu_controle_canal_distribution_1]  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
IF @RET = 1
	INSERT INTO technique.DataCheck_log([date_traitement], [operation], warning, sessioncontrol_id) VALUES (getdate(), 'Violation CIR Canal distrib Séjour vs MDS', 1, @MAXSESSIONCONTROL_ID)


-- Contrôle Type UH marque séjour
EXEC [technique].spu_controle_type_UH_marque_sejour_1  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
IF @RET = 1
	INSERT INTO technique.DataCheck_log([date_traitement], [operation], warning, sessioncontrol_id) VALUES (getdate(), 'Violation CIR Type UH marque séjour vs MDS', 1, @MAXSESSIONCONTROL_ID)


-- Contrôle Type UH marque séjour
EXEC [technique].[spu_controle_type_UH_segment_produit_1]  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
IF @RET = 1
	INSERT INTO technique.DataCheck_log([date_traitement], [operation], warning, sessioncontrol_id) VALUES (getdate(), 'Violation CIR Type UH segment produit vs MDS', 1, @MAXSESSIONCONTROL_ID)


-- Contrôle DESTHPA Gamme
EXEC [technique].spu_controle_deshpa_gamme_1  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
IF @RET = 1
	INSERT INTO technique.DataCheck_log([date_traitement], [operation], warning, sessioncontrol_id) VALUES (getdate(), 'Violation CIR DestHPA Gamme vs MDS', 1, @MAXSESSIONCONTROL_ID)

-- Contrôle DESTHPA Business Model
EXEC [technique].[spu_controle_deshpa_business_model_1]  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
IF @RET = 1
	INSERT INTO technique.DataCheck_log([date_traitement], [operation], warning, sessioncontrol_id) VALUES (getdate(), 'Violation CIR DestHPA Business Model vs MDS', 1, @MAXSESSIONCONTROL_ID)

EXEC [technique].[spu_controle_type_uh_code_deshpa_1]  @RET OUTPUT
PRINT CAST(@RET AS CHAR(1))
IF @RET = 1
	INSERT INTO technique.DataCheck_log([date_traitement], [operation], warning, sessioncontrol_id) VALUES (getdate(), 'Code DestHPA NULL dans DMT DIM dest HPA', 1, @MAXSESSIONCONTROL_ID)
*/
