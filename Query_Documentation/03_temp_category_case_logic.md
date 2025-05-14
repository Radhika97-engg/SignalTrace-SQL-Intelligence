Query Goal:
Classify ECU logs based on temp values into Normal, Warning, or Overheat ranges.

Why This Matters:
Even when the system’s severity label is missing or inconsistent, this derived classification helps simulate alerting rules, mimicking what embedded engineers might build.

SQL Concepts Used:
CASE WHEN inside SELECT
Derived virtual column
Labeling sensor data dynamically