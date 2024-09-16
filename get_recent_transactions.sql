CREATE PROCEDURE GetRecentTransactions (@AccountID INT, @StartDate DATE, @EndDate DATE)
AS
BEGIN
    SELECT t.TransactionID, t.TransactionDate, t.Amount, t.TransactionType, t.Description
    FROM Transactions t
    WHERE t.AccountID = @AccountID
      AND t.TransactionDate BETWEEN @StartDate AND @EndDate
    ORDER BY t.TransactionDate DESC;
END;
