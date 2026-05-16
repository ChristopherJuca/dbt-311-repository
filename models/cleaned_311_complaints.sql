{{ config(materialized='table') }}

SELECT
  `Unique Key` AS unique_key,
  `Created Date` AS created_date,
  `Closed Date` AS closed_date,
  `Agency Name` AS agency_name,
  `Problem _formerly Complaint Type_` AS problem_type,
  `Problem Detail _formerly Descriptor_` AS problem_detail,
  `Location Type` AS location_type,
  `Incident Zip` AS incident_zip,
  `Incident Address` AS incident_address,
  City AS city,
  Borough AS borough,
  CURRENT_TIMESTAMP() AS loaded_at
FROM `cis-4400-311-project.nyc_311_raw.311_raw_data-v2`