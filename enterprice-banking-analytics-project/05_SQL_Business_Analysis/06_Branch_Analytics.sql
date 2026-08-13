USE enterpriceBankingAnalyticsDB;

-- ===============================
-- Module 6 — Branch Performance
-- ===============================

-- =====================================================================================================================
-- 1. Ek single composite query: branch ka transaction volume + loan portfolio + customer count combine karke rank karo
-- =====================================================================================================================
WITH transaction_volume AS (
    SELECT  
        b.BranchID,
        b.BranchName,
        SUM(t.Amount) AS transaction_amount
    FROM branches b 
    JOIN transactions t 
        ON b.BranchID=t.BranchID
    GROUP BY b.BranchID,
        b.BranchName
),
loan_portfolio AS (
    SELECT
        b.BranchID,
        b.BranchName,
        SUM(l.PrincipalAmount) AS loan_amount
    FROM branches b 
    JOIN transactions t
        ON b.BranchID=t.BranchID
    JOIN accounts a  
        ON t.AccountOriginID=a.AccountID
    JOIN loans l 
        ON a.AccountID=l.AccountID
    GROUP BY b.BranchID,
        b.BranchName
),
customer_count AS (
    SELECT
        b.BranchID,
        b.BranchName,
        COUNT(DISTINCT c.CustomerID) AS total_customers
    FROM branches b 
    JOIN transactions t
        ON b.BranchID=t.BranchID
    JOIN accounts a  
        ON t.AccountOriginID=a.AccountID
    JOIN customers c 
        ON a.CustomerID=c.CustomerID
    GROUP BY b.BranchID,
        b.BranchName
)

SELECT
    tv.BranchID,
    tv.BranchName,
    tv.transaction_amount,
    lp.loan_amount,
    cc.total_customers
FROM transaction_volume tv 
JOIN loan_portfolio lp 
    ON tv.BranchID=lp.BranchID
JOIN customer_count cc 
    ON lp.BranchID=cc.BranchID;

-- ====================================================
-- 2. Har branch ka total balance mein contribution %
-- ====================================================
SELECT
    BranchID,
    BranchName,
    total_balance,
    SUM(total_balance) OVER() AS overall_balance,
    ROUND(
        total_balance * 100.0 / SUM(total_balance) OVER(),
        2
    ) AS contribution_pct
FROM (
    SELECT
        b.BranchID,
        b.BranchName,
        SUM(a.Balance) AS total_balance
    FROM branches b
    JOIN (
        SELECT DISTINCT BranchID, AccountOriginID AS AccountID
        FROM transactions
    ) AS ba ON b.BranchID = ba.BranchID
    JOIN accounts a ON ba.AccountID = a.AccountID
    GROUP BY b.BranchID, b.BranchName
) AS t;

-- ========================================
-- 3. Best/worst branch by avg transaction
-- ========================================
SELECT
    BranchID,
    BranchName,
    avg_transaction_amount,
    best_rn,
    ROW_NUMBER() OVER(ORDER BY avg_transaction_amount ASC) worst_rn
FROM
(
    SELECT
        BranchID,
        BranchName,
        avg_transaction_amount,
        ROW_NUMBER() OVER(ORDER BY avg_transaction_amount DESC) best_rn
    FROM
    (
        SELECT
            b.BranchID,
            b.BranchName,
            ROUND(
                AVG(t.Amount),
                2
            ) AS avg_transaction_amount
        FROM branches b 
        JOIN transactions t 
            ON b.BranchID=t.BranchID
        GROUP BY b.BranchID,
            b.BranchName
    ) AS t
) AS x;
