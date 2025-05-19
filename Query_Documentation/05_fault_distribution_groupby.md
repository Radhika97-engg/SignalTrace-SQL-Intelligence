
# Query 5: Count Faults by ECU Type or Zone

### Goal 5.1:
Count number of fault logs grouped by **vehicle type** to understand high-risk categories.

### Goal 5.2:
Break down faults by **vehicle type + geographic zone** for more granular insights.

### Why This Matters:
- Enables **data-driven preventive maintenance**
- Highlights fault-prone zones or vehicle categories
- Supports risk-based prioritization of fixes

### SQL Concepts Used:
- `LEFT JOIN`
- `GROUP BY`
- `COUNT()`
- Multi-column grouping (`GROUP BY zone, vehicle_type`)
