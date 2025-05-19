
# Query 6: Vehicles with Fault Counts Above Fleet Average

### Goal:
Identify vehicles whose **total fault count is above the fleet-wide average** — these are early candidates for inspection or root cause analysis.

### Why This Matters:
This query flags **outlier vehicles** that may be:
- Malfunctioning frequently
- Operating in harsher conditions
- Needing immediate attention

Used in **fleet diagnostics dashboards** and **alert systems**.

### SQL Concepts Used:
- Subqueries (nested)
- `AVG()` aggregate in subquery
- Outer filtering with `WHERE`
- Structured breakdown into layers:
  - Layer 1: Compute fault counts per vehicle
  - Layer 2: Compute average
  - Layer 3: Compare & filter
