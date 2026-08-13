USE enterpriceBankingAnalyticsDB;
-- ============================
-- Module-1 Executive Snapshot
-- ============================
-- =====================================================================================
-- 1. Ek hi query mein sab core KPIs (total customers, accounts, transactions, loans, avg  balance, avg loan) — subqueries ya CROSS JOIN se combine karo. (Skill: nested aggregates ek row mein)
-- =====================================================================================
WITH executive_snapshots AS (
    SELECT
        COUNT(DISTINCT c.CustomerID) AS total_customers,
        COUNT(DISTINCT a.AccountID) AS total_accounts,
        COUNT(DISTINCT t.TransactionID) AS total_transactions,
        SUM(l.PrincipalAmount) AS total_loan_amount,
        ROUND(
            AVG(a.Balance),
            2
        ) AS avg_balance,
        ROUND(
            AVG(l.PrincipalAmount),
            2
        ) AS avg_loan_amount
    FROM customers c 
    JOIN accounts a 
        ON c.CustomerID=a.CustomerID
    JOIN transactions t 
        ON a.AccountID=t.AccountOriginID
    JOIN loans l 
        ON l.AccountID=a.AccountID
)

SELECT
    total_customers,
    total_accounts,
    total_transactions,
    total_loan_amount,
    avg_balance,
    avg_loan_amount
FROM executive_snapshots;