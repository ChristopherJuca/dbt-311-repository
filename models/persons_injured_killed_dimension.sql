{{config(materialized='table')}}


WITH persons_injured_columns AS(
    SELECT distinct
        number_of_persons_killed,
        number_of_persons_injured,
        number_of_pedestrians_killed,
        number_of_pedestrians_injured,
        number_of_cyclist_killed,
        number_of_cyclist_injured

    from {{ref('cleaned_motor_vehicles')}}
) 


select 
    row_number() over() as persons_injury_killed_dimension_id,
     number_of_persons_killed,
     number_of_persons_injured,
     number_of_pedestrians_killed,
     number_of_pedestrians_injured,
     number_of_cyclist_killed,
     number_of_cyclist_injured
     CURRENT_TIMESTAMP() AS loaded_at

     from persons_injured_columns
     ORDER BY number_of_persons_killed, number_of_persons_injured

