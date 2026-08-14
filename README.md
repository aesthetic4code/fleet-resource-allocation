# Fleet Resource Allocation

### Emergency Fleet Analytics & Predictive Resource Management

An operational analytics project focused on improving emergency vehicle allocation, response coverage, and fleet readiness using real-world emergency dispatch data.

## SQL Analysis

The project uses PostgreSQL to analyze emergency fleet operations.

### Query 1: Fleet Workload Analysis

File:
`sql/01_fleet_workload_analysis.sql`

Business Question:

Which vehicles are carrying the highest operational workload?

Analysis Performed:

- Calculated dispatch volume per vehicle
- Measured average response time
- Compared vehicles against fleet workload baseline
- Identified vehicles requiring operational review

Key SQL Techniques:

- Common Table Expressions (CTEs)
- LEFT JOIN
- Aggregation functions
- Window-based analytical thinking
- CASE statements
- Benchmark comparison

Business Value:

Helps emergency operations leaders identify possible fleet imbalance and prioritize resource reviews.

### Query 2: Station Pressure Analysis

File:
`sql/02_station_pressure_analysis.sql`

Business Question:

Which emergency stations require operational review?

Analysis Performed:

- Calculated dispatch workload per vehicle
- Measured station response performance
- Compared stations against fleet averages
- Classified operational pressure levels

Key Metrics:

- Total dispatches
- Vehicles assigned
- Dispatches per vehicle
- Average response time
- Response target compliance

SQL Techniques:

- Multiple CTEs
- LEFT JOIN
- INNER JOIN
- Conditional aggregation
- CASE logic
- Benchmark analysis

Business Value:

Provides emergency management teams with visibility into stations that may require fleet balancing, coverage review, or operational investigation.
