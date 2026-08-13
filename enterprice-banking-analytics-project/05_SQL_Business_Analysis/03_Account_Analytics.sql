USE enterpriceBankingAnalyticsDB;

-- =============================
-- Module 3 — Account Analytics 
-- =============================

-- ===================================================
-- 1. Rank Accounts using balance inside every branch
-- ===================================================
SELECT
    b.BranchID,
    b.BranchName,
    a.AccountID,
    a.Balance,
    ROW_NUMBER() OVER(PARTITION BY b.BranchID ORDER BY a.Balance DESC) AS rnk 
FROM branches b 
JOIN addresses ad 
    ON b.AddressID=ad.AddressID
JOIN customers c
    ON ad.AddressID=c.AddressID
JOIN accounts a
    ON c.CustomerID=a.CustomerID;

-- ============================================
-- 2. Zero/negative balance accounts flag karo
-- ============================================
SELECT
    AccountID,
    Balance
FROM accounts  
WHERE Balance <= 0;

-- ==================================================================
-- 3. Active vs Closed accounts — count aur avg balance dono compare
-- ==================================================================
SELECT
    StatusName,
    total_accounts,
    avg_balance
FROM
(
    SELECT
        ast.StatusName,
        COUNT(*) AS total_accounts,
        ROUND(
            AVG(a.Balance),
            2
        ) AS avg_balance
    FROM accounts a 
    JOIN account_statuses ast
        ON a.AccountStatusID=ast.AccountStatusID
    GROUP BY ast.StatusName
) AS t 
WHERE StatusName IN ('Active', 'Closed');

-- =============================================================
-- 4. Account opening trend, month-over-month growth % ke saath
-- =============================================================
WITH monthly_account_openings AS (
    SELECT
        YEAR(OpeningDate) AS year,
        MONTH(OpeningDate) AS Month_no,
        MONTHNAME(OpeningDate) AS Month_Name,
        COUNT(*) AS current_month_new_customers
    from accounts 
    GROUP BY YEAR(OpeningDate),
        MONTH(OpeningDate),
        MONTHNAME(OpeningDate)
)
SELECT
    year,
    Month_Name,
    current_month_new_customers,
    LAG(current_month_new_customers) OVER(ORDER BY year, Month_no) AS previous_month_new_customers,
    ROUND(
        (
            current_month_new_customers - LAG(current_month_new_customers) OVER(ORDER BY year, Month_no)
        ) * 100 / LAG(current_month_new_customers) OVER(ORDER BY year, Month_no),
        2
    ) AS MoM_growth_rate
FROM monthly_account_openings
ORDER BY year, Month_no;