-- Query 12: Fund Performance - DPI (Distributions to Paid-In Capital)
-- Business question: How much have investors gotten back relative to what they put in?
-- DPI < 1.0x = not yet returned capital, DPI > 1.0x = returned more than invested

WITH Called AS (
    SELECT Fund_ID, SUM(Amount_Fund_Base) AS Total_Called
    FROM Transactions
    WHERE Txn_Type = 'Capital Call'
    GROUP BY Fund_ID
),
Distributed AS (
    SELECT Fund_ID, SUM(Amount_Fund_Base) AS Total_Distributed
    FROM Transactions
    WHERE Txn_Type = 'Distribution'
    GROUP BY Fund_ID
)
SELECT
    Funds.Fund_Name,
    Funds.Strategy,
    Funds.Fund_Size,
    Called.Total_Called,
    COALESCE(Distributed.Total_Distributed, 0) AS Total_Distributed,
    ROUND(COALESCE(Distributed.Total_Distributed, 0) * 1.0 / Called.Total_Called, 4) AS DPI,
    ROUND(Called.Total_Called * 100.0 / Funds.Fund_Size, 2) AS Pct_Deployed
FROM Funds
JOIN Called ON Funds.Fund_ID = Called.Fund_ID
LEFT JOIN Distributed ON Funds.Fund_ID = Distributed.Fund_ID
ORDER BY DPI DESC;
