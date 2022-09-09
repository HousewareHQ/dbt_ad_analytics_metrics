
{{ config(materialized='view') }}

WITH ga4_traffic_source_medium AS
  (
    SELECT *
    FROM {{ source('google_analytics_4', var('ga4_traffic_source_medium_report')) }}
  )

select * from ga4_traffic_source_medium
