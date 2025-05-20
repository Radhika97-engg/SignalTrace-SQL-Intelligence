# Query 10: ECUs Reporting Under Multiple Vehicle Profiles

### Goal:
Identify ECUs that are linked to **more than one vehicle_id** in the dataset.

---

### Why This Matters:
Each ECU is typically assigned to a **single vehicle**. If the same ECU appears across multiple vehicle IDs, it may indicate:
- **Hardware reuse** or misassignment
- **Backend mapping inconsistencies**
- **Data duplication** or misconfigured loggers

Detecting this ensures **data accuracy** in fault tracing, vehicle behavior analysis, and telematics reporting.

---

### SQL Concepts Used:
- `COUNT(DISTINCT ...)` to detect how many unique vehicles each ECU is linked to
- `GROUP BY` to summarize data per ECU
- `HAVING` clause to filter only ECUs linked to multiple vehicles
- Table joins (`JOIN`) to enrich data from multiple sources

---

### Detection Logic:
| Condition                                 | Action                    |
|------------------------------------------|---------------------------|
| `COUNT(DISTINCT vehicle_id) > 1`         | Flag ECU as duplicated    |

---

### Use Case:
Used in **vehicle diagnostics validation**, **fleet ECU inventory audits**, and **anomaly detection systems** to ensure that ECUs are not incorrectly mapped across multiple vehicle profiles.
