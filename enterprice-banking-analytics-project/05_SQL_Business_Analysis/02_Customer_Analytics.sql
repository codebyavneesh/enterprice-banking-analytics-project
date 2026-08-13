USE enterpriceBankingAnalyticsDB;

-- ==============================
-- Module 2 — Customer Analytics
-- ==============================

-- ======================================
-- 1. Customers having multiple accounts
-- ======================================
SELECT
    CustomerID,
    FirstName,
    LastName,
    multiple_accounts
FROM
(
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        COUNT(*) AS multiple_accounts
    FROM customers c 
    JOIN accounts a 
        ON c.CustomerID=a.CustomerID
    GROUP BY c.CustomerID,
        c.FirstName,
        c.LastName
) AS t 
WHERE multiple_accounts>1
ORDER BY multiple_accounts DESC;

-- ===========================
-- 2. Customers without loans
-- ===========================
SELECT
    CustomerID,
    FirstName,
    LastName,
    loan_amount
FROM
(
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        COALESCE(SUM(l.PrincipalAmount), 0) AS loan_amount
    FROM customers c 
    JOIN accounts a 
        ON c.CustomerID=a.CustomerID
    LEFT JOIN loans l 
        ON a.AccountID=l.AccountID
    GROUP BY c.CustomerID,
        c.FirstName,
        c.LastName
) AS t 
WHERE loan_amount = 0;

-- =====================================
-- 3. top 10 customers by total balance
-- =====================================
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(a.Balance) AS total_balance
FROM customers c 
JOIN accounts a 
    ON c.CustomerID=a.CustomerID
GROUP BY c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY total_balance DESC
LIMIT 10;

-- ==========================================================================
-- 4. Age-band segmentation (18-25, 26-40, etc.) ke hisab se average balance
-- ==========================================================================
SELECT
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE())> 60 THEN '60+'
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) > 40 AND TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) <= 60 THEN '41-60' 
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) > 25 AND TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) <= 40 THEN '26-40' 
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) > 17 AND TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) <= 25 THEN '18-25' 
        ELSE '18-'
    END AS age_segment,
    ROUND(
        AVG(a.Balance),
        2
    ) AS avg_balance
FROM customers c 
JOIN accounts a 
    ON c.CustomerID=a.CustomerID
GROUP BY age_segment;

-- =====================================================
-- 5. Monthly new-customer acquisition ka running total
-- =====================================================
WITH new_customers_acquisition AS (
    SELECT
        YEAR(OpeningDate) AS year,
        MONTH(OpeningDate) AS Month_no,
        MONTHNAME(OpeningDate) AS Month_Name,
        COUNT(*) AS new_customers
    from accounts 
    GROUP BY YEAR(OpeningDate),
        MONTH(OpeningDate),
        MONTHNAME(OpeningDate)
)
SELECT
    year,
    Month_Name
    new_customers,
    SUM(new_customers) OVER(ORDER BY year, Month_no) AS acquisition_running_total
FROM new_customers_acquisition
ORDER BY year, Month_no