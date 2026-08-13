-- ===================
-- Database Creation
-- ===================
CREATE DATABASE enterpriceBankingAnalyticsDB;

-- ==============
-- Use Database
-- ==============
USE enterpriceBankingAnalyticsDB;

SHOW TABLES;
-- =======================
-- Create addresses table
-- =======================
CREATE TABLE addresses(
    AddressID INT PRIMARY KEY AUTO_INCREMENT,
    Street VARCHAR(100),
    City VARCHAR(100),
    Country VARCHAR(100)
);

-- ============================
-- Create customer_types table
-- ============================
CREATE TABLE customer_types(
    CustomerTypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(100)
);

-- =======================
-- Create customers table
-- =======================
CREATE TABLE customers(
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(110),
    DateOfBirth DATETIME,
    AddressID INT,
    CustomerTypeID INT,

    Foreign Key (AddressID) REFERENCES addresses(AddressID),
    Foreign Key (CustomerTypeID) REFERENCES customer_types(CustomerTypeID)
);

-- ===========================
-- Create account_types table
-- ===========================
CREATE TABLE account_types(
    AccountTypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(100)
);

-- ==============================
-- Create account_statuses table
-- ==============================
CREATE TABLE account_statuses(
    AccountStatusID INT PRIMARY KEY AUTO_INCREMENT,
    StatusName VARCHAR(100)
);

-- ======================
-- Create accounts table
-- ======================
CREATE TABLE accounts(
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    AccountTypeID INT,
    AccountStatusID INT,
    Balance DECIMAL(15, 2),
    OpeningDate DATETIME,

    Foreign Key (CustomerID) REFERENCES customers(CustomerID),
    Foreign Key (AccountTypeID) REFERENCES account_types(AccountTypeID),
    Foreign Key (AccountStatusID) REFERENCES account_statuses(AccountStatusID)
);

-- ============================
-- Create loan_statuses table
-- ============================
CREATE TABLE loan_statuses(
    LoanStatusID INT PRIMARY KEY AUTO_INCREMENT,
    StatusName VARCHAR(100)
);

-- ===================
-- Create loans table
-- ===================
CREATE TABLE loans(
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    LoanStatusID INT,
    PrincipalAmount DECIMAL(15, 2),
    InterestRate DECIMAL(5, 2),
    StartDate DATETIME,
    EstimatedEndDate DATETIME,

    Foreign Key (AccountID) REFERENCES accounts(AccountID),
    Foreign Key (LoanStatusID) REFERENCES loan_statuses(LoanStatusID)
);

-- ===============================
-- Create transaction_types table
-- ===============================
CREATE TABLE transaction_types(
    TransactionTypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(100)
);

-- ======================
-- Create branches table
-- ======================
CREATE TABLE branches(
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100),
    AddressID INT,

    Foreign Key (AddressID) REFERENCES addresses(AddressID)
);

-- ==========================
-- Create transactions table
-- ==========================
CREATE TABLE transactions(
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountOriginID INT,
    AccountDestinationID INT,
    TransactionTypesID INT,
    Amount DECIMAL(15, 2),
    TransactionDate DATETIME,
    BranchID INT,
    Description VARCHAR(255),

    Foreign Key (AccountOriginID) REFERENCES accounts(AccountID),
    Foreign Key (AccountDestinationID) REFERENCES accounts(AccountID),
    Foreign Key (BranchID) REFERENCES branches(BranchID),
    Foreign Key (TransactionTypesID) REFERENCES transaction_types(TransactionTypeID)
);
