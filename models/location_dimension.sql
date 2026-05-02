{{config (materialized = 'table')}}

WITH location_columns AS (
    select DISTINCT
        borough,
        incident_zip,
        location_type,
        city,
        incident_address
    FROM {{ref('cleaned_311_complaints')}}
    WHERE borough IS NOT NULL
)

SELECT
  ROW_NUMBER() OVER () AS location_dimension_id,
  borough,
  incident_zip,
  location_type,
  city,
  incident_address,
  CURRENT_TIMESTAMP() AS loaded_at
FROM location_columns
ORDER BY borough, incident_zip, city, incident_address