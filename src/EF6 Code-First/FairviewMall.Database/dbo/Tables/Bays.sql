CREATE TABLE [dbo].[Bays] (
    [BayID]       NVARCHAR (128) NOT NULL,
    [FloorSpace]  INT            NOT NULL,
    [ReservedUse] NVARCHAR (25)  NULL,
    CONSTRAINT [PK_dbo.Bays] PRIMARY KEY CLUSTERED ([BayID] ASC)
);

