USE enterpriceBankingAnalyticsDB;

-- ========================================================
-- Module 7 — Cross Functional Analytics (Differentiators)
-- ========================================================

-- =================================================
-- 1. City-wise avg balance vs avg loan comparison
-- =================================================
SELECT
    ad.City,
    ROUND(
        AVG(a.Balance),
        2
    ) AS avg_balance,
    ROUND(
        AVG(l.PrincipalAmount),
        2
    ) AS avg_loan_amount
FROM addresses ad 
JOIN customers c 
    ON ad.AddressID=c.AddressID
JOIN accounts a 
    ON c.CustomerID=a.CustomerID
JOIN loans l 
    ON a.AccountID=l.AccountID
GROUP BY ad.City;

-- ==========================================================================
-- 2. Top 10% customers kitna % total balance hold karte hain (Pareto-style)
-- ==========================================================================
-- ========= USING SUBQUERY ============
SELECT
    ROUND(
            SUM(total_balance) * 100.0 / (
            SELECT SUM(Balance) FROM accounts
        ),
        2
    ) AS percentage_hold
FROM
(
    SELECT
        total_balance,
        top_customers
    FROM
    (
        SELECT
            CustomerID,
            FirstName,
            LastName,
            total_balance,
            NTILE(10) OVER(ORDER BY total_balance DESC) AS top_customers
        FROM
        (
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
        ) AS t
    ) AS x 
    WHERE top_customers = 1
) AS y

-- ========= USING CTE ============
WITH customer_amounts AS (
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
),
divide_buckets AS (
    SELECT
        CustomerID,
        FirstName,
        LastName,
        total_balance,
        NTILE(10) OVER(ORDER BY total_balance DESC) AS customer_buckets
    FROM customer_amounts
)

SELECT
    ROUND(
        SUM(total_balance) * 100 / (
            SELECT SUM(Balance) FROM accounts
        ),
        2
    ) AS percentage_hold
FROM divide_buckets
WHERE customer_buckets = 1;
 