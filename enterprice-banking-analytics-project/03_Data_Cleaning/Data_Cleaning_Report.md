# Data Cleaning

## Objective

This notebook focuses on cleaning the raw banking datasets before loading them into the MySQL database. The cleaning process ensures that the datasets are accurate, consistent, and ready for SQL analysis and Power BI dashboard development.

---

# Import Required Libraries

The required Python libraries are imported to perform data loading, cleaning, and preprocessing tasks.

---

# Load Dataset

The dataset is loaded into a Pandas DataFrame for further analysis and preprocessing.

---

# Display Sample Records

The first few rows of the dataset are displayed to understand its structure and verify that the data has been loaded correctly.

---

# Check Dataset Information

The dataset information is examined to understand:

- Number of rows and columns
- Column names
- Data types
- Missing values
- Memory usage

---

# Check Dataset Shape

The shape of the dataset is checked to determine the total number of rows and columns.

---

# Check Data Types

The data type of every column is verified to identify incorrect formats that may require conversion.

---

# Summary Statistics

Descriptive statistics are generated to understand the numerical distribution of the dataset.

---

# Check Missing Values

Missing values are identified for every column to determine whether data cleaning is required.

---

# Handle Missing Values

Missing values are handled using appropriate techniques such as:

- Mode
- Forward Fill (ffill)
- Default values
- Other suitable methods depending on the column

---

# Check Duplicate Records

Duplicate rows are identified to avoid redundant information in the dataset.

---

# Remove Duplicate Records

Duplicate records are removed while preserving the original data integrity.

---

# Validate Cleaned Dataset

The dataset is verified again to ensure:

- No unnecessary missing values remain
- Duplicate records have been removed
- Data types are correct
- Dataset is ready for analysis

---

# Export Cleaned Dataset

The cleaned dataset is exported as a new CSV file for loading into the MySQL database.

---

# Conclusion

The dataset has been successfully cleaned and prepared for the next stage of the project. The cleaned files will be used for SQL analysis, exploratory data analysis (EDA), and Power BI dashboard development.