WITH agency_columns AS
(
  SELECT DISTINCT
    agency,
    agency_name
  FROM {{ ref('raw_311_complaints') }}
  WHERE agency IS NOT NULL
)

SELECT
  ROW_NUMBER() OVER () AS agency_name_dimension_id,
  agency,
  agency_name,
  CURRENT_TIMESTAMP() AS loaded_at
FROM agency_columns
ORDER BY agency, agency_name