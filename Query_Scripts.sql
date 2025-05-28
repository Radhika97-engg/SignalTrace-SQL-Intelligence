--QUERY 1: High-Severity ECU Overheat Logs
--PROBLEM STATEMENT : Retrieve all ECU log entries where the severity is marked as HIGH and the temperature exceeds 80°C.

SELECT temp,
       severity,
       timestamp
FROM ecu_logs
WHERE CAST (temp AS INTEGER) > 80 
   AND severity = 'HIGH'
ORDER BY timestamp DESC;

--Query 2: Enrich ECU Logs with Vehicle Metadata
--PROBLEM STATEMENT : Combine the ECU logs with vehicle details so that we can analyze fault patterns based on vehicle type and geographic zone
SELECT el.vehicle_id,
       vm.vehicle_type,
       vm.zone,
       el.temp,
       el.rpm
FROM ecu_logs AS el
INNER JOIN vehicle_metadata AS vm
ON el.vehicle_id = vm.vehicle_id;

--Query 3: Categorize Temperature Ranges
--PROBLEM STATEMENT: Classify each ECU log based on the temp value into categories like:'Normal', 'Warning', 'Overheat'
--helps flag severity even when severity field is missing or delayed
SELECT vehicle_id,
       timestamp,
       temp,
       severity,
       CASE 
           WHEN CAST (temp AS INTEGER) <= 80 THEN 'Normal'
           WHEN CAST (temp AS INTEGER) > 80 AND CAST (temp AS INTEGER) <=100 THEN 'Warning'
           WHEN CAST (temp AS INTEGER) > 100 THEN 'Overheat'
       ELSE 'Unknown'
       END AS Temp_category
FROM ecu_logs

--Query 4: Identify Silent ECUs Without Logs  
--PROBLEM STATEMENT: Retrieve all ECU entries from the vehicle metadata that have not generated any log entries in the ECU log table.  
--This helps flag ECUs that may be inactive, disconnected, or not yet integrated into the logging system.

SELECT v.vehicle_id
FROM vehicle_metadata AS v
LEFT JOIN ecu_logs AS e
ON e.vehicle_id = v.vehicle_id
WHERE e.vehicle_id IS NULL;

--Query 5: Count Faults by ECU Type or Vehicle Zone
--PROBLEM STATEMENT: Calculate the number of faults reported by each vehicle group, categorized by ECU type or geographic zone.
--This helps identify which types of vehicles or operational areas are experiencing more frequent faults and may need targeted maintenance.

--5.1 High-level trends 
SELECT v.vehicle_type,
       COUNT(e.fault_code) AS fault_count
FROM ecu_logs AS e
LEFT JOIN vehicle_metadata AS v
ON e.vehicle_id = v.vehicle_id
GROUP BY v.vehicle_type
ORDER BY fault_count DESC;

--5.2 Detailed fault distribution by zone
SELECT v.zone,
       v.vehicle_type,
       COUNT(e.fault_code) AS fault_count
FROM ecu_logs AS e
LEFT JOIN vehicle_metadata AS v
ON e.vehicle_id = v.vehicle_id
GROUP BY v.zone, v.vehicle_type
ORDER BY fault_count DESC;

--Query 6: Identify Vehicles with Fault Counts Above Average
--PROBLEM STATEMENT: Identify all vehicles whose total number of reported faults is higher than the average number of faults across the entire fleet.
--This helps flag potential problem vehicles for early inspection or preventive maintenance.

SELECT vehicle_id,fault_count
FROM (
      SELECT vehicle_id, 
             COUNT(*) AS fault_count 
      FROM ecu_logs
      GROUP BY vehicle_id
      ) AS vehicle_fault
WHERE fault_count > (SELECT  AVG (fault_count)
FROM  (
      SELECT vehicle_id, 
             COUNT(*) AS fault_count 
      FROM ecu_logs
      GROUP BY vehicle_id
      )AS avg_table
)
      
