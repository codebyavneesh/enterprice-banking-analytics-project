USE enterpriceBankingAnalyticsDB;

-- ==========================
-- Module 5 — Loan Analytics
-- ==========================

-- =============================================================
-- 1. Loan status (active/closed) distribution by customer type
-- =============================================================
SELECT
    TypeName,
    StatusName,
    combinations
FROM
(
    SELECT
        ct.TypeName,
        ls.StatusName,
        COUNT(*) AS combinations
    FROM customer_types ct 
    JOIN customers c 
        ON ct.CustomerTypeID=c.CustomerTypeID
    JOIN accounts a 
        ON c.CustomerID=a.CustomerID
    JOIN loans l 
        ON a.AccountID=l.AccountID
    JOIN loan_statuses ls 
        ON l.LoanStatusID=ls.LoanStatusID
    GROUP BY ct.TypeName,
        ls.StatusName
) AS t 
WHERE StatusName IN ('Active', 'Closed');

-- =======================================
-- 2. Top borrowers with customer details
-- =======================================
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    ct.TypeName,
    SUM(l.PrincipalAmount) AS loan_amount
FROM customers c 
JOIN customer_types ct 
    ON c.CustomerTypeID=ct.CustomerTypeID
JOIN accounts a 
    ON c.CustomerID=a.CustomerID
JOIN loans l 
    ON a.AccountID=l.AccountID
GROUP BY c.CustomerID,
    c.FirstName,
    c.LastName,
    ct.TypeName
ORDER BY loan_amount DESC;

-- =====================================================
-- 3. Branch-wise average loan amount aur interest rate
-- =====================================================
SELECT
    b.BranchID,
    b.BranchName,
    ROUND(
        AVG(l.PrincipalAmount),
        2
    ) AS avg_loan_amount,
    ROUND(
        AVG(l.InterestRate),
        3
    ) AS avg_interest_rate
FROM branches b 
JOIN transactions t 
    ON b.BranchID=t.BranchID
JOIN accounts a 
    ON t.AccountOriginID=a.AccountID
JOIN loans l 
    ON a.AccountID=l.AccountID
GROUP BY b.BranchID,
    b.BranchName
ORDER BY avg_loan_amount DESC;

-- ========================================================================
-- 4. Customers jinke loan hai par last 6 months mein koi transaction nahi
-- ========================================================================
SELECT
    c.FirstName,
    c.LastName,
    l.PrincipalAmount,
    t.TransactionID,
    t.TransactionDate
FROM customers c 
LEFT JOIN accounts a 
    ON c.CustomerID=a.CustomerID
LEFT JOIN loans l 
    ON a.AccountID=l.AccountID
LEFT JOIN transactions t 
    ON a.AccountID=t.AccountOriginID AND t.TransactionDate>=DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
WHERE t.TransactionID IS NULL AND l.PrincipalAmount IS NOT NULL;

-- ==================================================
-- 5. Loan portfolio ka running total time ke saath
-- ==================================================
SELECT
    loan_year,
    loan_month,
    SUM(loan_amount) OVER(ORDER BY loan_year, loan_month) AS cumulative_total_loan_amount
FROM
(
    SELECT
        YEAR(StartDate) AS loan_year,
        MONTH(StartDate) AS loan_month,
        SUM(PrincipalAmount) AS loan_amount
    FROM loans
    GROUP BY YEAR(StartDate),
        MONTH(StartDate)
) AS t;