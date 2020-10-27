CREATE TABLE [technique].[Controls] (
    [Code]          NVARCHAR (250)  NOT NULL,
    [Name]          NVARCHAR (250)  NULL,
    [Description]   NVARCHAR (1000) NULL,
    [Step_Name]     NVARCHAR (250)  NULL,
    [Type_Name]     NVARCHAR (250)  NULL,
    [Severity_Name] NVARCHAR (250)  NULL,
    [Source_Code]   NVARCHAR (250)  NULL,
    [Source_Name]   NVARCHAR (250)  NULL,
    [Domaine_Name]  NVARCHAR (250)  NULL,
    [Mod_Name]      NVARCHAR (250)  NULL,
    [Criteria_1]    NVARCHAR (100)  NULL,
    [Criteria_2]    NVARCHAR (100)  NULL,
    [Criteria_3]    NVARCHAR (100)  NULL
);

