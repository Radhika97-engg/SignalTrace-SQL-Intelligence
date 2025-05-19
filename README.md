# SignalTrace-SQL-Intelligence

**Diagnostic SQL project simulating real-world ECU log analysis for vehicle validation workflows.**  
This repository features 15 SQL queries inspired by LeetCode-style patterns but grounded in **realistic telematics and diagnostic scenarios** relevant for validation engineering, support engineering, and embedded automotive testing.

---

## Project Purpose

This project helps simulate how SQL can be applied in a **vehicle diagnostics context** to:

- Detect overheating or idle anomalies
- Enrich ECU logs with vehicle metadata
- Identify silent ECUs and inactive zones
- Analyze fault distribution by zone and type
- Detect high-risk vehicles and behavioral outliers

It is designed to **bridge LeetCode problems with real-world engineering scenarios**.

---

## Project Structure

```
SignalTrace-SQL-Intelligence/
│
├── Dataset/                      # Mock telemetry datasets (ECU logs, metadata)
├── Query_Documentation/         # Individual markdown files explaining each query
├── Queries/                     # Raw SQL query files (query1.sql, query2.sql, ...)
├── Screenshots/                 # Output screenshots (for GitHub or validation)
│
├── README.md                    # Project overview (this file)
├── leetcode_mapping.md          # Mapping of SQL problems to real-world queries
└── project_pitch.md             # Short summary to explain project value to recruiters
```

---

## Sample Problem → Query Logic

### Problem:
> Retrieve all ECU logs where `severity = HIGH` and `temperature > 80°C`.

### SQL Concepts:
- `SELECT`, `WHERE`, numeric comparison
- Result sorting with `ORDER BY`

### Real-World Relevance:
Used to detect **overheating events**, which are critical in support and validation workflows.

---

## LeetCode-to-Project Mapping

| #  | LeetCode Concept             | SQL Pattern         | Real-World Query                                |
|----|------------------------------|---------------------|--------------------------------------------------|
| 1  | Filter by attributes         | SELECT + WHERE      | High-temp ECU logs                               |
| 2  | Combine two tables           | INNER JOIN          | Metadata enrichment                              |
| 3  | Find missing records         | LEFT JOIN + IS NULL | Silent ECUs                                      |
| 4  | Aggregate by category        | GROUP BY + COUNT    | Fault by type/zone                               |
| 5  | Compare with average         | HAVING + Subquery   | Above-average fault ECUs                         |
| 6  | Categorize values            | CASE WHEN           | RPM or Temp classification                       |
| …  | …                            | …                   | …                                                |

Full mapping in `leetcode_mapping.md`

---

## How to Use

1. Open any SQL editor (MySQL Workbench, SQLite, BigQuery, etc.)
2. Load sample data from `/Dataset`
3. Run queries from `/Queries`
4. Read documentation in `/Query_Documentation`
5. Refer to screenshots for sample output

---

## Use Case 

- Demonstrates **data analysis & diagnostic logic**
- Highlights **validation-relevant insights** (e.g., overheat, silent ECUs)
- Mimics **real-world fleet maintenance SQL**
- Easy to extend with DTC codes, RPM alerts, and CAN log patterns

---

## Future Additions

- RPM anomaly queries
- Fault burst detection using window functions
- UDS failure code simulation
- Timestamp-based diagnostics and message gaps

---

Created by **Radhika Ravindran**  
