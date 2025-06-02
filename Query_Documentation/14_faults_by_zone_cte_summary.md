
# Query 14: Root Cause Zones with CTE-Based Fault Tracing

### Goal:
Trace all ECU fault logs back to their corresponding **vehicle zones** and summarize which zones are most frequently associated with system faults.

---

### Why This Matters:
Understanding which **geographic or operational zones** are generating more faults can help in:
- Prioritizing **maintenance efforts** in high-fault regions
- Identifying **environmental impacts** on electronic systems
- Supporting **root cause analysis** for zone-specific failures

---

### SQL Concepts Used:
- **Common Table Expression (CTE)**: Simplifies complex queries
- **LEFT JOIN**: Combines logs with metadata (even if some logs don’t match)
- **GROUP BY**: Aggregates fault counts by zone
- **ORDER BY**: Ranks zones by fault count for prioritization

---

### Fault Analysis Example:
| Zone       | Fault Count |
|------------|-------------|
| North-East | 120         |
| West       | 95          |
| Central    | 40          |

---

### Use Case:
This query supports **validation engineers**, **fleet maintenance teams**, and **QA auditors** looking to identify environmental trends or repeated failure zones.

---

### Screenshot Naming: `14_faults_by_zone_cte_summary.png`

---

