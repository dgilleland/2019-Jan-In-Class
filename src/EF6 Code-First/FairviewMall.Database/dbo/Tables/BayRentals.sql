CREATE TABLE [dbo].[BayRentals] (
    [BayID]     NVARCHAR (128) NOT NULL,
    [RentalID]  INT            NOT NULL,
    [Quadrants] INT            NOT NULL,
    CONSTRAINT [PK_dbo.BayRentals] PRIMARY KEY CLUSTERED ([BayID] ASC, [RentalID] ASC),
    CONSTRAINT [FK_dbo.BayRentals_dbo.Bays_BayID] FOREIGN KEY ([BayID]) REFERENCES [dbo].[Bays] ([BayID]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.BayRentals_dbo.Rentals_RentalID] FOREIGN KEY ([RentalID]) REFERENCES [dbo].[Rentals] ([RentalID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_BayID]
    ON [dbo].[BayRentals]([BayID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RentalID]
    ON [dbo].[BayRentals]([RentalID] ASC);

