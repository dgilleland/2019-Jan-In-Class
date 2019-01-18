CREATE TABLE [dbo].[DbHistory] (
    [HistoryID] INT           IDENTITY (1, 1) NOT NULL,
    [TagName]   NVARCHAR (25) NULL,
    [Major]     INT           NOT NULL,
    [Minor]     INT           NOT NULL,
    [Build]     INT           NOT NULL,
    CONSTRAINT [PK_dbo.DbHistory] PRIMARY KEY CLUSTERED ([HistoryID] ASC)
);

