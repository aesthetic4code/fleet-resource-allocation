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
