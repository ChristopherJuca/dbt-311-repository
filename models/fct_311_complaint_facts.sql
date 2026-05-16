{{ config(materialized='table') }}

WITH agency_dimension AS (
  SELECT * FROM {{ ref('agency_dimension') }}
),

problem_type_dimension AS (
  SELECT * FROM {{ ref('problem_type_dimension') }}
),

location_dimension AS (
  SELECT * FROM {{ ref('location_dimension') }}
),

date_dimension AS (
  SELECT * FROM {{ ref('date_dimension') }}
),

all_complaints AS (
  SELECT * FROM {{ ref('cleaned_311_complaints') }}
)

SELECT
  agency_dimension.agency_name_dimension_id,
  problem_type_dimension.problem_type_dimension_id,
  location_dimension.location_dimension_id,
  date_dimension.date_dim_id AS date_dimension_id,

  COUNT(*) AS complaint_count,

  CURRENT_TIMESTAMP() AS loaded_at

FROM all_complaints

LEFT JOIN agency_dimension
  ON all_complaints.agency_name = agency_dimension.agency_name

LEFT JOIN problem_type_dimension
  ON all_complaints.problem_type = problem_type_dimension.problem_type
 AND all_complaints.problem_detail = problem_type_dimension.problem_detail

--LEFT JOIN location_dimension
  --ON all_complaints.borough = location_dimension.borough
LEFT JOIN location_dimension
  ON all_complaints.borough = location_dimension.borough
 AND all_complaints.incident_zip = location_dimension.incident_zip
 
LEFT JOIN date_dimension
  ON DATE(all_complaints.created_date) = date_dimension.full_date

GROUP BY
  agency_dimension.agency_name_dimension_id,
  problem_type_dimension.problem_type_dimension_id,
  location_dimension.location_dimension_id,
  date_dimension.date_dim_id