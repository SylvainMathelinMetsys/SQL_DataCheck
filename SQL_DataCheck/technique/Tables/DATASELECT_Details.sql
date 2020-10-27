CREATE TABLE [technique].[DATASELECT_Details] (
    [Date]                       DATETIME        NULL,
    [Campaign]                   INT             NULL,
    [Qualification_System_code]  INT             NULL,
    [Qualification_System]       VARCHAR (100)   NULL,
    [Booking_Status_System_Code] INT             NULL,
    [Booking_Status_System_Name] VARCHAR (100)   NULL,
    [Product_type]               VARCHAR (100)   NULL,
    [Montant_total_OC_HT]        NUMERIC (18, 8) NULL,
    [Montant_total_OC_TTC]       NUMERIC (18, 8) NULL,
    [Montant_total_EUR_HT]       NUMERIC (18, 8) NULL,
    [Montant_total_EUR_TTC]      NUMERIC (18, 8) NULL
);

