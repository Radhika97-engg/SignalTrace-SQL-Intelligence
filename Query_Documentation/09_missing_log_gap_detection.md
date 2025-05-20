# Query 9: Vehicles Missing ECU Log Data for More Than 2 Consecutive Days

### Goal:
Detect vehicles that have gaps of **more than 2 consecutive days** between ECU log entries.

---

### Why This Matters:
In real-world diagnostics, a vehicle that stops reporting log data for several days may be:
- **Inactive**
- **Disconnected from the network**
- **Experiencing silent hardware failure**
- **Misconfigured or shut down**

This query is essential for **continuous system monitoring**, especially in connected fleets and automotive validation environments.

---

### SQL Concepts Used:
- `LAG()` window function to access the previous log timestamp
- `PARTITION BY` to analyze each vehicle’s timeline separately
- `JULIANDAY()` to compute date differences
- Subquery to enable column reference in the `WHERE` clause

---

### Gap Detection Logic:
| Condition                                    | Action                        |
|---------------------------------------------|-------------------------------|
| `timestamp - prev_timestamp > 2 days`       | Flagged for review            |
| `NULL prev_timestamp` (first entry)         | Ignored in result             |

---

### Use Case:
Used in **real-time telemetry systems**, **offline vehicle monitoring**, and **automated alerting dashboards** to identify possible communication failures or abnormal inactivity in ECU reporting.
