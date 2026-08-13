# 🏦 Enterprise Banking Analytics Project

**End-to-End Banking Analytics System** — Raw banking data se clean database, advanced SQL analytics, Python EDA aur interactive Power BI dashboard tak ka complete analytics lifecycle.

**Tools:** Python • MySQL • Power BI • SQL • Pandas • Matplotlib • Seaborn

---

## 🚀 Power BI Dashboard Preview

> Click on any image to open the full-size screenshot

[![Dashboard 1](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image1.png)](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image1.png)

[![Dashboard 2](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image2.png)](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image2.png)

[![Dashboard 3](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image3.png)](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image3.png)

[![Dashboard 4](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image4.png)](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image4.png)

[![Dashboard 5](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image5.png)](enterprice-banking-analytics-project/08_screenshots/dashboard_images/dashboard_image5.png)

---

## 📌 Project Overview

Banks generate massive volumes of data daily through customer onboarding, account management, transactions, loans, and branch operations. Raw operational data alone is not enough for strategic decisions.

This project transforms multi-table relational banking data into **actionable business insights** using a complete analytics pipeline:

- Business Understanding  
- Data Understanding & ER Modeling  
- Data Cleaning (Python)  
- Relational Database Design (MySQL)  
- Advanced SQL Business Analysis  
- Exploratory Data Analysis (Python)  
- Interactive Power BI Dashboard  

**Key Focus Areas:**
- Customer Analytics  
- Account Performance  
- Transaction Trends  
- Loan Portfolio Health  
- Branch Performance  

---

## 🛠️ Tech Stack

| Category              | Tools / Technologies                          |
|-----------------------|-----------------------------------------------|
| **Data Cleaning & EDA** | Python, Pandas, NumPy, Matplotlib, Seaborn   |
| **Database**          | MySQL                                         |
| **SQL Analytics**     | Advanced SQL (CTEs, Window Functions, Joins)  |
| **Visualization**     | Power BI                                      |
| **Version Control**   | Git & GitHub                                  |

---

## 📁 Project Structure
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
│   │   └── Power BI dashboard screenshots
│   │
│   └── chart_images/
│       └── Additional analytical charts
│
└── README.md

---

## 📂 Dataset

Multi-table relational banking dataset covering:

- Customers & Customer Types  
- Accounts & Account Types / Statuses  
- Transactions & Transaction Types  
- Loans & Loan Statuses  
- Branches  
- Addresses  

**Cleaned files** are ready for MySQL import and Power BI.

---

## 🔍 Analysis Performed

### 1. Data Cleaning (`data_cleaning.ipynb`)
- Missing value treatment
- Duplicate removal
- Data type correction
- Consistency checks
- Export of cleaned CSVs

### 2. Database Design
- Full relational schema (`schema_design.sql`)
- Primary & Foreign keys
- Proper normalization
- ER Diagram

### 3. SQL Business Analysis (7 Modules)

| Module | Focus |
|--------|-------|
| **01_Executive_KPIs** | Total Customers, Accounts, Transactions, Loan Portfolio, Avg Balance |
| **02_Customer_Analytics** | Customer segments, high-value customers, growth trends |
| **03_Account_Analytics** | Account type popularity, balance distribution, status analysis |
| **04_Transaction_Analytics** | Volume trends, transaction types, monthly patterns |
| **05_Loan_Analytics** | Portfolio health, status distribution, average loan size |
| **06_Branch_Analytics** | Branch performance ranking, transaction volume |
| **07_Cross_Functional** | Multi-table insights across customers, accounts & loans |

### 4. Python EDA (`EDA.ipynb`)
- Deep exploratory analysis
- Statistical summaries
- Visualizations for patterns & anomalies

### 5. Power BI Dashboard
Interactive multi-page dashboard with:
- Executive KPI cards
- Customer & Account insights
- Transaction trends
- Loan portfolio overview
- Branch performance comparison
- Filters & slicers for interactive exploration

---

## 📈 Key Business Questions Answered

- How many active customers & accounts does the bank have?
- Which customer segments contribute the most?
- Which account types are most popular?
- What is the total loan portfolio size & health?
- Which branches process the highest transaction volume?
- What are the monthly transaction trends?
- Which customers hold the highest balances?
- Where should management focus for operational improvement?

---

## ▶️ How to Run / Explore

### 1. Database Setup

Run `schema_design.sql` in **MySQL Workbench**.

```sql
-- Create the database and tables
-- Then load the cleaned CSV files into the respective tables

2. SQL Business Analysis

Open any SQL file from:
05_SQL_Business_Analysis/
Execute the queries in MySQL Workbench after loading the database.

The folder contains analysis for:

Executive KPIs
Customer Analytics
Account Analytics
Transaction Analytics
Loan Analytics
Branch Analytics
Cross-Functional Analytics

3. Python Notebooks

Install the required Python libraries:
pip install pandas numpy matplotlib seaborn
Launch Jupyter Notebook:
jupyter notebook
Then open either:
06_Notebook/EDA.ipynb
Or
06_Notebook/sql_analysis_outputs.ipynb

4. Power BI Dashboard

Open the Power BI file in Power BI Desktop:
07_PowerBI/dashboard.pbix
You can also explore the dashboard screenshots without opening Power BI:
08_screenshots/dashboard_images/

🎯 Skills Demonstrated
End-to-end analytics project ownership
Relational database design & MySQL
Advanced SQL analysis
CTEs and multi-table joins
Aggregations and window functions
Data cleaning & preprocessing with Python
Exploratory Data Analysis (EDA)
Business-oriented insight generation
Interactive dashboard development in Power BI
DAX-based analytical reporting
Data visualization and storytelling
Structured documentation and project organization

👤 Author

codebyavneesh

🔗 Connect With Me
💼 LinkedIn: linkedin.com/in/codebyavneesh
🧑‍💻 Fiverr: fiverr.com/sellers/codebyavneesh
