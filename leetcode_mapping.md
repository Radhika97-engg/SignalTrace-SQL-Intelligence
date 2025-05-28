## LeetCode SQL Problem Mapping

### 1. Recyclable and Low Fat Products
- (https://leetcode.com/problems/recyclable-and-low-fat-products/description/)
- Project Mapping: Query 1 – High Severity ECU Logs
- Status: Done
- Concepts: `SELECT`, `WHERE`, `AND`, `ORDER BY`

### 2. Combine Two Tables
- (https://leetcode.com/problems/combine-two-tables/description/)
- Query 2 – Enrich ECU Logs with Metadata
- Status: Done
- Concepts: `LEFT JOIN`, `CASE`, `Alias`

### 3. Customers Who Never Order
- (https://leetcode.com/problems/customers-who-never-order/description/)
- Project Mapping: Standalone analytical logic
- Status: Done
- Concepts: `IS NULL`

### 4. Count Employees/Department
- (https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/)
- Project Mapping: Query 5 – Count Faults by ECU Type or Vehicle Zone
- Status: Done
- Concepts: `GROUP BY`, `COUNT`

### 5. More Than Manager
- (https://leetcode.com/problems/employees-earning-more-than-their-managers/submissions/1638632464/)
- Project Mapping: Query 6 – Faults Above Fleet Average
- Status: Done
- Concepts: `JOIN`, `WHERE`

### 6. Reformat Department Table
- (https://leetcode.com/problems/reformat-department-table/submissions/1639695367/)
- Project Mapping: Query 7 – Tag ECU Logs Based on RPM Behavior
- Status: Done
- Concepts: `SUM(CASE WHEN...)`, `GROUP BY`

### 7. Second Highest Salary
- (https://leetcode.com/problems/second-highest-salary/submissions/1639821464/)
- Project Mapping: Query 8 – Find Second-Most Faulty ECU
- Status: Done
- Concepts: `SUBQUERY`, `ORDER BY`, `LIMIT`, `UNION`
- Notes:
  > This solution includes a fallback `NULL` using `UNION` to handle cases where the second, highest salary does not exist, similar to how we handle missing ECU fault logs.

### 8. Employees With Missing Information
- (https://leetcode.com/problems/employees-with-missing-information/submissions/1640470485/)
- Project Mapping: Query 9 – Vehicles Missing ECU Log Data for More Than 2 Consecutive Days
- Status: Done
- Concepts: `UNION`, `LEFT JOIN`, `IS NULL`, `ORDER BY`
- Notes:
  > This query detects missing data by joining both tables and checking `NULL` conditions, very similar to identifying inactive ECUs.

### 9. Duplicate Emails
- (https://leetcode.com/problems/duplicate-emails/submissions/1645471418/)
- Project Mapping: Query 10 – ECUs Reporting Under Multiple Vehicle Profiles
- Status: Done
- Concepts: GROUP BY, HAVING, COUNT, duplicate detection
- Notes:
  > This query identifies repeated values by grouping on the email field and filtering using HAVING COUNT , It directly aligns with how we identify ECUs linked to multiple vehicle profiles, helping surface duplication or misconfiguration issues in both datasets.

