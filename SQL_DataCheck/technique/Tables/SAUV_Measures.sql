CREATE TABLE [technique].[SAUV_Measures] (
    [Date]           DATETIME        NULL,
    [Booking_system] INT             NULL,
    [Stage]          VARCHAR (10)    NULL,
    [Domain]         VARCHAR (100)   NULL,
    [Field]          VARCHAR (100)   NULL,
    [Description]    VARCHAR (250)   NULL,
    [Campaign]       INT             NULL,
    [Filter1]        NVARCHAR (100)  NULL,
    [Filter2]        NVARCHAR (100)  NULL,
    [Value]          NUMERIC (18, 8) NULL
);

