USE enterpriceBankingAnalyticsDB;

-- ==================================
-- Module 4 — Transaction Analytics
-- ==================================

-- =============================================
-- 1. Monthly transaction trend + MoM growth % 
-- =============================================
WITH transaction_trend AS (
    SELECT  
        YEAR(TransactionDate) AS transaction_year,
        MONTH(TransactionDate) AS transaction_month_no,
        MONTHNAME(TransactionDate) AS transaction_month_name,
        SUM(Amount) AS current_transaction_amount
    FROM transactions
    GROUP BY YEAR(TransactionDate),
        MONTH(TransactionDate)
)
SELECT
    transaction_year,
    transaction_month_name,
    current_transaction_amount,
    LAG(current_transaction_amount) OVER(ORDER BY transaction_year, transaction_month_no),
    ROUND(
        (
            current_transaction_amount - LAG(current_transaction_amount) OVER(ORDER BY transaction_year, transaction_month_no)
        ) * 100 / LAG(current_transaction_amount) OVER(ORDER BY transaction_year, transaction_month_no),
        2
    ) AS MoM_growth_rate
FROM transaction_trend;

-- ==============================================================
-- 2. Top 10 largest transactions with customer & branch details
-- ==============================================================
SELECT
    b.BranchName,
    c.FirstName,
    c.LastName,
    SUM(t.Amount) AS transaction_amount
FROM branches b 
JOIN addresses ad 
    on b.AddressID=ad.AddressID
JOIN customers c 
    ON ad.AddressID=c.AddressID
JOIN accounts a 
    ON c.CustomerID=a.CustomerID
JOIN transactions t 
    ON a.AccountID=t.AccountOriginID
GROUP BY b.BranchName,
    c.FirstName,
    c.LastName
ORDER BY transaction_amount DESC
LIMIT 10;

-- ==================================================
-- 2. Running cumulative transaction amount by month
-- ==================================================
SELECT  
    transaction_year,
    transaction_month_name,
    transaction_month_no,
    SUM(transaction_amount) OVER(ORDER BY transaction_year, transaction_month_no) AS cumulative_transaction_amount
FROM
(
    SELECT
        YEAR(TransactionDate) AS transaction_year,
        MONTH(TransactionDate) AS transaction_month_no,
        MONTHNAME(TransactionDate) AS transaction_month_name,
        SUM(Amount) AS transaction_amount
    FROM transactions 
    GROUP BY YEAR(TransactionDate),
        MONTH(TransactionDate)
) AS t;

-- ===============================
-- 3. Peak transaction month/day
-- ===============================
SELECT  
    YEAR(TransactionDate) AS transaction_year,
    MONTH(TransactionDate) AS transaction_month_no,
    DAY(TransactionDate) AS transaction_day_no,
    COUNT(*) AS count_transactions
FROM transactions  
GROUP BY YEAR(TransactionDate),
    MONTH(TransactionDate),
    DAY(TransactionDate)
ORDER BY count_transactions DESC;

-- ==========================================
-- 4. Branch-wise transaction volume ranking
-- ==========================================
SELECT  
    BranchID,
    BranchName,
    transaction_amount,
    ROW_NUMBER() OVER(ORDER BY transaction_amount DESC) AS rnk  
FROM
(
    SELECT
        b.BranchID,
        b.BranchName,
        SUM(t.Amount) AS transaction_amount
    FROM branches b 
    JOIN transactions t 
        ON b.BranchID=t.BranchID
    GROUP BY b.BranchID,
        b.BranchName
) AS t 
ORDER BY rnk;

