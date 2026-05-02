{{ config(materialized='table') }}

WITH motor_location_columns AS (
    SELECT DISTINCT
        borough,
        on_street_name,
        cross_street_name,
        off_street_name
    FROM {{ ref('cleaned_motor_vehicles') }}
    WHERE borough IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER () AS motor_location_dimension_id,
    borough,
    on_street_name,
    cross_street_name,
    off_street_name,
    CURRENT_TIMESTAMP() AS loaded_at
FROM motor_location_columns
ORDER BY borough, on_street_name, cross_street_name, off_street_name