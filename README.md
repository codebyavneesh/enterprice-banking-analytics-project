# 🏦 Enterprise Banking Analytics Project

### End-to-End Data Analytics Project using MySQL, Python & Power BI

An end-to-end **Enterprise Banking Analytics** project designed to transform raw banking data into actionable business insights using **data cleaning, relational database design, advanced SQL analysis, Python EDA, and interactive Power BI dashboards**.

The project analyzes the banking ecosystem across **11 relational tables** covering customers, customer types, accounts, account types, account statuses, loans, loan statuses, transactions, transaction types, branches, and addresses.

The complete project follows a structured analytics lifecycle:

> **Business Understanding → Data Understanding → Data Cleaning → Database Design → SQL Business Analysis → Python EDA → Power BI → Business Insights**

---

# 📌 Project Overview

Banks generate data across multiple operational areas such as customers, accounts, loans, transactions, and branches.

The challenge is not simply storing this data, but connecting these entities and converting them into insights that can support business decisions.

This project builds a complete analytical solution that answers questions such as:

* Who are the bank's customers?
* What types of customers does the bank serve?
* Which account types contribute the most balance?
* What is the bank's total transaction activity?
* Which branches handle the highest transaction volume?
* What does the loan portfolio look like?
* Which accounts have loan relationships?
* How are customers, accounts, loans, transactions, and branches interconnected?
* Which business areas are performing strongly and where are opportunities for improvement?

The project is designed as a **portfolio-grade data analytics case study**, not simply as a dashboard exercise.

---

# 🎯 Business Objectives

The analysis is organized around five major business domains.

### 👥 Customer Analytics

Understand the customer base, customer types, geographic distribution, and customer-level banking relationships.

### 💳 Account Analytics

Analyze account types, account statuses, balances, account opening trends, and customer-account relationships.

### 🔄 Transaction Analytics

Measure transaction volume, transaction value, transaction types, transaction trends, and account-to-account movement.

### 💰 Loan Analytics

Evaluate the loan portfolio, principal amounts, interest rates, loan statuses, loan duration, and account-level loan relationships.

### 🏢 Branch Analytics

Compare branches using customer activity, transaction activity, loan exposure, and other operational KPIs.

---

# 🧩 Database Overview

The project uses a relational MySQL database:

```sql
enterpriceBankingAnalyticsDB
```

> Note: The database name in the original SQL schema uses `enterpriceBankingAnalyticsDB`. The README uses the project branding **Enterprise Banking Analytics**.

The database contains **11 tables**.

| #  | Table               | Role                                |
| -- | ------------------- | ----------------------------------- |
| 1  | `addresses`         | Stores address information          |
| 2  | `customer_types`    | Stores customer classifications     |
| 3  | `customers`         | Stores customer master data         |
| 4  | `account_types`     | Stores account classifications      |
| 5  | `account_statuses`  | Stores account status values        |
| 6  | `accounts`          | Stores customer account information |
| 7  | `loan_statuses`     | Stores loan status values           |
| 8  | `loans`             | Stores loan information             |
| 9  | `transaction_types` | Stores transaction classifications  |
| 10 | `branches`          | Stores branch information           |
| 11 | `transactions`      | Stores account transaction activity |

---

# 🔗 Data Model & Relationships

The database follows a relational structure with supporting lookup/master tables and core business entities.

```text
                              ┌───────────────┐
                              │   addresses   │
                              └───────┬───────┘
                                      │
                         ┌────────────┴────────────┐
                         │                         │
                         ▼                         ▼
                 ┌───────────────┐          ┌───────────────┐
                 │   customers   │          │    branches   │
                 └───────┬───────┘          └───────┬───────┘
                         │                          │
                         │                          │
               ┌─────────┴─────────┐                │
               │                   │                │
               ▼                   ▼                ▼
       customer_types          accounts       transactions
                                   │             │       │
                    ┌──────────────┼─────────────┘       │
                    │              │                     │
                    ▼              ▼                     ▼
             account_types       loans          transaction_types
                    │              │
                    ▼              ▼
             account_statuses  loan_statuses
```

### Key Relationships

```text
customers → addresses
customers → customer_types

accounts → customers
accounts → account_types
accounts → account_statuses

loans → accounts
loans → loan_statuses

branches → addresses

transactions → accounts (origin)
transactions → accounts (destination)
transactions → branches
transactions → transaction_types
```

### Important Design Detail

The `transactions` table contains two foreign-key relationships to the `accounts` table:

```text
AccountOriginID
AccountDestinationID
```

