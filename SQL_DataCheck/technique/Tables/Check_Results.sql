CREATE TABLE [technique].[Check_Results] (
    [Check_Results_id]  INT           IDENTITY (1, 1) NOT NULL,
    [Date_Check]        DATETIME      NULL,
    [Controls_ID]       INT           NULL,
    [Description]       VARCHAR (300) NULL,
    [Erreur]            BIT           NULL,
    [Warning]           BIT           NULL,
    [sessioncontrol_id] INT           NULL,
    CONSTRAINT [PK_Check_Results_log] PRIMARY KEY CLUSTERED ([Check_Results_id] ASC)
);

