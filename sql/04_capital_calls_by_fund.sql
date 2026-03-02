-- Query 4: Capital Calls by Fund
-- Business question: How much capital has been drawn down per fund?

SELECT
    Funds.Fund_Name,
    Funds.Strategy,
    COUNT(Transactions.Txn_ID) AS Number_Of_Calls,
    SUM(Transactions.Amount_Fund_Base) AS Total_Called
FROM Funds
JOIN Transactions ON Funds.Fund_ID = Transactions.Fund_ID
WHERE Transactions.Txn_Type = 'Capital Call'
GROUP BY Funds.Fund_Name, Funds.Strategy
ORDER BY Total_Called DESC;
