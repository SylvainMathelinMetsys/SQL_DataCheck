CREATE TABLE [technique].[DataCheck_log] (
    [datacheck_id]      INT           IDENTITY (1, 1) NOT NULL,
    [date_traitement]   DATETIME      NULL,
    [operation]         VARCHAR (300) NULL,
    [erreur]            BIT           CONSTRAINT [DF_DataCheck2_log_erreur] DEFAULT ((0)) NULL,
    [warning]           BIT           CONSTRAINT [DF_DataCheck2_log_warning] DEFAULT ((0)) NULL,
    [sessioncontrol_id] INT           NULL,
    CONSTRAINT [PK_DataCheck_log] PRIMARY KEY CLUSTERED ([datacheck_id] ASC)
);

