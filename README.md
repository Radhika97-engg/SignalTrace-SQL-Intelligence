# SignalTrace-SQL-Intelligence

This repository simulates real-world automotive diagnostics using SQL-based fault analysis over a vehicle telemetry dataset. The project applies **data engineering, validation logic, and diagnostic thinking** to solve business-relevant scenarios in the automotive industry, especially in **embedded systems**, **vehicle validation**, and **diagnostic logging** domains.

---

## Project Objective

To design a **diagnostic query framework** that mirrors real ECU (Electronic Control Unit) fault behavior—using **SQL** to detect **overheating**, **missing data**, **abnormal RPM behavior**, and **validation exceptions** in vehicle fleets.

The aim is not just to write LeetCode-style SQL but to **simulate the thought process of a validation/test engineer** diagnosing issues in live telematics data.

---

## What This Project Demonstrates

| Capability | Description |
|------------|-------------|
| Fault Identification | Detects overheat conditions, repeated errors, and RPM anomalies |
| Data Aggregation | Groups faults by zone, type, and frequency for actionable insights |
| Behavioral Monitoring | Tracks fault bursts, silent ECUs, and vehicle trends |
| Data Cleaning | Cleans null or blank values to prepare logs for analytics |
| Real-World Diagnostics | Uses window functions and conditional logic as used in embedded/validation tools |

---

## Project Structure

```
SignalTrace-SQL-Intelligence/
│
├── Dataset/                      # Simulated ECU logs and metadata
├── Query_Documentation/         # Markdown files explaining query logic
├── Screenshots/                 # Output screenshots of SQL results
├── Query_Scripts.sql            # All queries in one file
├── leetcode_mapping.md          # LeetCode-to-Project mapping (Query 1 to 16)
├── project_pitch.md             # Why this project matters to validation engineers
└── README.md                    # Current file (Project Overview)
```

---

## Real-World Query Highlights (Query 1 to 16)

| Query # | Real-World Task | SQL Concepts | Diagnostic Value |
|---------|-----------------|--------------|------------------|
| 1 | High severity + overheat detection | `WHERE`, `CAST()` | Early warning of thermal failure |
| 4 | Silent ECUs with no logs | `LEFT JOIN`, `IS NULL` | Spot disconnected/unused ECUs |
| 6 | Faults above fleet average | `HAVING`, `Subquery` | Identify vehicles for preventive maintenance |
| 9 | Log gaps > 2 days | `LAG()`, `JULIANDAY()` | Detect inactive or faulty ECUs |
| 11 | Daily fault bursts | `RANK()`, `PARTITION BY` | Time-based diagnostic spikes |
| 16 | Rolling average RPM spike | `AVG() OVER`, `ROWS BETWEEN` | Anomaly detection on engine load |

---

## LeetCode-Inspired, Industry-Aligned

This project **maps 10 LeetCode problems** (like “Rank Scores”, “Second Highest Salary”, “Duplicate Emails”) to **automotive fault logic**, bridging theoretical SQL patterns with **diagnostic business use cases**.

For full mapping → [leetcode_mapping.md](./leetcode_mapping.md)

---

## Business Use Cases

- **Telematics Analysis**: Analyze CAN/ECU logs for embedded system validation
- **System Validation**: Support automated validation teams in logging anomalies
- **OEM Reporting**: Create structured fault summaries across fleet zones/types
- **Fault Prioritization**: Identify root cause trends (zones, ECUs, spike patterns)
- **Diagnostic Tooling**: Inspire queries for real tools like CANalyzer, CANoe

---

## Created By

**Radhika Ravindran**  
Validation & Embedded QA Enthusiast | Data-Driven Thinker | GitHub: [@Radhika97-engg](https://github.com/Radhika97-engg)

---

## How To Use

1. Load `Dataset/` tables in your SQL client (SQLiteStudio, MySQL, etc.)
2. Run queries from `Query_Scripts.sql`
3. Open `Query_Documentation/` to understand the problem logic
4. View output screenshots in `Screenshots/` for visual validation
