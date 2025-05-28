
# Query 12: Top 3 Faulty Logs Per Vehicle

### Goal:
For each vehicle in the dataset, retrieve the **three most recent fault log entries** based on the `timestamp` field.

---

### Why This Matters:
This query highlights the most **recent diagnostic events** per vehicle and is useful for:
- Detecting high-frequency fault patterns
- Monitoring recent system behavior
- Triggering real-time maintenance alerts

---

### SQL Concepts Used:
- `ROW_NUMBER()` window function
- `PARTITION BY` to treat each vehicle separately
- `ORDER BY timestamp DESC` to fetch the latest logs
- Subquery (derived table) with a filter `WHERE rank <= 3`

---

### Ranking Logic:
| Condition                                | Result            |
|-----------------------------------------|-------------------|
| Newest log for a vehicle                | `rank = 1`        |
| Second newest                           | `rank = 2`        |
| Third newest                            | `rank = 3`        |
| Older logs                              | Filtered out      |

---

### Use Case:
This query is especially useful in:
- Vehicle diagnostics dashboards
- Maintenance alerting systems
- ECU behavior trace analysis

---

### Screenshot: 12_top3_fault_logs_per_vehicle_result.png`

---
