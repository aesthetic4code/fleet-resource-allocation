/*
=========================================================
Project: Fleet Resource Allocation
File: 01_fleet_workload_analysis.sql

Purpose:
Analyze emergency fleet vehicle workload and response
performance.

Business Question:
Which vehicles are carrying the highest operational
workload and how does their response performance compare?

Author:
Sajid Ali

Tools:
PostgreSQL SQL

=========================================================
*/


-- =======================================================
-- 1. Vehicle Workload Analysis
-- =======================================================

WITH vehicle_workload AS (

    SELECT

        f.vehicle_id,

        f.vehicle_type,

        f.home_station,

        COUNT(d.incident_id) AS total_dispatches,

        ROUND(
            AVG(d.response_minutes),
            2
        ) AS average_response_minutes


    FROM fleet_vehicles AS f


    LEFT JOIN emergency_dispatch AS d

        ON f.vehicle_id = d.vehicle_id


    GROUP BY

        f.vehicle_id,

        f.vehicle_type,

        f.home_station
),



-- =======================================================
-- 2. Compare Vehicle Workload Against Fleet Average
-- =======================================================

fleet_average AS (

    SELECT

        AVG(total_dispatches)
            AS average_vehicle_dispatches

    FROM vehicle_workload

)



-- =======================================================
-- 3. Final Vehicle Performance Output
-- =======================================================

SELECT


    vw.vehicle_id,

    vw.vehicle_type,

    vw.home_station,


    vw.total_dispatches,


    ROUND(
        fa.average_vehicle_dispatches,
        2
    ) AS fleet_average_dispatches,


    ROUND(

        100.0 *

        (
            vw.total_dispatches
            -
            fa.average_vehicle_dispatches
        )

        /

        fa.average_vehicle_dispatches,

        2

    ) AS workload_difference_percent,


    vw.average_response_minutes,


    CASE

        WHEN vw.total_dispatches >
             fa.average_vehicle_dispatches * 1.25

             AND vw.average_response_minutes > 8

            THEN 'HIGH PRIORITY'


        WHEN vw.total_dispatches >
             fa.average_vehicle_dispatches * 1.25

            THEN 'HIGH WORKLOAD'


        WHEN vw.average_response_minutes > 8

            THEN 'RESPONSE PRESSURE'


        ELSE 'NORMAL'

    END AS operational_status



FROM vehicle_workload AS vw


CROSS JOIN fleet_average AS fa


ORDER BY

    CASE

        WHEN vw.total_dispatches >
             fa.average_vehicle_dispatches * 1.25

             AND vw.average_response_minutes > 8

            THEN 1


        WHEN vw.total_dispatches >
             fa.average_vehicle_dispatches * 1.25

            THEN 2


        WHEN vw.average_response_minutes > 8

            THEN 3


        ELSE 4

    END,


    vw.total_dispatches DESC;
