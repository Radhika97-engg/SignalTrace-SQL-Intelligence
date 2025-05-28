
# Query 13: Detect Sudden RPM Drops in Time-Series Logs

### Goal:
Detect instances in ECU logs where a **vehicle's RPM drops significantly** (e.g., more than 1000 units) compared to the previous log entry for the same vehicle.

---

### Why This Matters:
Sudden RPM drops can indicate issues like:
- Engine **misfires**
- **Stalling** conditions
- **Transmission or load transition** faults

These patterns are often early signs of mechanical or electronic problems.

---

### SQL Concepts Used:
- `LAG()` window function to get the previous RPM value
- `PARTITION BY` to isolate each vehicle's log sequence
- `ORDER BY timestamp` to ensure chronological order
- Conditional `WHERE` clause to filter significant drops

---

### Detection Logic:
| Current RPM | Previous RPM | Drop > 1000? | Action      |
|-------------|---------------|---------------|-------------|
| 600         | 2000          | Yes           | Include row |
| 1500        | 1600          | No            | Skip row    |

---

### Use Case:
This query is ideal for **engine diagnostics**, **fleet monitoring**, and **predictive maintenance** systems that track and alert on unusual operational patterns.

---

### Screenshot Naming: `13_rpm_drop_sudden_change_result.png`
