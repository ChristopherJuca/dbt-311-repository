{{config(materialized = 'table')}}

WITH vehicle_type_columns AS (
    select distinct 
        vehicle_type_code_1,
        vehicle_type_code_2
        
    from {{ref('cleaned_motor_vehicles')}}

    where vehicle_type_code_1 IS NOT NULL

)

select 
    row_number() over() AS vehicle_type_dimension_id,
    vehicle_type_code_1, vehicle_type_code_2,

    CURRENT_TIMESTAMP() AS loaded_at

    from vehicle_type_columns
    ORDER BY vehicle_type_code_1,vehicle_type_code_2


