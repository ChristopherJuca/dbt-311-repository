{{ config(materialized='table') }}

WITH contributing_factor_columns AS (

    SELECT DISTINCT
        contributing_factor_vehicle_1
    /* need to add contribu_factor_2 on dataset then add it here */

    FROM {{ ref('cleaned_motor_vehicles') }}

    WHERE contributing_factor_vehicle_1 IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER () AS contributing_factor_dimension_id,
    contributing_factor_vehicle_1,
    /* need to add contribu_factor_2 on dataset then add it here */ 
    CURRENT_TIMESTAMP() AS loaded_at

FROM contributing_factor_columns

ORDER BY contributing_factor_vehicle_1 /* need to add contribu_factor_2 on dataset then add it here */