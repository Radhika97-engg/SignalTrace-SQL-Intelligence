
# Query 4: Identify Silent ECUs Without Logs

### Goal:
Retrieve all ECU entries from the vehicle metadata table that have **not generated any log entries** in the `ecu_logs` table.

### Why This Matters:
Silent ECUs may indicate:
- Devices not yet integrated
- Disconnected systems
- Faulty sensors/modules

Such ECUs can be flagged for investigation, making this query crucial in **system health monitoring**.

### SQL Concepts Used:
- `LEFT JOIN`
- `IS NULL`
- Relational completeness checks
