
# Query 15: NULL Handling – Clean Null Values in Log Messages

### Goal:
Clean and standardize NULL or blank values in ECU log entries by replacing them with meaningful defaults. This ensures consistent reporting, prevents data loss in visualizations, and improves downstream diagnostic accuracy.

---

### Why This Matters:
- In real-world datasets, missing or null values can cause errors in processing and inconsistencies in reporting.
- Normalizing null fields ensures accurate analysis and better fault traceability.

---

### SQL Concepts Used:
- `CASE WHEN` conditional handling
- NULL and empty string detection (`IS NULL`, `=''`)

---

### Replacement Strategy:
| Field      | NULL Replacement | Reason                    |
|------------|------------------|----------------------------|
| fault_code | 'No Code'        | Helps distinguish no-code issues |
| rpm        | 0                | Neutral value for analysis |
| temp       | 0                | Ensures calculations remain valid |
| severity   | 'Unknown'        | Indicates missing classification |

---

### Query:

```sql
SELECT
  log_id,
  vehicle_id,
  -- Replace fault_code NULLs
  CASE WHEN fault_code IS NULL OR fault_code = '' THEN 'No Code' ELSE fault_code END AS cleaned_fault_code,
  
  -- Replace rpm NULLs
  CASE WHEN rpm IS NULL OR rpm ='' THEN 0 ELSE rpm END AS cleaned_rpm,
  
  -- Replace temp NULLs
  CASE WHEN temp IS NULL OR temp='' THEN 0  ELSE temp END AS cleaned_temp,
  
  -- Replace severity NULLs
  CASE WHEN severity IS NULL OR severity ='' THEN 'Unknown' ELSE severity END AS cleaned_severity

FROM ecu_logs;
```

---
### Screenshot Naming: `15_null_cleaning_result.png