--Query 7: Tag ECU Logs Based on RPM Behavior  
--PROBLEM STATEMENT: Classify ECU log entries using RPM thresholds to indicate behavioral zones like Under-Idle, Normal Operation, and High Load.  
--Helps in identifying engine anomalies (e.g., low idling) even when severity data is not available.  

SELECT vehicle_id,
       timestamp,
       rpm,
       CASE 
           WHEN rpm IS NULL THEN 'Unknown'
           WHEN CAST(rpm AS INTEGER) < 600 THEN 'Under-Idle'
           WHEN CAST(rpm AS INTEGER) BETWEEN 600 AND 3000 THEN 'Normal'
           WHEN CAST(rpm AS INTEGER) > 3000 THEN 'High Load'
           ELSE 'Unknown'
       END AS rpm_status
FROM ecu_logs;


--Query 8: Find Second-Most Faulty ECU  
--PROBLEM STATEMENT: Retrieve the vehicle_id and fault count of the ECU that has the second-highest number of fault log entries in the ecu_logs table.  
--This helps identify high-risk vehicles that are nearly as problematic as the top fault generator — often a priority in preventative maintenance strategies.  
SELECT vehicle_id,
       COUNT(*) AS fault_count
FROM ecu_logs
GROUP BY vehicle_id
HAVING COUNT(*) < (
SELECT MAX(fault_count)
FROM(
SELECT vehicle_id,
       COUNT (fault_code) AS fault_count
FROM ecu_logs
GROUP BY  vehicle_id
ORDER BY fault_count DESC
) AS fault_counts
)
ORDER BY fault_count DESC
LIMIT 1;

--Query 8B: Vehicles with Fault Count Above the Fleet Median  
--PROBLEM STATEMENT: Retrieve the vehicle_ids whose total number of fault logs is greater than the **median fault count** across all vehicles in the ecu_logs table.  
--This approach avoids skewed results caused by outliers and helps identify the true "upper half" of high-activity or high-risk vehicles.  

SELECT vehicle_id, COUNT(*) AS fault_count
FROM ecu_logs
GROUP BY vehicle_id
HAVING COUNT(*) > (
    SELECT fault_count
    FROM (
        SELECT vehicle_id,
               COUNT(*) AS fault_count,
               ROW_NUMBER() OVER (ORDER BY COUNT(*)) AS rn
        FROM ecu_logs
        GROUP BY vehicle_id
    ) AS rows_ranked
    WHERE rn = (
        SELECT CAST((COUNT(DISTINCT vehicle_id)+1)/2 AS INTEGER)
        FROM ecu_logs
    )
)
ORDER BY fault_count DESC;

--Query 9: Vehicles Missing ECU Log Data for More Than 2 Consecutive Days  
--PROBLEM STATEMENT: Identify the vehicle_ids from the ecu_logs table that have not reported any log entries for periods longer than 3 consecutive days.  
--This query helps flag inactive, disconnected, or potentially faulty ECUs that may be silently failing or offline, which is critical for ensuring continuous diagnostics and system reliability.  
SELECT *
FROM (
    SELECT vehicle_id,
       timestamp,
       LAG(timestamp) OVER ( PARTITION BY vehicle_id ORDER BY timestamp) AS prev_timestamp
    FROM ecu_logs
    ) AS lagged_data
WHERE JULIANDAY(timestamp)-JULIANDAY(prev_timestamp) > 2;


--Query 10: ECUs Reporting Under Multiple Vehicle Profiles  
--PROBLEM STATEMENT: Identify ECUs (e.g., based on ecu_id or ecu_serial) that are linked to more than one vehicle_id in the dataset.  
--This query helps flag duplicate or misassigned ECUs which may indicate hardware reuse, logging configuration errors, or database mapping inconsistencies.  
SELECT e.ecu_id,
       COUNT(DISTINCT e.vehicle_id) AS vehicle_count
