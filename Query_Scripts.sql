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




