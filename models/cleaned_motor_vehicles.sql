{{ config(materialized='table') }}

SELECT
  `CRASH DATE` AS crash_date,
  `CRASH TIME` AS crash_time,
  `BOROUGH` AS borough,
  `ON STREET NAME` AS on_street_name,
  `CROSS STREET NAME` AS cross_street_name,
  `OFF STREET NAME` AS off_street_name,
  `NUMBER OF PERSONS INJURED` AS number_of_persons_injured,
  `NUMBER OF PERSONS KILLED` AS number_of_persons_killed,
  `NUMBER OF PEDESTRIANS INJURED` AS number_of_pedestrians_injured,
  `NUMBER OF PEDESTRIANS KILLED` AS number_of_pedestrians_killed,
  `NUMBER OF CYCLIST INJURED` AS number_of_cyclist_injured,
  `NUMBER OF CYCLIST KILLED` AS number_of_cyclist_killed,
  `CONTRIBUTING FACTOR VEHICLE 1` AS contributing_factor_vehicle_1,
  `VEHICLE TYPE CODE 1` AS vehicle_type_code_1,
  `VEHICLE TYPE CODE 2` AS vehicle_type_code_2,
  CURRENT_TIMESTAMP() AS loaded_at
FROM `cis-4400-311-project.nyc_311_raw.motor_vehicle_raw_data`