FROM ecu_logs AS e
JOIN vehicle_metadata AS v
ON e.vehicle_id = v.vehicle_id
GROUP BY ecu_id
HAVING  vehicle_count > 1;

--Query 11: Rank ECUs by Daily Fault Bursts  
--PROBLEM STATEMENT: For each calendar day, identify ECUs that generated fault logs and rank them by the total number of fault entries reported.  
--This query helps flag ECUs exhibiting bursty or abnormal behavior during specific days, useful for spotting stress-induced failures, or hardware inconsistencies.  
SELECT ecu_id,
       DATE(timestamp) AS DATE,
       COUNT(fault_code) AS fault_enteries,
       RANK() OVER (
              PARTITION BY DATE(timestamp)
              ORDER BY COUNT(fault_code) DESC
              ) AS daily_rank
FROM ecu_logs
GROUP BY ecu_id, DATE;


--Query 12: Top 3 Faulty Logs Per Vehicle
--PROBLEM STATEMENT: For each vehicle in the dataset, retrieve the three most recent fault log entries based on the timestamp field.
--This query helps highlight the most recent diagnostic events per vehicle and is useful for identifying high-frequency fault patterns, monitoring system behavior, and triggering real-time alerts.

SELECT *
FROM (
  SELECT vehicle_id,
         timestamp,
         fault_code,
         ROW_NUMBER() OVER (
           PARTITION BY vehicle_id
           ORDER BY timestamp DESC
         ) AS rank
  FROM ecu_logs
) AS ranked_logs
WHERE rank <= 3;

--Query 13: Detect Sudden RPM Drops in Time-Series Logs  
--PROBLEM STATEMENT: For each vehicle in the ecu_logs table, detect instances where the current RPM has dropped significantly (e.g., more than 1000 units) compared to the previous entry.  
--This query helps identify engine misfires, stalling conditions, or abnormal transitions in engine load, enabling proactive diagnostics and safety alerts.
SELECT *
FROM(
SELECT vehicle_id,
       rpm,
       LAG(rpm) OVER (PARTITION BY vehicle_id ORDER BY timestamp) AS prev_rpm
FROM ecu_logs) AS RPM_LAG
WHERE prev_rpm - rpm > 1000;

--Query 14: Root Cause Zones with CTE-Based Fault Tracing
--PROBLEM STATEMENT: Using CTEs, trace all ECU fault logs back to vehicle zones and summarize which zones are most frequently associated with system faults. Helps prioritize investigations based on geographic or operational zone trends.
WITH fault_logs_with_zone AS(
        SELECT v.zone,
        COUNT(e.fault_code) AS fault_count
FROM ecu_logs AS e
LEFT JOIN vehicle_metadata AS v
ON e.vehicle_id = v.vehicle_id
GROUP BY v.zone
)
SELECT *
FROM fault_logs_with_zone 
ORDER BY fault_count DESC;

--Query 15: NULL Handling – Clean Null Values in Log Messages
--PROBLEM STATEMENT: Clean and standardize NULL values in ECU log entries by replacing them with meaningful defaults (e.g., 'Unknown', 0, or 'Not Reported').
--This ensures consistent reporting, prevents data loss in visualizations, and improves downstream diagnostic accuracy during log analysis.
SELECT
  log_id,
  vehicle_id,
  -- Replace fault_code NULLs
  CASE WHEN fault_code IS NULL OR fault_code = '' THEN 'No Code' ELSE fault_code END AS cleaned_fault_code,
  
  -- Replace rpm NULLs
  CASE WHEN rpm IS NULL OR rpm ='' THEN 0 ELSE rpm END AS cleaned_rpm,
  
  -- Replace temp NULLs
  CASE WHEN temp IS NULL OR temp='' THEN 0  ELSE temp END AS cleaned_temp,
  
  -- Replace severity NULLs
  CASE WHEN severity IS NULL OR severity ='' THEN 'Unknown' ELSE severity END AS cleaned_severity

FROM ecu_logs;
       














