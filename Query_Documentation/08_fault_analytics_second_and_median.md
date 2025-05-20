# Query 8: Identify Second-Most Faulty Vehicle

### Goal:
Identify the vehicle that has the **second-highest number of fault log entries** in the `ecu_logs` table.

---

### Why This Matters:
While the most faulty vehicle often gets immediate attention, the second-most faulty one may be just as critical:
- It might be **on the verge of failure**
- It may reflect **systemic issues** affecting multiple vehicles
- It’s an excellent candidate for **preventive maintenance**

---

### SQL Concepts Used:
- `COUNT()` and `GROUP BY` to count faults per vehicle
- Subquery to retrieve the **maximum fault count**
- Filter with `HAVING < MAX()` to exclude the topmost
- `LIMIT 1` to return the second-highest

---

### Use Case:
Used in **maintenance prioritization systems** or **automated escalation queues** where tracking "close-second" vehicles is important.

---

# Query 8B: Vehicles with Fault Count Above Fleet Median

### Goal:
Retrieve vehicles whose **fault count is higher than the median** fault count across the fleet.

---

### Why This Matters:
Median-based filtering:
- Reduces the effect of **extreme outliers**
- Captures the **upper half** of fault-heavy vehicles
- Ensures **balanced alerting**

---

### SQL Concepts Used:
- **Window functions** like `ROW_NUMBER() OVER ()`
- Nested subqueries to compute median rank
- `HAVING` clause for upper-half selection
- `CAST()` to safely handle median index calculation

---

### Use Case:
Used in **diagnostic scoring models**, **fleet analytics dashboards**, or **predictive maintenance systems** where you need to highlight consistently underperforming vehicles without letting extreme outliers skew the results.
