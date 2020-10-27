

CREATE PROCEDURE [technique].[spu_controle_send_mail]
AS
BEGIN
	SET NOCOUNT ON


	DECLARE @MAIL_TO VARCHAR(800)

	SELECT @MAIL_TO = 'a.verdier@vacanceselect.com;v.lataye@vacanceselect.com'

	DECLARE @ERROR int
	SET @ERROR = 0

	IF EXISTS(SELECT 1 FROM technique.DataCheck_log
	WHERE CONVERT(date, date_traitement , 103) = CONVERT(date, getdate(), 103) AND erreur = 1)
		SET @ERROR = 1

	DECLARE @MAIL_BODY VARCHAR(8000)
 
	/* HEADER */
	SET @MAIL_BODY = '<p>Ceci est un message automatique de DataCheck, service de contrôle de la données BI.</p>' 

	IF @ERROR = 1
	BEGIN
		SET @MAIL_BODY = @MAIL_BODY +
		'<p>Voici la liste des codes concernés :</p></br>' +
		'<table border="1" align="left" cellpadding="2" cellspacing="0" style="color:black;font-family:consolas;text-align:center;">' +
		'<tr>
		<th>Date traitement</th>
		<th>Opération</th>
		<th>Erreur</th>
		</tr>'
 
		/* ROWS */
		SELECT
			@MAIL_BODY = @MAIL_BODY +
				'<tr>' +
				'<td>' + CAST(date_traitement AS NVARCHAR(250)) + '</td>' +
				'<td>' + CAST(operation  AS NVARCHAR(250)) + '</td>' +
				'<td>' + CAST(erreur  AS NVARCHAR(250)) + '</td>' +
				'</tr>'
		 
		FROM technique.DataCheck_log
		WHERE CONVERT(date, date_traitement , 103) = CONVERT(date, getdate(), 103) AND erreur = 1
	END

	SELECT @MAIL_BODY = @MAIL_BODY + '</table>'
 


    DECLARE @SUBJECT varchar(200) 
	IF @ERROR = 1
		SET @SUBJECT= 'DataCheck - Rapport de contrôle des données BI. ERREURS !'
	ELSE
		SET @SUBJECT= 'DataCheck - Rapport de contrôle des données BI. AUCUNE ERREUR'


	EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'Messagerie',
        @recipients = @MAIL_TO,
        @subject = @SUBJECT,
        @attach_query_result_as_file = 0,
		@body = @MAIL_BODY,
		@body_format='HTML',
        @importance = 'HIGH',
        @query_result_separator = '|',
        @file_attachments = null -- nvarchar(max);
	

END