This allows the project to model **account-to-account fund movement**, making transaction analysis more realistic than a simple single-account transaction table.

---

# 🏗️ Project Architecture

The complete analytics pipeline is structured into eight phases.

```text
                    ┌──────────────────────────┐
                    │ 1. Business Understanding│
                    └────────────┬─────────────┘
                                 ↓
                    ┌──────────────────────────┐
                    │   2. Data Understanding  │
                    └────────────┬─────────────┘
                                 ↓
                    ┌──────────────────────────┐
                    │     3. Data Cleaning     │
                    └────────────┬─────────────┘
                                 ↓
                    ┌──────────────────────────┐
                    │   4. Database Design     │
                    └────────────┬─────────────┘
                                 ↓
                    ┌──────────────────────────┐
                    │ 5. SQL Business Analysis │
                    └────────────┬─────────────┘
                                 ↓
                    ┌──────────────────────────┐
                    │       6. Python EDA      │
                    └────────────┬─────────────┘
                                 ↓
                    ┌──────────────────────────┐
                    │      7. Power BI         │
                    └────────────┬─────────────┘
                                 ↓
                    ┌──────────────────────────┐
                    │     8. Insights &        │
                    │       Visualization      │
                    └──────────────────────────┘
```

---

# 📂 Repository Structure

```text
enterprise-banking-analytics-project/
│
├── 00_Data/
│   ├── raw/
│   │   └── Original raw CSV files
│   │
│   └── cleaned/
│       └── Cleaned datasets ready for database loading
│
├── 01_Business_Understanding/
│   └── Business_Understanding.md
│
├── 02_Data_Understanding/
│   ├── Data_Understanding.md
│   └── ER_Diagram.png
│
├── 03_Data_Cleaning/
│   ├── data_cleaning.ipynb
│   └── Data_Cleaning_Report.md
│
├── 04_Database_Design/
│   ├── schema_design.sql
│   └── ER_Diagram.png
│
├── 05_SQL_Business_Analysis/
│   ├── 01_Executive_KPIs.sql
│   ├── 02_Customer_Analytics.sql
│   ├── 03_Account_Analytics.sql
│   ├── 04_Transaction_Analytics.sql
│   ├── 05_Loan_Analytics.sql
│   ├── 06_Branch_Analytics.sql
│   └── 07_Cross_Functional_Analytics.sql
│
├── 06_Notebook/
│   ├── EDA.ipynb
│   └── sql_analysis_outputs.ipynb
│
├── 07_PowerBI/
│   └── dashboard.pbix
│
├── 08_screenshots/
│   ├── dashboard_images/
│   └── chart_images/
│
└── README.md
```

---

# 🧭 Phase 1 — Business Understanding

The first stage defines the business context and analytical requirements.

The project focuses on understanding:

* Customer base
* Account portfolio
* Transaction behavior
* Loan portfolio
* Branch activity
* Cross-functional relationships

Detailed business requirements are documented in:

```text
01_Business_Understanding/
└── Business_Understanding.md
```

---

# 🔎 Phase 2 — Data Understanding

The datasets are examined before any transformation or database loading.

The analysis includes:

* Dataset structure
* Column definitions
* Data types
* Primary keys
* Foreign keys
* Relationships
* Missing-value assessment
* Duplicate assessment
* Data consistency checks

Documentation:

```text
02_Data_Understanding/
├── Data_Understanding.md
└── ER_Diagram.png
```

### ER Diagram

![Entity Relationship Diagram](02_Data_Understanding/ER_Diagram.png)

---

# 🧹 Phase 3 — Data Cleaning

Raw data is cleaned and prepared before being loaded into MySQL.

### Data Cleaning Activities

* Missing-value analysis
* Duplicate detection
* Data-type validation
* Date standardization
* Numerical-field validation
* Column consistency checks
* Referential integrity preparation
* Dataset standardization

### Deliverables

```text
03_Data_Cleaning/
├── data_cleaning.ipynb
└── Data_Cleaning_Report.md
```

The original raw files remain preserved in:

```text
00_Data/raw/
```

while the processed datasets are stored in:

```text
00_Data/cleaned/
```

---

# 🗄️ Phase 4 — Database Design

A relational MySQL database was created to organize the cleaned banking datasets.

### Database

```sql
CREATE DATABASE enterpriceBankingAnalyticsDB;
```

The schema uses:

* Primary Keys
* Foreign Keys
* Referential Integrity
* Relational Mapping
* Supporting lookup tables
* Transaction relationships
* Customer-account relationships
* Account-loan relationships
* Branch-address relationships

