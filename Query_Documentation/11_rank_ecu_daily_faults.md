# Query 11: Rank ECUs by Daily Fault Bursts

### Goal:
Rank ECUs based on the number of fault entries generated **per day**, highlighting which ECUs were the noisiest on each calendar date.

---

### Why This Matters:
Some ECUs may show abnormal or bursty behavior during certain days due to:
- Software glitches
- Environmental stress
- Hardware issues

By assigning daily ranks, engineers can:
- Detect **day-specific spikes**
- Identify **critical ECUs for inspection**
- Build **daily performance dashboards**

---

### SQL Concepts Used:
- `DATE()` function to extract the day from a full timestamp
- `COUNT()` with `GROUP BY` for daily fault aggregation
- `RANK()` window function to assign rankings within each day
- `PARTITION BY` to restart the rank for each day
- `ORDER BY` to determine fault-based ranking

---

### Ranking Logic:
| Condition                          | Result              |
|-----------------------------------|---------------------|
| ECU with highest faults on a day  | Gets `Rank = 1`     |
| Others ranked in descending order | Based on fault count |

---

### Use Case:
Used in **daily test reports**, **automated validation logs**, and **system monitoring dashboards** to focus attention on the most active or error-prone ECUs each day.
