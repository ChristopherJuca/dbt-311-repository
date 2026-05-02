{{ config(materialized='table') }}

WITH agency_columns AS (
  SELECT DISTINCT
    agency_name
  FROM {{ ref('cleaned_311_complaints') }}
  WHERE agency_name IS NOT NULL
)

SELECT
  ROW_NUMBER() OVER () AS agency_name_dimension_id,
  agency_name,
  CURRENT_TIMESTAMP() AS loaded_at
FROM agency_columns
ORDER BY agency_name