### Database Deliverables

```text
04_Database_Design/
├── schema_design.sql
└── ER_Diagram.png
```

### Database ER Diagram

![Database ER Diagram](04_Database_Design/ER_Diagram.png)

---

# 📊 Phase 5 — SQL Business Analysis

SQL is the core analytical layer of the project.

Instead of writing disconnected queries, the analysis is organized into **seven business-focused modules**.

---

## 01 — Executive KPIs

High-level metrics designed to give an overall view of the bank.

Typical analysis includes:

* Total customers
* Total accounts
* Total account balance
* Total transactions
* Total transaction amount
* Total loans
* Total loan principal

---

## 02 — Customer Analytics

Customer-focused analysis includes:

* Customer count
* Customer type distribution
* Customer demographics
* Customer-address analysis
* Customer account relationships
* Customer balance contribution
* High-value customer analysis
* Customer-level activity

---

## 03 — Account Analytics

Account-focused analysis includes:

* Total accounts
* Account-type distribution
* Account-status distribution
* Average account balance
* Total account balance
* Account opening trends
* Customer-level account analysis

---

## 04 — Transaction Analytics

Transaction analysis includes:

* Transaction count
* Transaction amount
* Transaction type distribution
* Monthly transaction trends
* High-value transactions
* Origin-account analysis
* Destination-account analysis
* Branch-wise transaction activity

---

## 05 — Loan Analytics

Loan analysis includes:

* Total loan count
* Total loan portfolio
* Average principal amount
* Loan status distribution
* Interest-rate analysis
* Loan duration analysis
* Account-level loan relationships
* Loan portfolio trends

---

## 06 — Branch Analytics

Branch-level analysis includes:

* Branch customer activity
* Branch transaction volume
* Branch transaction value
* Branch-level loan exposure
* Branch comparison
* Branch ranking
* Best vs. worst branch performance

---

## 07 — Cross-Functional Analytics

This section combines multiple entities to answer more advanced business questions.

Examples:

```text
Customer + Account
Customer + Loan
Customer + Transaction
Account + Loan
Account + Transaction
Branch + Transaction
Branch + Loan
Customer + Account + Transaction
```

This is where the relational database becomes especially valuable, because meaningful insights can be derived by connecting multiple business areas.

---

# 🧠 SQL Techniques Used

The project demonstrates practical and advanced SQL concepts.

### Relational Analysis

```sql
INNER JOIN
LEFT JOIN
SELF JOIN
```

### Aggregation

```sql
SUM()
COUNT()
AVG()
MIN()
MAX()
```

### Filtering

```sql
WHERE
HAVING
```

### Advanced Querying

```text
Subqueries
Correlated Subqueries
CTEs
CASE WHEN
Conditional Aggregation
```

