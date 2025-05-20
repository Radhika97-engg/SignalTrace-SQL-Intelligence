# Query 7: Tag ECU Logs Based on RPM Behavior

### Goal:
Classify each ECU log entry based on **RPM (Revolutions Per Minute)** into categories:
- **Under-Idle**
- **Normal Operation**
- **High Load**
- **Unknown (Missing Data)**

This classification helps flag engine behavior even when severity information is unavailable.

---

### Why This Matters:
Understanding RPM zones allows early detection of anomalies like:
- **Low idle** (possible stalling)
- **Overload conditions**
- **RPM signal loss or sensor issues**

This logic is especially useful in **engine validation**, **driver behavior analysis**, and **fleet diagnostics**.

---

### SQL Concepts Used:
- `CASE WHEN` conditional logic
- `CAST()` for numeric comparison
- `IS NULL` handling
- RPM segmentation using value thresholds

---

### Classification Criteria:
| Condition                         | Tag           |
|----------------------------------|---------------|
| `rpm IS NULL`                    | Unknown       |
| `rpm < 600`                      | Under-Idle    |
| `600 ≤ rpm ≤ 3000`               | Normal        |
| `rpm > 3000`                     | High Load     |

This RPM-based labeling ensures clear categorization of every log row for engine behavior monitoring.
