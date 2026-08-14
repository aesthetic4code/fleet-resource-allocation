/*
=========================================================
Project:
Fleet Resource Allocation

File:
03_resource_allocation_recommendation.sql

Purpose:
Generate a final resource allocation review ranking
for emergency service stations.

Business Question:
Which stations should management review first
for potential fleet balancing?

Author:
Sajid Ali

Database:
PostgreSQL

=========================================================
*/


-- =======================================================
-- 1. Station Workload Metrics
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
-- 2. Station Response Metrics
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
-- 3. Fleet Benchmark
-- =======================================================

fleet_baseline AS (

    SELECT


        AVG(sw.dispatches_per_vehicle)

            AS avg_dispatches_per_vehicle,


        AVG(sr.target_compliance_percent)

            AS avg_target_compliance



    FROM station_workload AS sw


    JOIN station_response AS sr

        ON sw.home_station = sr.home_station
),



-- =======================================================
-- 4. Create Priority Score
-- =======================================================

station_priority AS (

    SELECT


        sw.home_station,


        sw.vehicle_count,


        sw.total_dispatches,


        sw.dispatches_per_vehicle,


        sr.average_response_minutes,


        sr.target_compliance_percent,



        ROUND(

            (

                sw.dispatches_per_vehicle

                /

                fb.avg_dispatches_per_vehicle

                *

                50

            )

            +

            (

                (100 - sr.target_compliance_percent)

                /

                (100 - fb.avg_target_compliance)

                *

                50

            ),

            2

        ) AS resource_pressure_score



    FROM station_workload AS sw


    JOIN station_response AS sr

        ON sw.home_station = sr.home_station


    CROSS JOIN fleet_baseline AS fb
)



-- =======================================================
-- 5. Final Allocation Recommendation
-- =======================================================

SELECT


    home_station,


    vehicle_count,


    total_dispatches,


    dispatches_per_vehicle,


    average_response_minutes,


    target_compliance_percent,


    resource_pressure_score,



    RANK() OVER (

        ORDER BY resource_pressure_score DESC

    ) AS priority_rank,



    CASE


        WHEN resource_pressure_score >= 120

            THEN 'HIGH PRIORITY REVIEW'


        WHEN resource_pressure_score >= 100

            THEN 'OPERATIONAL REVIEW'


        ELSE 'NORMAL MONITORING'


    END AS recommended_action



FROM station_priority


ORDER BY

    priority_rank;