### Window Functions

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
LAG()
LEAD()
SUM() OVER(...)
```

### Analytical Patterns

```text
Ranking
Running Totals
Period Comparisons
Trend Analysis
Top-N Analysis
Contribution Analysis
Cross-functional Analysis
```

---

# 🐍 Phase 6 — Python EDA

Python is used to perform exploratory analysis and validate analytical findings.

### Libraries

```text
Pandas
NumPy
Matplotlib
```

### Main EDA Areas

* Customer distributions
* Account balances
* Account type analysis
* Transaction trends
* Transaction value analysis
* Loan portfolio exploration
* Branch performance
* Time-based trends
* Data distributions
* Outlier identification

### Notebooks

```text
06_Notebook/
├── EDA.ipynb
└── sql_analysis_outputs.ipynb
```

### `EDA.ipynb`

Used for exploratory analysis, distributions, trends, comparisons, and visual exploration of the banking datasets.

### `sql_analysis_outputs.ipynb`

Used to work with analytical results generated through SQL and visualize important findings.

---

# 📊 Phase 7 — Power BI Dashboard

The final business intelligence layer is developed in **Microsoft Power BI**.

```text
07_PowerBI/
└── dashboard.pbix
```

The dashboard translates the detailed SQL and Python analysis into an interactive business reporting experience.

---

# 📸 Dashboard Preview

> **Replace the filenames below with the exact screenshot filenames stored inside `08_screenshots/dashboard_images/`.**

## 🏦 Executive Overview

![Executive Overview](08_screenshots/dashboard_images/executive_overview.png)

A management-level view of the banking ecosystem using high-level KPIs and performance indicators.

---

## 👥 Customer Analytics

![Customer Analytics](08_screenshots/dashboard_images/customer_analytics.png)

Provides visibility into customer types, customer distribution, account relationships, and customer-level value.

---

## 💳 Account Analytics

![Account Analytics](08_screenshots/dashboard_images/account_analytics.png)

Focuses on account types, account statuses, balances, and account-level trends.

---

## 🔄 Transaction Analytics

![Transaction Analytics](08_screenshots/dashboard_images/transaction_analytics.png)

Analyzes transaction volume, transaction value, transaction types, time trends, and branch-level activity.

---

## 💰 Loan Analytics

![Loan Analytics](08_screenshots/dashboard_images/loan_analytics.png)

Provides insights into loan portfolio size, loan status, principal amounts, interest rates, and loan relationships.

---

## 🏢 Branch Performance

![Branch Performance](08_screenshots/dashboard_images/branch_performance.png)

Compares branches using customer activity, transaction performance, loan exposure, and overall business metrics.

---

# 📈 Additional Chart Gallery

Supporting analytical charts generated during Python EDA and SQL analysis are stored in:

```text
08_screenshots/chart_images/
```

Example:

![Analytical Chart](08_screenshots/chart_images/example_chart.png)

These visualizations provide additional detail behind the insights presented in the dashboard.

---

# 📐 Power BI Analytical Layer

The Power BI reporting layer is designed around reusable business measures rather than relying only on static visuals.

### Analytical Concepts

* KPI development
* Aggregated measures
* Percentage contribution
* Ranking
* Time-based analysis
* Running totals
* Comparative analysis
* Interactive filtering
* Cross-table analysis
* Business-focused storytelling

---

# 💼 Key Business Insights

The project is designed to answer questions from both operational and management perspectives.

### Customer Perspective

Identify high-value customers, understand customer types, and evaluate how customer relationships translate into account activity and balances.

### Account Perspective

Understand which account types and statuses dominate the portfolio and how balances are distributed across the customer base.

### Transaction Perspective

Monitor transaction activity, transaction values, transaction types, account-to-account movement, and branch-level transaction performance.

### Loan Perspective

Evaluate the scale and composition of the loan portfolio, including principal amounts, loan statuses, interest rates, and associated accounts.

### Branch Perspective

Compare branch-level activity across customers, transactions, loans, and other relevant metrics to identify stronger and weaker performers.

### Cross-Functional Perspective

Connect multiple business domains to discover insights that are not visible when customers, accounts, transactions, loans, and branches are analyzed separately.

---

# 🔄 End-to-End Data Analytics Workflow

```text
Raw CSV Files
      │
      ▼
Business Understanding
      │
      ▼
Data Understanding
      │
      ▼
Data Cleaning
      │
      ▼
Cleaned Datasets
      │
      ▼
MySQL Relational Database
      │
      ▼
SQL Business Analysis
      │
      ├──────────────► Executive KPIs
      ├──────────────► Customer Analytics
      ├──────────────► Account Analytics
      ├──────────────► Transaction Analytics
      ├──────────────► Loan Analytics
      ├──────────────► Branch Analytics
      └──────────────► Cross-Functional Analytics
      │
      ▼
Python EDA
      │
      ▼
Power BI
      │
      ▼
Interactive Dashboard
      │
      ▼
Business Insights
```

---

# 🛠️ Technology Stack

| Technology           | Purpose                                     |
| -------------------- | ------------------------------------------- |
| **MySQL**            | Relational database design and SQL analysis |
| **SQL**              | Business analysis and advanced querying     |
| **Python**           | Data cleaning, EDA, and visualization       |
| **Pandas**           | Data manipulation and analysis              |
| **NumPy**            | Numerical analysis                          |
| **Matplotlib**       | Exploratory visualization                   |
| **Jupyter Notebook** | Python analysis environment                 |
| **Power BI**         | Interactive business intelligence dashboard |
| **DAX**              | Analytical measures                         |
| **Git/GitHub**       | Version control and portfolio presentation  |

---

# ⭐ Why This Project Matters

This project demonstrates the ability to work across the **complete data analytics lifecycle**, rather than focusing on a single tool.

It covers:

```text
Business Thinking
       +
Data Preparation
       +
Database Engineering
       +
Advanced SQL
       +
Python Analytics
       +
BI Development
       +
