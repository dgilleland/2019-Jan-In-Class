CREATE TABLE [dbo].[Rentals] (
    [RentalID]     INT           IDENTITY (1, 1) NOT NULL,
    [CompanyName]  NVARCHAR (30) NOT NULL,
    [Website]      NVARCHAR (40) NULL,
    [PhoneNumber]  CHAR (12)     NOT NULL,
    [ContactName]  NVARCHAR (50) NOT NULL,
    [RentalTerm]   INT           NOT NULL,
    [MonthlyRate]  MONEY         NOT NULL,
    [StartingDate] DATETIME      NOT NULL,
    [ClosingDate]  DATETIME      NULL,
    CONSTRAINT [PK_dbo.Rentals] PRIMARY KEY CLUSTERED ([RentalID] ASC)
);

