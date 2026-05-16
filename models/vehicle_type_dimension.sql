{{config(materialized = 'table')}}

WITH vehicle_type_columns AS (

    SELECT DISTINCT
        vehicle_type_code_1

    FROM {{ref('cleaned_motor_vehicles')}}

    WHERE vehicle_type_code_1 IS NOT NULL

)

SELECT
    ROW_NUMBER() OVER() AS vehicle_type_dimension_id,
    vehicle_type_code_1,

    CURRENT_TIMESTAMP() AS loaded_at

FROM vehicle_type_columns

ORDER BY vehicle_type_code_1