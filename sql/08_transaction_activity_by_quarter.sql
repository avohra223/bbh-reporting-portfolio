-- Query 8: Transaction Activity by Quarter
-- Business question: How has transaction volume and value trended over time?

SELECT
    strftime('%Y', Txn_Date) AS Year,
    CASE 
        WHEN strftime('%m', Txn_Date) IN ('01','02','03') THEN 'Q1'
        WHEN strftime('%m', Txn_Date) IN ('04','05','06') THEN 'Q2'
        WHEN strftime('%m', Txn_Date) IN ('07','08','09') THEN 'Q3'
        ELSE 'Q4'
    END AS Quarter,
    Txn_Type,
    COUNT(Txn_ID) AS Number_Of_Transactions,
    SUM(Amount_Fund_Base) AS Total_Amount
FROM Transactions
GROUP BY Year, Quarter, Txn_Type
ORDER BY Year, Quarter, Txn_Type;