Data Storytelling
```

This makes the project representative of a realistic **Data Analyst workflow** where raw operational data must be transformed into business-ready information.

---

# 🚀 Project Highlights

* Built a relational banking analytics database containing **11 connected tables**.
* Designed and implemented **primary-key and foreign-key relationships** across core banking entities.
* Created a structured analytics workflow spanning **8 project phases**.
* Developed **7 business-focused SQL analysis modules**.
* Applied advanced SQL concepts such as **CTEs, subqueries, joins, aggregations, ranking, window functions, and time-based analysis**.
* Performed exploratory data analysis using **Python, Pandas, NumPy, and Matplotlib**.
* Developed an interactive **Power BI dashboard** for banking performance analysis.
* Combined customer, account, transaction, loan, and branch data for **cross-functional analysis**.
* Documented the complete project lifecycle for reproducibility and portfolio presentation.

---

# 📁 Repository Guide

| Folder                       | Purpose                                     |
| ---------------------------- | ------------------------------------------- |
| `00_Data/`                   | Raw and cleaned source data                 |
| `01_Business_Understanding/` | Business objectives and requirements        |
| `02_Data_Understanding/`     | Dataset understanding and ER diagram        |
| `03_Data_Cleaning/`          | Data-cleaning notebook and report           |
| `04_Database_Design/`        | Database schema and ER diagram              |
| `05_SQL_Business_Analysis/`  | SQL business analysis                       |
| `06_Notebook/`               | Python EDA and SQL output analysis          |
| `07_PowerBI/`                | Power BI dashboard                          |
| `08_screenshots/`            | Dashboard screenshots and analytical charts |

---

# 📄 Resume Version

## Enterprise Banking Analytics | MySQL • Python • Power BI

Developed an end-to-end banking analytics solution using **MySQL, Python, and Power BI** across an **11-table relational database** covering customers, accounts, transactions, loans, branches, and supporting master data. Built **7 business-focused SQL analysis modules** using joins, CTEs, subqueries, aggregations, window functions, and time-based analysis; performed Python-based EDA and developed an interactive Power BI dashboard for executive KPIs, customer, account, transaction, loan, and branch analytics.

---

# 💼 Resume Bullet Points

* Designed an **11-table relational banking database in MySQL**, establishing PK/FK relationships across customers, accounts, transactions, loans, branches, and supporting master tables.
* Developed **7 business-focused SQL analysis modules** covering executive KPIs, customer, account, transaction, loan, branch, and cross-functional analytics.
* Applied advanced SQL techniques including **CTEs, subqueries, joins, window functions, ranking, running totals, and time-based analysis** to solve banking business problems.
* Performed exploratory data analysis using **Python, Pandas, NumPy, and Matplotlib** to identify trends and validate analytical outputs.
* Built an interactive **Power BI dashboard** to analyze banking KPIs, customer activity, account balances, transaction trends, loan portfolio, and branch performance.
* Structured the project across **business understanding, data understanding, cleaning, database design, SQL analysis, EDA, and BI reporting**, demonstrating an end-to-end analytics workflow.

---

# 🧠 Skills Demonstrated

### SQL & Database

```text
MySQL
SQL
Joins
CTEs
Subqueries
Correlated Subqueries
Window Functions
Aggregations
Ranking
Running Totals
Time-Series Analysis
Relational Database Design
Primary Keys
Foreign Keys
```

### Python

```text
Python
Pandas
NumPy
Matplotlib
Data Cleaning
Exploratory Data Analysis
Data Visualization
```

### Power BI

```text
Power BI
DAX
Data Modeling
KPI Development
Interactive Dashboards
Business Reporting
Data Storytelling
```

---

# 🏁 Final Outcome

The final solution transforms raw banking datasets into a structured analytical platform:

> **Raw Data → Clean Data → Relational Database → SQL Analysis → Python EDA → Power BI → Business Insights**

The project demonstrates the practical application of **SQL, Python, database design, data visualization, and business intelligence** to a realistic banking analytics scenario.

---

## 🔗 Connect With Me

* 💼 **LinkedIn:** [linkedin.com/in/codebyavneesh](https://linkedin.com/in/codebyavneesh)
* 🧑‍💻 **Fiverr:** [fiverr.com/sellers/codebyavneesh](https://www.fiverr.com/sellers/codebyavneesh/edit)


# 👨‍💻 Author

## Avneesh Yadav

**Aspiring Data Analyst**

**SQL | Python | Pandas | NumPy | Power BI | DAX | Excel**

---

### 📬 Portfolio Note

This project is built as a complete data analytics case study, with the source data, cleaning process, database schema, SQL analysis, notebooks, Power BI dashboard, and supporting visualizations organized in separate stages for easy exploration.
