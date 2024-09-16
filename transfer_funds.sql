CREATE PROCEDURE TransferFunds (@SourceAccountID INT, @TargetAccountID INT, @Amount DECIMAL(18, 2))
AS
BEGIN
    DECLARE @SourceBalance DECIMAL(18, 2);

    -- Get the current balance of the source account
    SELECT @SourceBalance = Balance
    FROM Accounts
    WHERE AccountID = @SourceAccountID;

    -- Check if source account has sufficient balance
    IF @SourceBalance < @Amount
    BEGIN
        RAISERROR ('Insufficient funds in the source account.', 16, 1);
        RETURN;
    END

    -- Deduct amount from source account
    UPDATE Accounts
    SET Balance = Balance - @Amount
    WHERE AccountID = @SourceAccountID;

    -- Add amount to destination account
    UPDATE Accounts
    SET Balance = Balance + @Amount
    WHERE AccountID = @TargetAccountID;

    -- Record the transaction for source account
    INSERT INTO Transactions (AccountID, TransactionDate, Amount, TransactionType, Description)
    VALUES (@SourceAccountID, GETDATE(), -@Amount, 'Debit', 'Transfer to Account ' + CAST(@TargetAccountID AS VARCHAR(10)));

    -- Record the transaction for target account
    INSERT INTO Transactions (AccountID, TransactionDate, Amount, TransactionType, Description)
    VALUES (@TargetAccountID, GETDATE(), @Amount, 'Credit', 'Transfer from Account ' + CAST(@SourceAccountID AS VARCHAR(10)));
END;
