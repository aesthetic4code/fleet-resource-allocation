/*
=========================================================
Project: Fleet Resource Allocation

File:
02_station_pressure_analysis.sql

Purpose:
Analyze emergency station workload, fleet capacity,
and response performance.

Business Question:
Which stations are experiencing operational pressure
based on workload per vehicle and response compliance?

Author:
Sajid Ali

Database:
PostgreSQL

=========================================================
*/


-- =======================================================
-- 1. Calculate Station Workload
-- =======================================================

WITH station_workload AS (

    SELECT

        f.home_station,


        COUNT(DISTINCT f.vehicle_id)
            AS vehicle_count,


        COUNT(d.incident_id)
            AS total_dispatches,


        ROUND(

            COUNT(d.incident_id)::numeric

            /

            COUNT(DISTINCT f.vehicle_id),

            2

        ) AS dispatches_per_vehicle


    FROM fleet_vehicles AS f


    LEFT JOIN emergency_dispatch AS d

        ON f.vehicle_id = d.vehicle_id


    GROUP BY

        f.home_station
),



-- =======================================================
-- 2. Calculate Station Response Performance
-- =======================================================

station_response AS (

    SELECT


        f.home_station,


        ROUND(

            AVG(d.response_minutes),

            2

        ) AS average_response_minutes,



        ROUND(

            100.0 *

            COUNT(*) FILTER (

                WHERE d.response_minutes <= 8

            )

            /

            COUNT(*),

            2

        ) AS target_compliance_percent



    FROM emergency_dispatch AS d


    JOIN fleet_vehicles AS f

        ON d.vehicle_id = f.vehicle_id


    GROUP BY

        f.home_station
),



-- =======================================================
-- 3. Fleet Baseline Calculation
-- =======================================================

fleet_baseline AS (

    SELECT


        AVG(sw.dispatches_per_vehicle)

            AS fleet_average_workload,


        AVG(sr.target_compliance_percent)

            AS fleet_average_compliance



    FROM station_workload AS sw


    JOIN station_response AS sr

        ON sw.home_station = sr.home_station
)



-- =======================================================
-- 4. Final Station Pressure Analysis
-- =======================================================

SELECT


    sw.home_station,


    sw.vehicle_count,


    sw.total_dispatches,


    sw.dispatches_per_vehicle,


    ROUND(

        fb.fleet_average_workload,

        2

    ) AS fleet_average_workload,



    sr.average_response_minutes,


    sr.target_compliance_percent,


    ROUND(

        sr.target_compliance_percent

        -

        fb.fleet_average_compliance,

        2

    ) AS compliance_difference_points,



    CASE


        WHEN sw.dispatches_per_vehicle >
             fb.fleet_average_workload

             AND

             sr.target_compliance_percent <
             fb.fleet_average_compliance

            THEN 'HIGH OPERATIONAL PRESSURE'



        WHEN sw.dispatches_per_vehicle >
             fb.fleet_average_workload

            THEN 'WORKLOAD PRESSURE'



        WHEN sr.target_compliance_percent <
             fb.fleet_average_compliance

            THEN 'RESPONSE PRESSURE'



        ELSE 'NORMAL'


    END AS station_status



FROM station_workload AS sw


JOIN station_response AS sr

    ON sw.home_station = sr.home_station


CROSS JOIN fleet_baseline AS fb



ORDER BY


    CASE

        WHEN sw.dispatches_per_vehicle >
             fb.fleet_average_workload

             AND

             sr.target_compliance_percent <
             fb.fleet_average_compliance

            THEN 1


        WHEN sw.dispatches_per_vehicle >
             fb.fleet_average_workload

            THEN 2


        WHEN sr.target_compliance_percent <
             fb.fleet_average_compliance

            THEN 3


        ELSE 4


    END,


    sw.dispatches_per_vehicle DESC;
