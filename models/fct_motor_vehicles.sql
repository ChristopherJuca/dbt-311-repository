{{ config(materialized='table') }}

WITH all_collisions AS (
    SELECT *
    FROM {{ ref('cleaned_motor_vehicles') }}
),

motor_location_dimension AS (
    SELECT *
    FROM {{ ref('motor_location_dimension') }}
),

vehicle_type_dimension AS (
    SELECT *
    FROM {{ ref('vehicle_type_dimension') }}
),

persons_injured_killed_dimension AS (
    SELECT *
    FROM {{ ref('persons_injured_killed_dimension') }}
),

contributing_factor_dimension AS (
    SELECT *
    FROM {{ ref('contributing_factor_dimension') }}
),

date_dimension AS (
    SELECT *
    FROM {{ ref('date_dimension') }}
)

SELECT
    persons_injured_killed_dimension.persons_injury_killed_dimension_id,
    motor_location_dimension.motor_location_dimension_id,
    date_dimension.date_dim_id AS date_dimension_id,
    vehicle_type_dimension.vehicle_type_dimension_id,
    contributing_factor_dimension.contributing_factor_dimension_id,

    COUNT(*) AS total_traffic_collisions,
    COUNT(contributing_factor_dimension.contributing_factor_vehicle_1) AS top_contributing_factor_to_collisions,
    SUM(all_collisions.number_of_persons_killed) AS fatality_rate,

    SAFE_DIVIDE(
        SUM(all_collisions.number_of_persons_injured),
        COUNT(*)
    ) AS injury_rate_per_collision,

    CURRENT_TIMESTAMP() AS loaded_at

FROM all_collisions

LEFT JOIN motor_location_dimension
    ON all_collisions.borough = motor_location_dimension.borough
    AND all_collisions.on_street_name = motor_location_dimension.on_street_name
    AND all_collisions.cross_street_name = motor_location_dimension.cross_street_name
    AND all_collisions.off_street_name = motor_location_dimension.off_street_name

LEFT JOIN vehicle_type_dimension
    ON all_collisions.vehicle_type_code_1 = vehicle_type_dimension.vehicle_type_code_1

LEFT JOIN persons_injured_killed_dimension
    ON all_collisions.number_of_persons_killed = persons_injured_killed_dimension.number_of_persons_killed
    AND all_collisions.number_of_persons_injured = persons_injured_killed_dimension.number_of_persons_injured
    AND all_collisions.number_of_pedestrians_killed = persons_injured_killed_dimension.number_of_pedestrians_killed
    AND all_collisions.number_of_pedestrians_injured = persons_injured_killed_dimension.number_of_pedestrians_injured
    AND all_collisions.number_of_cyclist_killed = persons_injured_killed_dimension.number_of_cyclist_killed
    AND all_collisions.number_of_cyclist_injured = persons_injured_killed_dimension.number_of_cyclist_injured

LEFT JOIN contributing_factor_dimension
    ON all_collisions.contributing_factor_vehicle_1 = contributing_factor_dimension.contributing_factor_vehicle_1

LEFT JOIN date_dimension
    ON all_collisions.crash_date = date_dimension.full_date

GROUP BY
    persons_injured_killed_dimension.persons_injury_killed_dimension_id,
    motor_location_dimension.motor_location_dimension_id,
    date_dimension.date_dim_id,
    vehicle_type_dimension.vehicle_type_dimension_id,
    contributing_factor_dimension.contributing_factor_dimension_id