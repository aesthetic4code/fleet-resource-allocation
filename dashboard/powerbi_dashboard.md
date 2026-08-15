# Emergency Fleet Resource Allocation Dashboard

## Power BI Dashboard Design Document


## Dashboard Purpose

The purpose of this dashboard is to provide emergency service leadership with visibility into fleet utilization, station workload, and operational pressure.

The dashboard converts SQL analysis results into executive-level insights for resource planning and performance monitoring.


---

# Target Audience

Primary users:

- Emergency Service Directors
- Operations Managers
- Fleet Coordinators
- Station Commanders


Business decisions supported:

- Fleet workload balancing
- Station performance review
- Resource planning
- Response improvement initiatives


---

# Data Sources


## SQL Data Model


Primary tables:


### fleet_vehicles

Contains:

- Vehicle ID
- Vehicle Type
- Home Station
- Operational Status


### emergency_dispatch

Contains:

- Incident ID
- Vehicle ID
- Incident Type
- Response Minutes
- Dispatch Time

Relationship:

fleet_vehicles
   |
vehicle_id
   |
emergency_dispatch
   |


---

# Dashboard Pages


# Page 1: Executive Overview


## Objective

Provide leadership with a quick operational snapshot.


## KPI Cards


### Total Incidents

Purpose:

Measure overall emergency workload.


### Active Fleet Vehicles

Purpose:

Understand available response capacity.


### Average Response Time

Purpose:

Monitor emergency response efficiency.


### Target Compliance %

Purpose:

Measure percentage of incidents meeting response target.


---

## Visuals


### Fleet Workload Distribution

Chart:

Bar chart


Shows:

- Vehicle workload ranking
- Highest utilization assets


Business Question:

Which vehicles are carrying the highest demand?


---

### Station Operational Status

Chart:

Table / Matrix


Columns:

- Station
- Vehicles
- Dispatches
- Response Time
- Priority Status


Business Question:

Which stations require review?


---

# Page 2: Fleet Performance Analysis


## Objective

Analyze individual vehicle performance.


## Visuals


### Vehicle Dispatch Ranking

Chart:

Horizontal bar chart


Metrics:

- Dispatch count
- Dispatches per vehicle


Purpose:

Identify high workload vehicles.


---

### Response Performance


Chart:

Scatter plot


X-axis:

Vehicle workload


Y-axis:

Average response time


Purpose:

Identify vehicles with both high workload and slower response.


---

# Page 3: Station Pressure Analysis


## Objective

Identify stations experiencing operational pressure.


## Visuals


### Station Pressure Ranking

Chart:

Bar chart


Metrics:

- Resource pressure score
- Priority ranking


---

### Workload vs Response Matrix


Chart:

Scatter plot


X-axis:

Dispatches per vehicle


Y-axis:

Response compliance percentage


Quadrants:


High workload + low compliance:

Priority review


Low workload + high compliance:

Normal operation


---

# Key KPIs


## Fleet Utilization


Formula:

Total Dispatches / Total Vehicles



Purpose:

Measure operational demand per vehicle.


---

## Average Response Time


Formula:

Incidents meeting target / Total incidents * 100



Purpose:

Measure service-level achievement.


---

## Resource Pressure Score


Combines:

- Workload pressure
- Response pressure


Purpose:

Prioritize operational review.


---

# Power BI Data Model


Recommended relationship:

fleet_vehicles

    1

    |

    |

    *

emergency_dispatch



Relationship type:

One-to-many


---

# Recommended DAX Measures


## Total Incidents

```DAX
Total Incidents =
COUNT(emergency_dispatch[incident_id])
```

Average Response Time

Average Response Time =
AVERAGE(emergency_dispatch[response_minutes])

Response Compliance %

Response Compliance % =
DIVIDE(
    COUNTROWS(
        FILTER(
            emergency_dispatch,
            emergency_dispatch[response_minutes] <= 8
        )
    ),
    COUNTROWS(emergency_dispatch)
)

##Dashboard Design Principles

#The dashboard follows:

Minimal clutter
Executive-friendly KPIs
Clear operational hierarchy
Action-focused insights

The goal is not only to display numbers but to answer:

"What operational decision should happen next?"

Future Improvements

Future dashboard enhancements:

Real-Time Monitoring

Connect live dispatch feeds.

Geographic Analysis

Add station coverage maps.

##Predictive Analytics

Forecast future emergency demand.

Machine Learning Integration

#Predict:

  High-risk locations
  Expected response demand
  Resource requirements

##Project Outcome

This dashboard provides emergency leadership with a data-driven view of:

Fleet utilization
Station performance
Response efficiency
Resource pressure

It transforms operational data into actionable intelligence for better emergency service planning.
