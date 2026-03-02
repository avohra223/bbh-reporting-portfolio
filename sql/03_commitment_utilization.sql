-- Query 3: Commitment Utilization by LP
-- Business question: What percentage of each LP's commitment has been called so far?

SELECT
    Investors.Investor_Name,
    SUM(Commitments.Commitment_Amount) AS Total_Committed,
    SUM(CASE WHEN Transactions.Txn_Type = 'Capital Call' 
        THEN Transactions.Amount_Fund_Base ELSE 0 END) AS Total_Called,
    ROUND(SUM(CASE WHEN Transactions.Txn_Type = 'Capital Call' 
        THEN Transactions.Amount_Fund_Base ELSE 0 END) * 100.0 / 
        SUM(Commitments.Commitment_Amount), 2) AS Utilization_Pct
FROM Investors
JOIN Commitments ON Investors.Investor_ID = Commitments.Investor_ID
JOIN Transactions ON Investors.Investor_ID = Transactions.Investor_ID
GROUP BY Investors.Investor_Name
ORDER BY Utilization_Pct DESC;
