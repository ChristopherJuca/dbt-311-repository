{{ config(materialized='table') }}

WITH problem_type_columns AS (
  SELECT DISTINCT
    problem_type,
    problem_detail
  FROM {{ ref('cleaned_311_complaints') }}
  WHERE problem_type IS NOT NULL
)

SELECT
  ROW_NUMBER() OVER () AS problem_type_dimension_id,
  problem_type,
  problem_detail,
  CURRENT_TIMESTAMP() AS loaded_at
FROM problem_type_columns
ORDER BY problem_type, problem_detail