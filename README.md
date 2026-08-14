# 🚒 Fleet Resource Allocation Analytics

## Emergency Services Fleet Optimization Using SQL, Python & Power BI


![Project Banner](images/dashboard_preview.png)


## 📌 Executive Summary

Emergency service organizations depend on efficient fleet deployment to maintain fast response times and reliable coverage.

This project analyzes emergency fleet operations to identify:

- Vehicle workload imbalance
- Station-level operational pressure
- Response performance challenges
- Potential resource allocation review areas


Using PostgreSQL SQL analysis, the project transforms raw dispatch data into operational insights that can support evidence-based fleet management decisions.


---

# 🎯 Business Problem

Emergency service managers need answers to questions such as:

- Which vehicles are handling the highest workload?
- Which stations experience operational pressure?
- Are response times meeting performance targets?
- Where should fleet resources be reviewed?


Traditional reporting often focuses only on incident counts.

This project goes further by analyzing:

- Workload per vehicle
- Station capacity
- Response-time compliance
- Relative performance against fleet benchmarks


---

# 🏗️ Project Architecture

Emergency Dispatch Data
    ↓
Fleet Vehicle Data
    ↓
SQL Data Modeling
    ↓
Vehicle Analysis
    ↓
Station Analysis
    ↓
Resource Allocation Recommendations
    ↓
Executive Dashboard



---

# 🗂️ Dataset Description

The project uses simulated emergency service operational data.

## Tables


### fleet_vehicles

Contains fleet asset information.

| Column | Description |
|---|---|
| vehicle_id | Unique vehicle identifier |
| vehicle_type | Emergency vehicle category |
| home_station | Assigned station |
| operational_status | Current availability status |


---

### emergency_dispatch

Contains incident dispatch records.

| Column | Description |
|---|---|
| incident_id | Unique incident identifier |
| vehicle_id | Assigned response vehicle |
| incident_type | Type of emergency |
| response_minutes | Response duration |
| dispatch_time | Dispatch timestamp |


---

# 🛠️ Technologies Used


## SQL

- PostgreSQL
- Common Table Expressions (CTEs)
- JOIN operations
- Aggregations
- Window functions
- CASE statements
- Benchmark analysis


## Data Analytics

- Operational KPI development
- Performance comparison
- Resource prioritization
- Business intelligence thinking


## Visualization

- Power BI dashboard development
- Executive KPI reporting


---

# 📊 SQL Analysis


## Query 1: Fleet Workload Analysis

File:
sql/01_fleet_workload_analysis.sql



### Business Question

Which vehicles are carrying the highest operational workload?


### Analysis Performed

- Calculated dispatch volume by vehicle
- Measured average response time
- Compared vehicles against fleet workload averages
- Classified operational workload status


### Output

Vehicle-level operational assessment:

- HIGH PRIORITY
- HIGH WORKLOAD
- RESPONSE PRESSURE
- NORMAL


---

# Query 2: Station Pressure Analysis


File:
sql/02_station_pressure_analysis.sql



### Business Question

Which stations are experiencing operational pressure?


### Analysis Performed

- Calculated dispatches per vehicle
- Measured station response performance
- Compared stations against fleet averages
- Identified workload and response pressure


### Key Metrics

- Total dispatches
- Vehicle count
- Dispatches per vehicle
- Average response time
- Target compliance percentage


---

# Query 3: Resource Allocation Recommendation


File:
sql/03_resource_allocation_recommendation.sql



### Business Question

Where should emergency fleet resources receive operational review?


### Analysis Performed

- Combined workload and response indicators
- Created resource pressure scoring
- Ranked stations by priority
- Generated review categories


### Final Output

- Priority ranking
- Resource pressure score
- Recommended operational action


---

# 📈 Key Performance Indicators


The project evaluates:


## Fleet Workload

Dispatches per Vehicle


Measures how much operational demand each vehicle handles.


---

## Response Performance

Average Response Minutes


Measures emergency response efficiency.


---

## Target Compliance

% Responses Meeting Target Time


Measures service-level performance.


---

## Resource Pressure Score

Combines:

- Workload pressure
- Response pressure

to identify stations requiring further review.


---

# 💡 Business Insights

The analysis framework helps emergency management teams:

✅ Identify overloaded vehicles

✅ Detect stations with workload imbalance

✅ Understand response-time challenges

✅ Support evidence-based resource planning


---

# ⚠️ Project Limitations

This analysis identifies operational patterns but does not automatically determine staffing or fleet expansion decisions.

Real-world deployment would also consider:

- Geographic coverage
- Population density
- Incident severity
- Vehicle availability
- Crew staffing
- Budget constraints


---

# 📁 Repository Structure

fleet-resource-allocation/

│
├── README.md

│
├── sql/

│ ├── 01_fleet_workload_analysis.sql

│ ├── 02_station_pressure_analysis.sql

│ └── 03_resource_allocation_recommendation.sql

│
├── python/

│ └── fleet_analysis.ipynb

│
├── dashboard/

│ └── powerbi_dashboard.md

│
├── analysis/

│ └── findings.md

│
└── images/
 └── dashboard_preview.png

 

---

# 🚀 Future Improvements

Future development plans:

- Predict emergency demand using machine learning
- Build station coverage optimization model
- Add geographic risk mapping
- Create Power BI executive dashboard
- Develop predictive resource allocation model


---

# 👨‍🚒 About This Project

Created by Sajid Ali

Data Analyst Portfolio Project

Domain Focus:

- Emergency Services Analytics
- Operational Intelligence
- Fleet Optimization
- Public Safety Data


---

# 📬 Contact

LinkedIn:
https://linkedin.com/in/sajidalich

GitHub:
https://github.com/aesthetic4code
