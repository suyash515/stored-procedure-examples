CREATE PROCEDURE GetCustomerBalance (@AccountID INT)
AS
BEGIN
    SELECT a.AccountNumber, a.AccountType, a.Balance
    FROM Accounts a
    WHERE a.AccountID = @AccountID;
END;
