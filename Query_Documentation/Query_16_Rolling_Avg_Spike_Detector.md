
# Query 16: Rolling Average RPM Spike Detector

### Goal:
Identify ECU entries where the current RPM is more than 20% higher than the rolling average of the last 5 readings for the same vehicle.

---

### Why This Matters:
- Sudden RPM spikes can indicate erratic engine behavior, sensor faults, or intermittent load problems.
- Detecting these outliers early helps in proactive maintenance and fault isolation.

---

### SQL Concepts Used:
- `AVG()` window function for rolling average calculation
- `PARTITION BY` to group data per vehicle
- `ORDER BY` within the window for time-series context
- `ROWS BETWEEN 4 PRECEDING AND CURRENT ROW` for rolling window
- Filtering on calculated column using subquery

---

### Detection Logic:
| Metric        | Rule Applied                                |
|---------------|----------------------------------------------|
| Rolling Avg   | 5 previous rows including current row        |
| Spike Trigger | Current RPM > 1.2 × rolling average          |

---
### Screenshot Naming: `16_rpm_spike_rolling_avg.png`
